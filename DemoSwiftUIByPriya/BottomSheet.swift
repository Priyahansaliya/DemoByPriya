//
//  BottomSheet.swift
//  DemoSwiftUIByPriya
//
//  Created by Priya Hansaliya on 22/07/24.
//

import SwiftUI



struct AnimatedBackgroundView: View {
    @State private var animationAmount = 1.0

    var body: some View {
        ZStack {
            Button("Tap Me") {
                // animationAmount += 1
            }
            .padding(30)
            .background(Color.red)
            .foregroundStyle(Color.white)
            .clipShape(Circle())
            .overlay(
                ZStack {
                    ForEach(0..<3) { index in
                        Circle()
                            .stroke(Color.red, lineWidth: 2.0)
                            .scaleEffect(animationAmount * CGFloat(index + 3) / 3)
                            .opacity(2 - animationAmount)
                            .animation(
                                .easeInOut(duration: 1)
                                    .repeatForever(autoreverses: false),
                                value: animationAmount
                            )
                    }
                }
            )
            .onAppear {
                animationAmount = 1.5
            }
        }
    }
}


struct SpeechView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isAnimating: Bool = false

    var body: some View {
        ZStack {
            AnimatedBackgroundView()
            VStack {
                Spacer()
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "star.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                        .padding([.trailing, .top], 8)
                    }
                    Button(action: {
                        withAnimation {
                            isAnimating.toggle()
                        }
                    }) {
                        Image(systemName: "star").renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.red)
                            .shadow(radius: 10)
                            .scaleEffect(isAnimating ? 1.2 : 1.0)
                    }
                    .padding(.bottom, 60)
                    .padding(.top, 20)
                    .frame(width: 120, height: 120)
                }
                .background(Color.yellow)
            }
            .background(BackgroundClearView())
        }
        .background(BackgroundClearView())
        .onAppear {
            withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                isAnimating = true
            }
        }
    }
}




#Preview {
    SpeechView()
}
