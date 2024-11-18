//
//  DemoSwiftUIByPriyaApp.swift
//  DemoSwiftUIByPriya
//
//  Created by Priya Hansaliya on 16/07/24.
//

import SwiftUI
import Instructions

@main
struct DemoSwiftUIByPriyaApp: App {
    var body: some Scene {
        WindowGroup {
            TextSpeechView()
        }
    }
}




extension View {
    @ViewBuilder
    func addSpotlight(_ id: Int, shape: SpotlightShape = .rectangle, roundedRadius:CGFloat = 0, text: String = "") -> some View{
        self
            .anchorPreference(key: BoundsKey.self, value: .bounds) {[id: BoundsKeyProperties(shape: shape, anchor: $0, text: text, radius: roundedRadius)]}
    }
    
    @ViewBuilder
    func addSpotlightOverlay(show: Binding<Bool>, currentSpot: Binding<Int>) -> some View {
        self.overlayPreferenceValue(BoundsKey.self) { values in
            GeometryReader { proxy in
                if let preference = values.first(where: { item in
                    item.key == currentSpot.wrappedValue
                }) {
                    let screenSize = proxy.size
                    let anchor = proxy[preference.value.anchor]
                    
                    //MARK: - Spotlight view
                    spotlightHelperView(screenSize: screenSize, rect: anchor, show: show, currentSpot: currentSpot, properties: preference.value) {
                        if currentSpot.wrappedValue <= (values.count) {
                            currentSpot.wrappedValue += 1
                        }else{
                            show.wrappedValue = false
                        }
                    }
                }
            }
            .ignoresSafeArea()
            .animation(.easeInOut, value: show.wrappedValue)
            .animation(.easeInOut, value: currentSpot.wrappedValue)
        }
    }
    
    @ViewBuilder
    func spotlightHelperView(screenSize: CGSize, rect: CGRect, show: Binding<Bool>, currentSpot:Binding<Int>, properties: BoundsKeyProperties, onTap: @escaping () -> ()) -> some View {
        Rectangle()
            .fill(.ultraThinMaterial)
            .environment(\.colorScheme,.dark)
            .opacity(show.wrappedValue ? 1 : 0 )
            .overlay(alignment: .topLeading){
               Text("")
                .overlay {
                    GeometryReader { geometry in
                        let textsize = geometry.size
                        
                        HStack {
                            Image(.heartNewFill).renderingMode(.template)
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: 20, height: 20)
                                .padding(.trailing, 8)
                                .padding(.leading, 8)
                            
                            Text("properties.textdajdjasghdhasjdhdsghsadjahsdghasd")
                                .lineLimit(0)
                                .foregroundColor(.white)
                                .padding(.trailing, 8)
                                .offset(x: (rect.minX + textsize.width) > (screenSize.width - 15 ) ? -((rect.minX + textsize.width) - (screenSize.width - 15 )) : 0 )
                            
                                .offset(x: (rect.minX + textsize.height) > (screenSize.height - 50) ? -(textsize.height) - (rect.maxY - rect.minY + 30) : 30 )
                        }
                        .padding(.all)
                        .frame(width: UIScreen.main.bounds.width - 60)
                        .background(.orange)
                    }
                    .padding()
                    .offset(x:rect.minX, y: rect.maxY)
                }
                
            }
        
        //reversemarking
            .mask {
                Rectangle()
                    .overlay(alignment: .topLeading) {
                        let radius = properties.shape == .circle ? (rect.width / 2) : (properties.shape == .rectangle ? 0 : properties.radius)
                        RoundedRectangle(cornerRadius: radius, style: .continuous)
                            .frame(width: rect.width, height: rect.height)
                            .offset(x: rect.minX, y: rect.minY)
                            .blendMode(.destinationOut)
                    }
            }
            .onTapGesture {
                onTap()
            }
    }
}

enum SpotlightShape {
    case circle
    case rectangle
    case rounded
}

struct BoundsKey: PreferenceKey {
    static var defaultValue: [Int:BoundsKeyProperties] = [:]
    
    static func reduce(value: inout [Int : BoundsKeyProperties], nextValue: () -> [Int: BoundsKeyProperties]) {
        value.merge(nextValue()) {$1}
    }
}

struct BoundsKeyProperties {
    var shape: SpotlightShape
    var anchor: Anchor<CGRect>
    var text: String = ""
    var radius: CGFloat = 0
}



struct TextSpeechView: View {
    @State private var showSpotlight = false
    @State private var currentSpot: Int = 0
    @State var isSideMenuOpen: Bool = false

    let text = "Thankfully, there is a solution, and it’s not that hard to implement."

    var body: some View {
        ZStack {
            // ScrollView content
            ScrollView {
                LazyVStack(spacing: 10) { // Add LazyVStack to optimize performance
                    ForEach(0..<50, id: \.self) { index in
                        Button(action: {}) {
                            Text("Item \(index)") // Replace 'text' with sample item text
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                }
                .padding(.horizontal, 16) // Horizontal padding
                .padding(.vertical, 8)    // Vertical padding
            }
            .background(.red)
            .padding(.top, 80) // Adjust padding to position content below the navigation bar
            
            // Custom Navigation Bar
            VStack {
                CustomNavigation(isBack: false, isSideMenuOpen: $isSideMenuOpen, isTopBarmenu: true, isFromRadio: false)
                Spacer() // Spacer to push the navigation bar to the top
            }
        }
        .onAppear() {
            showSpotlight = true
        }
    }


    // Function to check if it's the first launch
    private func isFirstLaunch() -> Bool {
        let hasLaunchedBefore = UserDefaults.standard.bool(forKey: "hasLaunchedBefore")
        return !hasLaunchedBefore
    }
}

#Preview {
    TextSpeechView()
}
