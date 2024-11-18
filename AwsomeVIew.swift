//
//  AwsomeVIew.swift
//  DemoSwiftUIByPriya
//
//  Created by Priya Hansaliya on 16/10/24.
//

import SwiftUI
import AwesomeSpotlightView

#Preview {
    AwsomeVIew()
}


struct AwsomeVIew: View {
    @State private var spotlightView = AwesomeSpotlightView()
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "star.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .padding()
                .background(Color.gray.opacity(0.1))
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                .id("logoImageView")
            
            Text("Name Label")
                .font(.headline)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .id("nameLabel")
            
            Button(action: handleShowAction) {
                Text("Show Spotlight")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .id("showButton")
            
            Button(action: handleShowWithContinueAndSkipAction) {
                Text("Show With Continue and Skip")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .id("showWithContinueAndSkipButton")
            
            Button(action: handleShowAllAtOnceAction) {
                Text("Show All At Once")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .id("showAllAtOnceButton")
        }
        .padding()
        .onAppear {
            setupSpotlight()
        }
    }
    
    func setupSpotlight() {
        let logoImageViewSpotlight = AwesomeSpotlight(withRect: CGRect(x: 0, y: 0, width: 100, height: 100), shape: .circle, text: "logoImageViewSpotlight")
        let nameLabelSpotlight = AwesomeSpotlight(withRect: CGRect(x: 0, y: 0, width: 200, height: 50), shape: .rectangle, text: "nameLabelSpotlight")
        let showButtonSpotlight = AwesomeSpotlight(withRect: CGRect(x: 0, y: 0, width: 300, height: 50), shape: .roundRectangle, text: "showButtonSpotlight")
        let showWithContinueAndSkipButtonSpotlight = AwesomeSpotlight(withRect: CGRect(x: 0, y: 0, width: 300, height: 50), shape: .roundRectangle, text: "showWithContinueAndSkipButtonSpotlight")
        let showAllAtOnceButtonSpotlight = AwesomeSpotlight(withRect: CGRect(x: 0, y: 0, width: 300, height: 50), shape: .roundRectangle, text: "showAllAtOnceButtonSpotlight", isAllowPassTouchesThroughSpotlight: true)
        
        spotlightView = AwesomeSpotlightView(frame: UIScreen.main.bounds, spotlight: [logoImageViewSpotlight, nameLabelSpotlight, showButtonSpotlight, showWithContinueAndSkipButtonSpotlight, showAllAtOnceButtonSpotlight])
        spotlightView.cutoutRadius = 8
        spotlightView.delegate = self as? AwesomeSpotlightViewDelegate
    }
    
    func handleShowAction() {
        spotlightView.continueButtonModel.isEnable = false
        spotlightView.skipButtonModel.isEnable = false
        spotlightView.showAllSpotlightsAtOnce = false
        spotlightView.start()
    }
    
    func handleShowWithContinueAndSkipAction() {
        spotlightView.continueButtonModel.isEnable = true
        spotlightView.skipButtonModel.isEnable = true
        spotlightView.showAllSpotlightsAtOnce = false
        spotlightView.start()
    }
    
    func handleShowAllAtOnceAction() {
        spotlightView.continueButtonModel.isEnable = false
        spotlightView.skipButtonModel.isEnable = false
        spotlightView.showAllSpotlightsAtOnce = true
        spotlightView.start()
    }
}
