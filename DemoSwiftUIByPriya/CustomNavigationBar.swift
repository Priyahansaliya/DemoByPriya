//
//  CustomNavigationBar.swift
//  DemoSwiftUIByPriya
//
//  Created by Priya Hansaliya on 24/07/24.
//

import SwiftUI

struct CustomNavigationBar: View {
    @Environment(\.presentationMode) var presentationMode
    var isBack: Bool
    var title: String
    @State var isLatestNews: Bool = false
    @Binding var isSideMenuOpen: Bool
    @Binding var spotlight: Bool
    @State var starAction: () -> Void = {}
    

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: {
                    if isBack {
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        isSideMenuOpen.toggle()
                    }
                }) {
                    HStack(alignment: .center) {
                        if isBack {
                            Image(systemName: "arrow.left")
                                .resizable()
                                .frame(width: 20, height: 15)
                                .foregroundColor(.black)
                        } else {
                            Image(systemName: "line.horizontal.3")
                                .resizable()
                                .frame(width: 20, height: 15)
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.leading, 16)
                }
                if spotlight {
                    Text(title)
                        .lineLimit(1)
                        .padding(.leading, 10)
                        .padding(.bottom, 4)
                        .showCase(
                            order: 0,
                            img: .heartNewFill,
                            title: "Click here to filter Akashvani radio channels by state radio services of Prasarbharti",
                            cornerRadius: 15,
                            style: .continuous,
                            scale: 1.8,
                            isCapsule: false
                        )
                }else{
                    Text(title)
                        .lineLimit(1)
                        .padding(.leading, 10)
                        .padding(.bottom, 4)
                }
             
                Spacer()
                Button(action: starAction) {
                    Image(systemName: "star")
                        .resizable()
                        .frame(width: 20, height: 15)
                        .foregroundColor(.black)
                }
            }
            .foregroundColor(.white)
            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0)
            .padding(.bottom, 10)
            .background(Color.red)
            .roundCorners([.topLeft, .topRight], radius: 20)
            .shadow(color: Color.black.opacity(0.2), radius: 16, x: 0, y: 2)
        }
        .edgesIgnoringSafeArea(.top)
    }
}

extension View {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) -> some View {
        clipShape(RoundedCorner(corners: corners, radius: radius))
    }
}

struct RoundedCorner: Shape {
    var corners: UIRectCorner
    var radius: CGFloat

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


