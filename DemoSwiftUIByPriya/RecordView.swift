//
//  RecordView.swift
//  DemoSwiftUIByPriya
//
//  Created by Priya Hansaliya on 22/07/24.
//

import SwiftUI

struct RecordView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    RecordView()
}

import SwiftUI
import AVFoundation
import Speech

class SpeechRecognizer: ObservableObject {
    private let speechRecognizerEnglish = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
    private let audioEngine = AVAudioEngine()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTaskEnglish: SFSpeechRecognitionTask?
    
    @Published var recognizedText: String = ""
    @Published var isRecording: Bool = false
    @Published var isError: Bool = false
    
    func startRecording() {
        if isRecording { return }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.record, mode: .default, options: .defaultToSpeaker)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("Audio session setup error: \(error.localizedDescription)")
            return
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else {
            print("Unable to create SFSpeechAudioBufferRecognitionRequest object")
            return
        }
        
        recognitionRequest.shouldReportPartialResults = true
        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
            recognitionRequest.append(buffer)
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
            isRecording = true
        } catch {
            print("Audio engine couldn't start: \(error.localizedDescription)")
            return
        }
        
        recognitionTaskEnglish = speechRecognizerEnglish?.recognitionTask(with: recognitionRequest) { result, error in
            if let result = result {
                self.recognizedText = result.bestTranscription.formattedString
            }
            if error != nil {
                self.stopRecording()
                self.isError = true
            }
        }
    }
    
    func stopRecording() {
        if !isRecording { return }
        audioEngine.stop()
        recognitionRequest?.endAudio()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionTaskEnglish?.cancel()
        recognitionTaskEnglish = nil
        isRecording = false
    }
    
    func requestSpeechPermission() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            DispatchQueue.main.async {
                switch authStatus {
                case .authorized:
                    // Permission granted, now check microphone permission
                    self.requestMicrophonePermission()
                case .denied, .restricted, .notDetermined:
                    // Handle other cases
                    self.isError = true
                @unknown default:
                    self.isError = true
                }
            }
        }
    }
    
    private func requestMicrophonePermission() {
        switch AVAudioSession.sharedInstance().recordPermission {
        case .granted:
            self.startRecording()
        case .denied:
            self.isError = true
        case .undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission { granted in
                DispatchQueue.main.async {
                    if granted {
                        self.startRecording()
                    } else {
                        self.isError = true
                    }
                }
            }
        @unknown default:
            self.isError = true
        }
    }
}

struct LiveRadioView: View {
    @StateObject private var speechRecognizer = SpeechRecognizer()
    
    var body: some View {
        VStack {
            if speechRecognizer.isRecording {
                Text("Listening...")
            } else {
                Text("Press to start recording")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .onTapGesture {
                        if speechRecognizer.isRecording {
                            speechRecognizer.stopRecording()
                        } else {
                            speechRecognizer.requestSpeechPermission()
                        }
                    }
            }
            
            Text(speechRecognizer.recognizedText)
                .padding()
            
            if speechRecognizer.isError {
                Text("An error occurred. Please try again.")
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
}

struct ContentView: View {
    var body: some View {
        LiveRadioView()
    }
}
