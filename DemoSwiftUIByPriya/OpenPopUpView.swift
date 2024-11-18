//
//  OpenPopUpView.swift
//  DemoSwiftUIByPriya
//
//  Created by Priya Hansaliya on 16/07/24.
//

import SwiftUI

enum Fonts_Size : String {
    case Small = "Small"
    case Regular = "Regular"
    case Large = "Large"
    case Extra_Large = "Extra Large"
    case Maximum = "Maximum"
}

class DropDownModel: NSObject {
    let title: String
    let id: String
    var isSelected: Bool
    
    enum Keys: String {
        case title = "title"
        case id = "id"
        case isSelected = "isSelected"
    }
    
    init(dict: [String : Any]) {
        title = dict["title"] as? String ?? ""
        id = dict["id"] as? String ?? ""
        isSelected = false
    }
}

struct OpenPopUpView: View {
    let arrFonts = [
        DropDownModel(dict: ["title": Fonts_Size.Small.rawValue, "id": "1"]),
        DropDownModel(dict: ["title": Fonts_Size.Regular.rawValue, "id": "3"])
    ]
    @State private var isFontView = false
    @State private var selectedFontSize = 0
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onTapGesture {
                isFontView = true
            }
            .fullScreenCover(isPresented: $isFontView) {
//            PopUpView(arrList: arrFonts,selectedIndex: 1 ) { selectedValue in
//                selectedFontSize = Int(selectedValue)
////                setUpFontSize()
//            }
        }
    }
}

#Preview {
    OpenPopUpView()
}
