//
//  TextToSpeechView.swift
//  DemoSwiftUIByPriya
//
//  Created by Priya Hansaliya on 14/08/24.
//

import SwiftUI
import AVFoundation

enum LanguageCodes : String, CaseIterable{
    case english = "en"
    case hindi = "hi"
    case marathi = "mr"
    case gujarati = "gu"
    case urdu = "ur"
    case dogri = "do"
    case assamese = "as"
    case rajasthani = "ra"
    case bangla = "bn"
    
    var plistName : String {
        switch self {
        case .english: return "EnglishLocalization"
        case .hindi: return "HindiLocalization"
        case .marathi: return "MarathiLocalization"
        case .gujarati: return "GujaratiLocalization"
        case .urdu: return "UrduLocalization"
        case .dogri: return "HindiLocalization"
        case .assamese: return "AssameseLocalization"
        case .rajasthani: return "HindiLocalization"
        case .bangla: return "BanglaLocalization"
        }
    }
    
    var languageId : String {
        switch self {
        case .english: return "1"
        case .hindi: return "2"
        case .marathi: return "3"
        case .gujarati: return "4"
        case .urdu: return "5"
        case .dogri: return "6"
        case .assamese: return "7"
        case .rajasthani: return "8"
        case .bangla: return "9"
        }
    }
    
    var strNotificationTopics : String {
        switch self {
        case .english: return "En"
        case .hindi: return "Hi"
        case .marathi: return "Mr"
        case .gujarati: return "Gu"
        case .urdu: return "Ur"
        case .dogri: return "Do"
        case .assamese: return "As"
        case .rajasthani: return "Ra"
        case .bangla: return "Bn"
        }
    }
}

//struct TextToSpeechView: View {
//    // Initialize the speech synthesizer
//    let speechSynthesizer = AVSpeechSynthesizer()
//    
//    // Text to be spoken
//    let text = "Thankfully, there is a solution, and it’s not that hard to implement. "
//    
//    var body: some View {
//        VStack {
//            Button(action: {
//                self.speakText()
//            }) {
//                Text("Tap here")
//                    .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
//            }
//            
//            HStack{
//                Text("Add").font(.body).padding()
//                    .showCase(
//                    order: 0,
//                    img: .heartNewFill,
//                    title: "Add",
//                    cornerRadius: 15,
//                    style: .continuous,
//                    scale:1.2,
//                    isCapsule: true
//                )
//                Spacer()
//                Text("Remove").font(.body).padding()
//                    .showCase(
//                        order:1,
//                        img: .tree,
//                        title: "Remove",
//                        cornerRadius: 15,
//                        style: .continuous,
//                        scale:1.2,
//                        isCapsule: true
//                    )
//            }.padding()
//            
//            Button(action: {
//                self.speakText()
//            }) {
//                Text(text)
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(8)
//            }
//        }
//        .padding()
//        .modifier(ShowCaseRoot(showHighLight: true, onFinished: {
//           print("finish")
//        }))
//    }
//    
//    func speakText() {
//        // Create an utterance
//        let utterance = AVSpeechUtterance(string: text)
//        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
//        
//        // Speak the utterance
//        speechSynthesizer.speak(utterance)
//    }
//}

