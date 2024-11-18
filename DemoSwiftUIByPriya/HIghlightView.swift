//
//  HIghlightView.swift
//  DemoSwiftUIByPriya
//
//  Created by Priya Hansaliya on 03/10/24.
//

import SwiftUI
//
//import SwiftUI
//
//struct HighlightView: View {
//    @State private var selectedTab = 0
//    @State private var likedItems: Set<Int> = []
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                // Navigation Bar
//                HStack {
//                    Button(action: {
//                        // Back button action
//                    }) {
//                        Image(systemName: "chevron.backward")
//                            .foregroundColor(.black)
//                    }
//
//                    Spacer()
//
//                    Text("Title")
//                        .font(.headline)
//
//                    Spacer()
//
//                    HStack {
//                        Button(action: {
//                            // Like button action
//                        }) {
//                            Image(systemName: "star")
//                                .foregroundColor(.red)
//                        }.showCase(
//                            order: 0, // Showcase order for Star button
//                            img: .tree,
//                            title: "Star",
//                            cornerRadius: 15,
//                            style: .continuous,
//                            scale:1.2,
//                            isCapsule: false
//                        )
//
//                        Button(action: {
//                            // Notification button action
//                        }) {
//                            Image(systemName: "bell")
//                                .foregroundColor(.black)
//                        }
//                        .showCase(
//                            order: 1, // Showcase order for Bell button
//                            img: .tree,
//                            title: "Notifications",
//                            cornerRadius: 15,
//                            style: .continuous,
//                            scale:1.2,
//                            isCapsule: false
//                        )
//                    }
//                }
//                .padding()
//                .background(Color(.systemGray6))
//                
//                // List View
//                List(0..<20, id: \.self) { item in
//                    HStack {
//                        Text("Item \(item)")
//                        Spacer()
//                        
//                        // Highlight the button for the first item (index 0)
//                        Button(action: {
//                            if likedItems.contains(item) {
//                                likedItems.remove(item)
//                            } else {
//                                likedItems.insert(item)
//                            }
//                        }) {
//                            Image(systemName: likedItems.contains(item) ? "heart.fill" : "heart")
//                                .foregroundColor(.red)
//                        }
//                        // Only show case the first item (index 0)
//                        .if(item == 0) { view in
//                            view.showCase(
//                                order: 2, // Showcase order for the first item
//                                img: .heartNewFill,
//                                title: "First Item Like Button",
//                                cornerRadius: 15,
//                                style: .continuous,
//                                scale: 1.2,
//                                isCapsule: false
//                            )
//                        }
//                    }
//                    .padding()
//                }
//              
//                // Tab View
//                TabView(selection: $selectedTab) {
//                    Text("Home")
//                        .tabItem {
//                            Image(systemName: "house")
//                            Text("Home")
//                        }
//                        .tag(0)
//
//                    Text("Search")
//                        .tabItem {
//                            Image(systemName: "magnifyingglass")
//                            Text("Search")
//                        }
//                        .showCase(
//                            order: 3, // Showcase order for Search tab
//                            img: .heartNewFill,
//                            title: "Search",
//                            cornerRadius: 15,
//                            style: .continuous,
//                            scale:1.2,
//                            isCapsule: false
//                        )
//                        .tag(1)
//
//                    Text("Profile")
//                        .tabItem {
//                            Image(systemName: "person")
//                            Text("Profile")
//                        }
//                        .tag(2)
//                }
//                .frame(height: 60)
//            }
//            .navigationBarHidden(true)
//            .modifier(ShowCaseRoot(showHighLight: true, onFinished: {
//                print("finish")
//            }))
//        }
//    }
//}
//
//extension View {
//    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
//        if condition {
//            transform(self)
//        } else {
//            self
//        }
//    }
//}
//
//import SwiftUI
//
//struct Highlight: Identifiable, Equatable  {
//    var id: UUID = .init()
//    var anchor: Anchor<CGRect>
//    var img: ImageResource
//    var title: String
//    var cornerRadius: CGFloat
//    var style: RoundedCornerStyle = .continuous
//    var scale: CGFloat = 1
//    var isCapsule: Bool
//}
//
//
//struct HighlightAnchorKey: PreferenceKey {
//    static var defaultValue: [Int: Highlight] = [:]
//    static func reduce(value: inout [Int : Highlight], nextValue: () -> [Int : Highlight])  {
//        value.merge(nextValue()) { $1 }
//    }
//}
//
//
//extension View {
//    @ViewBuilder
//    func showCase(order: Int,img: ImageResource, title: String, cornerRadius: CGFloat, style: RoundedCornerStyle = .continuous, scale: CGFloat = 1, isCapsule: Bool) -> some View {
//        self
//            .anchorPreference(key: HighlightAnchorKey.self, value: .bounds, transform: { anchor in
//                let heighlight = Highlight(anchor: anchor, img: img, title: title, cornerRadius: cornerRadius, style: style, scale: scale, isCapsule: isCapsule)
//                return [order: heighlight]
//            })
//    }
//}
//
//struct ShowCaseRoot: ViewModifier {
//    var showHighLight: Bool
//    var onFinished: () -> ()
//    
//    @Namespace private var animation
//    @State var highlightedOrder: [Int] = []
//    @State var currentHightlight: Int = 0
//    @State var showView: Bool = true
//    @State var showTitle: Bool = true
//    
//    func body(content: Content) -> some View {
//        content
//            .onPreferenceChange(HighlightAnchorKey.self){ value in
//                highlightedOrder = Array(value.keys).sorted()
//            }
//        
//            .overlayPreferenceValue(HighlightAnchorKey.self) { preferences in
//                if highlightedOrder.indices.contains(currentHightlight), showHighLight, showView {
//                    if let highLight = preferences[highlightedOrder[currentHightlight]] {
//                        HighlightView(highLight)
//                    }
//                }
//            }
//    }
//    
//    @ViewBuilder
//    func HighlightView(_ highlight: Highlight) -> some View {
//        GeometryReader { reader in
//            let highLightRect = reader[highlight.anchor]
//            let safeArea = reader.safeAreaInsets
//            Rectangle()
//                .fill(.black.opacity(0.7))
//                .reverseMask {
//                    if !highlight.isCapsule {
//                        Rectangle()
//                            .matchedGeometryEffect(id: "HIGHLIGHTSHAPE", in: animation)
//                            .frame(width: highLightRect.width , height: highLightRect.height)
//                            .clipShape(Circle())
//                            .scaleEffect(highlight.scale)
//                            .offset(x: highLightRect.minX, y: highLightRect.minY + safeArea.top)
//                    }else{
//                        Rectangle()
//                            .matchedGeometryEffect(id: "HIGHLIGHTSHAPE", in: animation)
//                            .frame(width: highLightRect.width , height: highLightRect.height)
//                            .clipShape(Capsule())
//                            .scaleEffect(highlight.scale)
//                            .offset(x: highLightRect.minX, y: highLightRect.minY + safeArea.top)
//                    }
//                  
//                }
//                .ignoresSafeArea()
//                .onTapGesture {
//                    if currentHightlight >= highlightedOrder.count - 1 {
//                        withAnimation(.easeInOut(duration: 0.1)) {
//                            showView = false
//                        }
//                        onFinished()
//                    }else {
//                        withAnimation(.interactiveSpring(response: 0.1, dampingFraction: 0.7, blendDuration: 0.7)) {
//                            showTitle = false
//                            currentHightlight += 1
//                        }
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                            showTitle = true
//                        }
//                    }
//                }
//            
//                .onAppear() {
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                        showTitle = true
//                    }
//                }
//            
//            Rectangle()
//                .foregroundColor(.clear)
//                .frame(width: highLightRect.width   , height: highLightRect.height )
//                .clipShape(RoundedRectangle(cornerRadius: 12))
//                .popover(isPresented: $showTitle) {
//                    HStack {
//                        Image(highlight.img).renderingMode(.template)
//                            .resizable()
//                            .foregroundColor(.white)
//                            .frame(width: 20, height: 20)
//                            .padding(.trailing, 8)
//                            .padding(.leading, 8)
//
//                     Text(highlight.title)
//                            .lineLimit(10)
//                            .foregroundColor(.white)
//                            .padding(.trailing, 8)
//                    }
//                    .padding(.all, 0)
//                    .frame(width: UIScreen.main.bounds.size.width - 60, height: 100)
//                    .background(.orange)
//                    .presentationCompactAdaptation(.popover)
//                    .interactiveDismissDisabled()
//                }
//                .padding(.all, 4)
//                .scaleEffect(highlight.scale)
//                .offset(x: highLightRect.minX + 10, y: highLightRect.minY + 10)
//        }
//    }
//    
//}
//
//extension View {
//    @ViewBuilder
//    func reverseMask<Content: View>(alignment: Alignment = .topLeading, @ViewBuilder content: @escaping () -> Content) -> some View {
//        self
//            .mask {
//            Rectangle()
//                .overlay(alignment: .topLeading)  {
//                    content()
//                        .blendMode(.destinationOut)
//                }
//        }
//    }
//}
//
//struct Content2View: View {
//    @State private var isGifHidden = UserDefaults.standard.bool(forKey: "swipehelp")
//    
//    var body: some View {
//        VStack {
//            // Place the GIFView at the top
//            if !isGifHidden {
//                GIFView(isGifHidden: $isGifHidden)
//                    .frame(width: 300, height: 300)
//            } else {
//                Text("GIF is hidden")
//            }
//            
//            // HStack below the GIFView
//            HStack {
//                Text("Left Element")
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//                
//                Spacer()
//                
//                Text("Right Element")
//                    .padding()
//                    .background(Color.green)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//            .padding()
//        }
//    }
//}
//
//
//import SwiftUI
//import UIKit
//import ImageIO
//
//struct GIFView: UIViewRepresentable {
//    @Binding var isGifHidden: Bool
//    
//    func makeUIView(context: Context) -> UIImageView {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFit
//        imageView.layer.masksToBounds = true
//        imageView.isUserInteractionEnabled = true
//        return imageView
//    }
//    
//    func updateUIView(_ uiView: UIImageView, context: Context) {
//        let strGif: String
//        switch UserDefaults.getDeviceTheme() {
//        case .system_default:
//            strGif = AppSystemConstant.isDarkModeAppearance ? "imgpsh_fullsize_anim_Blue" : "swipe-helper"
//        case .light_mode:
//            strGif = "swipe-helper"
//        case .dark_mode:
//            strGif = "imgpsh_fullsize_anim_Blue"
//        }
//        
//        guard let path = Bundle.main.path(forResource: strGif, ofType: "gif"),
//              let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
//              let imageSource = CGImageSourceCreateWithData(data as CFData, nil) else {
//            return
//        }
//
//        let count = CGImageSourceGetCount(imageSource)
//        var images = [UIImage]()
//
//        for i in 0..<count {
//            if let cgImage = CGImageSourceCreateImageAtIndex(imageSource, i, nil) {
//                images.append(UIImage(cgImage: cgImage))
//            }
//        }
//
//        uiView.animationImages = images
//        uiView.animationDuration = TimeInterval(count) * 0.1 // Adjust duration as needed
//        uiView.startAnimating()
//        
//        if !isGifHidden {
//            let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleSwipe))
//            let swipeLeft = UISwipeGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleSwipe))
//            swipeLeft.direction = .left
//            
//            let swipeRight = UISwipeGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleSwipe))
//            swipeRight.direction = .right
//            
//            uiView.addGestureRecognizer(tapGesture)
//            uiView.addGestureRecognizer(swipeLeft)
//            uiView.addGestureRecognizer(swipeRight)
//        } else {
//            uiView.isHidden = true
//            uiView.isUserInteractionEnabled = false
//        }
//    }
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//    
//    class Coordinator: NSObject {
//        var parent: GIFView
//
//        init(_ parent: GIFView) {
//            self.parent = parent
//        }
//
//        @objc func handleSwipe() {
//            UserDefaults.standard.set(true, forKey: "swipehelp")
//            UserDefaults.standard.synchronize()
//
//            parent.isGifHidden = true
//        }
//    }
//}
//
//struct Content12View: View {
//    @State private var isGifHidden = UserDefaults.standard.bool(forKey: "swipehelp")
//    
//    var body: some View {
//        VStack {
//            if !isGifHidden {
//                GIFView(isGifHidden: $isGifHidden)
//                    .frame(width: 300, height: 300)
//            } else {
//                Text("GIF is hidden")
//            }
//        }
//    }
//}
//
//extension UserDefaults {
//    enum DeviceTheme {
//        case system_default, light_mode, dark_mode
//    }
//    
//    static func getDeviceTheme() -> DeviceTheme {
//        // Custom method to retrieve theme, update this based on your logic
//        return .system_default
//    }
//}
//
//struct AppSystemConstant {
//    static var isDarkModeAppearance: Bool {
//        // Custom logic to determine dark mode appearance
//        return false
//    }
//}
