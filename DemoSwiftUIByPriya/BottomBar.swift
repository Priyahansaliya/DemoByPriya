//
//  BottomBar.swift
//  DemoSwiftUIByPriya
//
//  Created by Priya Hansaliya on 06/09/24.
//

import SwiftUI

class AudioManager: ObservableObject {
    @Published var isMiniPlayerVisible: Bool = false
    @Published var currentIndex: Int = 0
}

struct BottomModel: Identifiable {
    let id = UUID() // Added for unique identification
    var img: String
    var name: String
}

struct BottomBar: View {
    @State private var selectedTab: Int = 0
    @State private var offsetY: CGFloat = 0
    @State private var isLogin: Bool = false
    @State private var isOpenLogin: Bool = false
    @EnvironmentObject var appState: AudioManager
    
    let arrData: [BottomModel] = [
        BottomModel(img: "bottom_home", name: "Home"),
        BottomModel(img: "bottom_category", name: "Category"),
        BottomModel(img: "bottom_fav", name: "Saved"),
        BottomModel(img: "bottom_profile", name: "Profile")
    ]
    
    var body: some View {
        
        VStack {
            Spacer() // Th
            bottomBar()
               }
               .background(Color(UIColor.systemBackground)) // Match the superarea color
               .edgesIgnoringSafeArea(.bottom) // Extend the background to the bottom
               .overlay(
                   // Create the bottom bar
                   ZStack {
                      
                   }
                   .frame(height: 160) // Set the desired height
                   .background(Color(UIColor.systemBackground)) // Match the superarea color
//                   .position(x: .center, y: UIScreen.main.bounds.height - 30) // Position it at the bottom
               )
        
//        VStack {
//            // Your main content here
//            
//            Spacer() // This pushes the bottom bar to the bottom
//            
//            bottomBar()
//        }
//        .background(Color(UIColor.systemBackground)) // Match the superarea color
    }
    
    @ViewBuilder
    func bottomBar() -> some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                ForEach(arrData.indices, id: \.self) { index in
                    VStack(spacing: 4) {
                        Image(arrData[index].img)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .offset(y: selectedTab == index ? offsetY : 0)
                            .onTapGesture {
                                handleTabSelection(index: index)
                            }
                            .alert(isPresented: $isLogin) {
                                loginAlert()
                            }
                            .foregroundColor(selectedTab == index ? .blue : .gray)
                        
                        Text(arrData[index].name)
                            .bold()
                            .foregroundColor(selectedTab == index ? .blue : .gray)
                    }
                    Spacer()
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                Color(UIColor.darkGray)
                    .shadow(color: Color.black.opacity(0.2), radius: 4)
                    .cornerRadius(20, corners: [.topLeft, .topRight])
            )
        }
    //    .animation(.easeInOut, value: appState.isMiniPlayerVisible)
        .background(Color.clear)
    }
    
    // Helper function to handle tab selection
    private func handleTabSelection(index: Int) {
        if index == 2 { // Assuming index 2 requires login (Saved tab)
            isLogin = true
        } else {
            selectedTab = index
        }
    }
    
    // Login Alert
    private func loginAlert() -> Alert {
        Alert(
            title: Text("Sign In required for this action, Do you want to sign in?"),
            primaryButton: .default(Text("Yes")) {
                isOpenLogin = true
            },
            secondaryButton: .cancel(Text("No"))
        )
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(corners: corners, radius: radius))
    }
}
