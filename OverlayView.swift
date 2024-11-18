//
//  OverlayView.swift
//  DemoSwiftUIByPriya
//
//  Created by Priya Hansaliya on 16/10/24.
//

import SwiftUI

struct ShowPopUpView: View {
    @State private var showOverlay = false
    
    var body: some View {
        ZStack {
            // Main Content
            VStack {
                Text("Hello, SwiftUI!")
                    .font(.largeTitle)
                    .padding()
                
                Button(action: {
                    showOverlay.toggle()
                }) {
                    Text("Show Overlay")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
            
            // Overlay
            if showOverlay {
                overlayView()
            }
        }
    }
    
    @ViewBuilder
    private func overlayView() -> some View {
        Color.black.opacity(0.5) // Semi-transparent background
            .edgesIgnoringSafeArea(.all) // Cover the entire screen
        
        VStack {
            Text("This is an Overlay")
                .font(.headline)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
            
            Button(action: {
                showOverlay = false // Dismiss the overlay
            }) {
                Text("Dismiss")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.top, 20)
        }
        .frame(maxWidth: 300) // Set a maximum width for the overlay
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 10)
    }
}

#Preview {
    ShowPopUpView()
}
