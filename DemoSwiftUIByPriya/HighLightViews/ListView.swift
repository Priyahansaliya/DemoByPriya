//
//  ListView.swift
//  DemoSwiftUIByPriya
//
//  Created by Priya Hansaliya on 24/07/24.
//

import SwiftUI
//struct ListView: View {
//    @State var isSideMenuOpen: Bool = false
//    @State private var hasShownShowcase = false
//    @State var selectedIndex: Int = -1
//    @State private var showBottomBarShowcase = false // New state to control BottomBar showcase
//    
//    var body: some View {
//        
//        ZStack {
//            VStack {
//                CustomNavigationBar(isBack: true, title: "NAVIGATION", isSideMenuOpen: $isSideMenuOpen)
//                
//                ScrollView(.vertical, showsIndicators: true) {
//                    VStack(alignment: .leading) {
//                                           
//                        ForEach(0..<10, id: \.self) { index in
//                            VStack(alignment: .leading) {
//                                ZStack {
//                                    HStack {
//                                        ZStack(alignment: .topTrailing) {
//                                            Image(systemName: "iphone")
//                                                .resizable()
//                                                .aspectRatio(1.0, contentMode: .fit)
//                                                .cornerRadius(12)
//                                                .frame(height: 90)
//                                                .padding([.leading, .top, .bottom], 12)
//                                               
//                                        }
//                                        Spacer()
//                                    }
//                                    .cornerRadius(12)
//                                }
//                            }
//                                .background(Color.gray)
//                                .cornerRadius(12)
//                                .onAppear() {
//                                    selectedIndex  = index
//                                }
//                                .overlay(
//                                    // Spotlight for first index
//                                    Circle()
//                                        .frame(width: 50, height: 50)
//                                        .foregroundColor(.clear)
//                                        .showCase(order: 0, // Adjust the order
//                                                  title: index == 0 ? "This is the first item!" : "",
//                                                  cornerRadius: 12,
//                                                  style: .continuous,
//                                                  scale: 1.5)
//                                        .opacity(index == 0 ? 1 : 0) // Show only on first index
//                                )
//                        }
//                    }
//                    .padding([.leading, .trailing], 16)
//                }
//                BottomBa()
//                    .overlay(
//                        Circle()
//                            .frame(width: 40, height: 40)
//                            .foregroundColor(.clear)
//                            .showCase(order: 0, // Adjust showcase order for BottomBar
//                                      title: "Tap here to interact with Bottom Bar!",
//                                      cornerRadius: 12,
//                                      style: .continuous,
//                                      scale: 1.5)
//                          
//                    )
//            }
//            .onAppear {
//                if !hasShownShowcase {
//                    hasShownShowcase = true
//                    showBottomBarShowcase = true // Show BottomBar showcase after list appears
//                }
//            }
//            
//            // BottomBar with showcase
//          
//        }
//        .overlay(
//            Circle()
//                .frame(width: 40, height: 40)
//                .foregroundColor(.clear)
//                .showCase(order: 1, // Adjust showcase order for BottomBar
//                          title: "Tap here",
//                          cornerRadius: 12,
//                          style: .continuous,
//                          scale: 1.5)
//              
//        )
//        .modifier(ShowCaseRoot(showHighLight: true, onFinished: {
//            print("Showcase finished")
//        }))
//    }
//}

struct BottomBa: View {
    var body: some View {
        HStack {
            Spacer()
            Text("Bottom Bar")
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
            Spacer()
        }
        .frame(height: 50)
        .background(Color.gray)
    }
}





extension View {
    func cornerRadius(radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}
struct CornerRadiusShape: Shape {
    var radius = CGFloat.infinity
    var corners = UIRectCorner.allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner
    
    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}
