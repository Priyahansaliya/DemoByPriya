//
//  PageControlView.swift
//  DemoSwiftUIByPriya
//
//  Created by Priya Hansaliya on 04/09/24.
//

import SwiftUI
import Observation

//struct PageControlView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//#Preview {
//    PageControlView()
//}

import Foundation
import SwiftUI
import Combine

import SwiftUI

struct pContentView: View {
    let imageUrls = [
        "https://i.imgur.com/H4h2m2P.jpg",
        "https://i.imgur.com/XvF2kK2.jpg",
        "https://i.imgur.com/k4L6123.jpg",
        "https://i.imgur.com/y5zS6aX.jpg"
    ]

    @State private var currentPage = 0

    var body: some View {
        VStack {
            Image(uiImage: UIImage(data: try! Data(contentsOf: URL(string: imageUrls[currentPage])!))!)
                .resizable()
                .scaledToFit()

            PageControl(currentPage: $currentPage, numberOfPages: imageUrls.count)
        }
        .padding()
    }
}

struct PageControl: View {
    @Binding var currentPage: Int
    let numberOfPages: Int

    var body: some View {
        HStack {
            ForEach(0..<numberOfPages, id: \.self) { index in
                Circle()
                    .fill(index == currentPage ? Color.blue : Color.gray)
                    .frame(width: 10, height: 10)
                    .onTapGesture {
                        currentPage = index
                    }
            }
        }
        .padding(.bottom)
    }
}
