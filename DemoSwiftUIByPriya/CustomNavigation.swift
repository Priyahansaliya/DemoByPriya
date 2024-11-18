//
//  CustomNavigation.swift
//  DemoSwiftUIByPriya
//
//  Created by Priya Hansaliya on 17/10/24.
//

import SwiftUI
import SDWebImageSwiftUI

class DashboardPost: NSObject, Identifiable {

    var iD : String = ""
    var post_category: String = ""
    var postDate : String = ""
    var postImage : String = ""
    var post_background: String = ""
    var postTitle : String = ""
    var videoUrl : String = ""
    var audio_url : String = ""
    var thumbnail : String = ""
    var url : String = ""
    var music_type : String = ""

    init(fromDictionary dictionary: [String:Any]){
        iD = getString(anything: dictionary["ID"])
        if iD.isEmptyString {
            iD = getString(anything: dictionary["id"])
        }
        post_category = getString(anything: dictionary["post_category"])
        postDate = getString(anything: dictionary["post_date"])
        postImage = getString(anything: dictionary["post_image"])
        post_background = getString(anything: dictionary["post_background"])
        postTitle = getString(anything: dictionary["post_title"])
        videoUrl = getString(anything: dictionary["video_url"])
        audio_url = getString(anything: dictionary["audio_url"])
        thumbnail = getString(anything: dictionary["thumbnail"])
        url = getString(anything: dictionary["url"])
        music_type = getString(anything: dictionary["music_type"])
    }
}

struct CustomNavigation: View {
    @Environment(\.presentationMode) var presentationMode
    var isBack: Bool
    var title: String = ""
    @State var isClicked: Bool  = true
    @State var isFilter: Bool = false
    @State var isClearAll: Bool = false
    @State var isLatestNews: Bool = false
    @State var isActive: Bool = false
    @State var selectedIndex: Int = 0
    @State var notificationCount: String = ""
    @Binding var isSideMenuOpen: Bool
    @State var isTopBarmenu: Bool = false
    @State var spotlightVisible: Bool = true
    
    @State var isSideMenu: Bool = false
    @State var isSearch: Bool = false
    @State var isLangChange: Bool = false
    @State var isNotification: Bool = false
    @State var isFont: Bool = false
    @State var isFromRadio: Bool
    @State var isShare: Bool = false
    @State var isHome: Bool = false
    @State var isFromSpecialPrograms: Bool = false
    @State var arrHeaderCollList : [DashboardPost] = [
        DashboardPost(fromDictionary: ["post_title" : "Live Radio", "post_image" : "radioD", "id" : "1"]),
        DashboardPost(fromDictionary: ["post_title" : "Listen News", "post_image" : "listen_broadcast", "id" : "2"]),
        DashboardPost(fromDictionary: ["post_title" : "Latest News", "post_image" : "latest_news", "id" : "3"]),
        DashboardPost(fromDictionary: ["post_title" : "News Programmes", "post_image" : "broadcastD", "id" : "4"]),
        DashboardPost(fromDictionary: ["post_title" : "From Archives", "post_image" : "archive", "id" : "6"]),
        DashboardPost(fromDictionary: ["post_title" : "Live TV", "post_image" : "liveTv", "id" : "5"]),
    ]
    
   
    
    var body: some View {
        VStack {
          HStack {
                VStack{
                    HStack{
                        Button(action: {
                            if isBack {
                                presentationMode.wrappedValue.dismiss()
                            } else {
                                isSideMenuOpen.toggle()
                            }
                        }) {
                            HStack (alignment: .center) {
                                if isBack {
                                    Image(.icHeaderBack).renderingMode(.template)
                                        .resizable()
                                        .foregroundColor(.appBlack)
                                        .frame(width: 20, height: 15)
                                } else {
                                    Image(.icHeaderMenu)
                                        .resizable()
                                        .frame(width: 20, height: 18)
                                }
                            }
                            .padding(.leading, 16)
                            .padding([.bottom], 8)
                            .foregroundColor(.appWhite)
                        }
                        Text("title")
                            .font(.title)
                            .foregroundColor(.appHeaderTitle)
                            .minimumScaleFactor(0.2)
                            .lineLimit(1)
                            .multilineTextAlignment(isRightToLeftLocalization ? .trailing : .leading)
                            .padding(.leading, 10)
                            .padding([.bottom], 8)
                        Spacer()
                        HStack(spacing: 10) {
                            if isBack {
                                if isFilter && isFromRadio {
                                    if spotlightVisible {
                                        Button(action: {}) {
                                            Image(.filter)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 20, height: 20)
                                                .foregroundColor(.appWhite)
                                        } .showCase(
                                            order: 0,
                                            img: .hintFilter,
                                            title: "Click here to filter Akashvani radio channels by state radio services of Prasarbharti",
                                            cornerRadius: 15,
                                            style: .continuous,
                                            scale: 1.8,
                                            isCapsule: false
                                        )
                                    }else {
                                        Button(action: {}) {
                                            Image(.filter)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 20, height: 20)
                                                .foregroundColor(.appWhite)
                                        }
                                    }
                                }else {
                                    Button(action: {}) {
                                        Image(.filter)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(.appWhite)
                                    }
                                }
                                
                                if isClearAll {
                                    Button(action: {}) {
                                        Text("Clear All")
                                            .font(.title)
                                            .foregroundColor(.appButtonRed)
                                    }
                                }
                                if isLatestNews {
                                    HStack(spacing: 8){
                                        Button(action: {}) {
                                            Image(.icHeaderTextType)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 20, height: 15)
                                                .foregroundColor(.appWhite)
                                        } .frame(width: 30, height: 30)

                                        Button(action: {}) {
                                            Image(.icHeaderSound)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 20, height: 15)
                                               // .foregroundColor(.appWhite)
                                        } .frame(width: 30, height: 30)

                                        Button(action: {}) {
                                            Image(.icHeaderBookmark)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 20, height: 15)
                                                .foregroundColor(.appWhite)
                                        }.frame(width: 30, height: 30)

                                        Button(action: {}) {
                                            Image(.icHeaderShare)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 20, height: 15)
                                                .foregroundColor(.appWhite)
                                        }.frame(width: 030, height: 30)

                                    }
                                }
                                
                            } else if isHome {
                                HStack (spacing: 16 ){
                                    Button(action: { isLangChange = true }) {
                                        Image(.icLanguage)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 25, height: 25)
                                            .foregroundColor(.appNavButtonTint)
                                    }
                                    
                                    Button(action: {
                                        isSearch = true
                                    }) {
                                        Image(.icSearch)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(.appNavButtonTint)
                                    }
                                    
                                    ZStack(alignment: .topTrailing) {
                                        Button(action: {
                                            isNotification = true
                                        }) {
                                            HStack {
                                                Image(.icNotification).renderingMode(.template)
                                                    .renderingMode(.template)
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 25, height: 25)
                                                    .foregroundColor(.appNavButtonTint)
                                            }
                                            .padding()
                                            .background(Color.clear)
                                            .clipShape(Circle())
                                        }
                                        .frame(width: 25, height: 25)
                                        if notificationCount != "" || notificationCount == "0" {
                                            Text(notificationCount)
                                                .foregroundColor(.white)
                                                .padding(3)
                                                .font(.body)
                                                .background(.appRed)
                                                .clipShape(Circle())
                                                .offset(x: 1, y: -4)
                                        }
                                    }
                                }
                            }
                        }.padding(.trailing, 16)
                            .padding([.bottom], 8)
                    }.foregroundColor(.appWhite)
                        .padding(.bottom, isHome ? 0 : 0)
                        if isTopBarmenu {
                                HStack {
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(spacing: 12) {
                                            ForEach(0..<5, id: \.self) { index in
                                                Button(action: {
                                                    isActive = true
                                                    selectedIndex = index
                                                }) {
                                                    Image(uiImage: .add)
                                                        .resizable()
                                                        .foregroundColor(Color.cyan.opacity(0.3))
                                                        .frame(width: 20, height: 20)
                                                        .padding(.horizontal, 5)
                                                    
                                                    Text("+ add")
                                                        .multilineTextAlignment(.center)
                                                        .foregroundColor(.appLblBlack)
                                                }
                                                .padding([.top, .bottom], 8)
                                                .padding([.leading, .trailing], 10)
                                                .background(Color.cyan.opacity(0.3))
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 0)
                                                        .stroke(Color.appBorderColor1 , lineWidth: 1)
                                                )
                                            }
                                        }
                                        .padding([.leading, .trailing], 16)
                                    }.frame(height: isTopBarmenu ? 55 : 0)
                                    .padding([.leading, .trailing], 0)
                                }.padding(.top, -10)
                        }
                }.background(.yellow)
            }
            .foregroundColor(.white) .background(.clear)
            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0)
            .roundCorners([.bottomLeft, .bottomRight], radius: 20)
            .shadow(color: .black.opacity(0.2), radius: 16, x: 0, y: 2)
        }
        .onAppear(){ }
        .edgesIgnoringSafeArea(.top)
        .roundCorners([.bottomLeft, .bottomRight], radius: 20)
        .edgesIgnoringSafeArea(.top)
        .padding(.bottom, IS_IPHONE_SE_DOWN_MODEL ? 0 : -38)
        .shadow(color: isDarkModeAppearance ? .clear : .black.opacity(0.2), radius: 16, x: 0, y: 2)
       // .background(.clear)
    }
    
}


