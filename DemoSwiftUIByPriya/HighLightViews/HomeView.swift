////
////  HomeView.swift
////  DemoSwiftUIByPriya
////
////  Created by Priya Hansaliya on 23/07/24.
////
//
//import SwiftUI
//import MapKit
//
//struct Highlight: Identifiable, Equatable  {
//    var id: UUID = .init()
//    var anchor: Anchor<CGRect>
//    var title: String
//    var cornerRadius: CGFloat
//    var style: RoundedCornerStyle = .continuous
//    var scale: CGFloat = 1
//}
//
//struct HomeView: View {
//    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.3346, longitude: -122.0090), latitudinalMeters: 1000, longitudinalMeters: 1000)
//    
//    var body: some View {
//        TabView {
//            GeometryReader {
//                let safeArea = $0.safeAreaInsets
//                
//                Map(coordinateRegion: $region)
//                    .overlay(alignment: .top, content: {
//                        Rectangle()
//                            .fill(.ultraThinMaterial)
//                            .frame(height: safeArea.top)
//                    })
//                    .ignoresSafeArea()
//                    .overlay(alignment: .topTrailing) {
//                        VStack {
//                            Button(action: {}){
//                                Image(systemName: "location.fill")
//                                    .padding()
//                                    .foregroundColor(.white)
//                                    .background {
//                                        RoundedRectangle(cornerRadius: 10, style: .continuous)
//                                            .fill(.black)
//                                    }
//                                
//                            }
//                            .showCase(order: 0, title: "My Location", cornerRadius: 0, style: .continuous)
//                            
//                            Spacer()
//                            
//                            Button(action: {
//                                
//                            }){
//                                Image(systemName: "heart.fill")
//                                    .padding()
//                                    .foregroundColor(.white)
//                                    .background {
//                                        RoundedRectangle(cornerRadius: 10, style: .continuous)
//                                            .fill(.red)
//                                    }
//                            }
//                            .showCase(order: 1, title: "Favourite", cornerRadius: 10, style: .continuous)
//                        }.padding()
//                    }
//            }
//            .tabItem {
//                Image(systemName: "macbook.and.iphone")
//                Text("Star")
//            }
//            .toolbarBackground(.visible, for: .tabBar)
//            .toolbarBackground(.ultraThinMaterial   , for: .tabBar)
//            
//            Text("")
//                .tabItem {
//                    Image(systemName: "macbook.and.iphone")
//                    Text("Star")
//                }
//            
//            
//            Text("")
//                .tabItem {
//                    Image(systemName: "book")
//                    Text("Star")
//                }
//            
//        }
//                
//        
//        .modifier(ShowCaseRoot(showHighLight: true, onFinished: {
//            print("finish")
//        }))
//        
//    }
//}
//
//#Preview {
//    HomeView()
//}
//
//extension View {
//    @ViewBuilder
//    func showCase(order: Int, title: String, cornerRadius: CGFloat, style: RoundedCornerStyle = .continuous, scale: CGFloat = 1) -> some View {
//        self
//            .anchorPreference(key: HighlightAnchorKey.self, value: .bounds, transform: { anchor in
//                let heighlight = Highlight(anchor: anchor, title: title, cornerRadius: cornerRadius, style: style, scale: scale)
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
//                    Rectangle()
//                        .matchedGeometryEffect(id: "HIGHLIGHTSHAPE", in: animation)
//                        .frame(width: highLightRect.width , height: highLightRect.height)
//                        .clipShape(Circle())
//                        .scaleEffect(highlight.scale)
//                        .offset(x: highLightRect.minX, y: highLightRect.minY + safeArea.top)
//                }
//                .ignoresSafeArea()
//                .onTapGesture {
//                    if currentHightlight >= highlightedOrder.count - 1 {
//                        withAnimation(.easeInOut(duration: 0.25)) {
//                            showView = false
//                        }
//                       // onFinished()
//                    }else {
//                        withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.7, blendDuration: 0.7)) {
//                            showTitle = true
//                            currentHightlight += 1
//                        }
//                        
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
//                            showTitle = true
//                        }
//                    }
//                }
//                .onAppear() {
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                        showTitle = true
//                    }
//                    
//                }
//            
//            Rectangle()
//                .foregroundColor(.clear)
//                .frame(width: highLightRect.width + 10  , height: highLightRect.height + 10)
//                .clipShape(RoundedRectangle(cornerRadius: 12))
//                .popover(isPresented: $showTitle) {
//                    HStack {
//                        Image("star").renderingMode(.template)
//                            .resizable()
//                            .foregroundColor(.blue)
//                            .frame(width: 15, height: 15)
//                            .padding(.leading)
//                        Text(highlight.title)
//                            .padding(.all, 10)
//                            .presentationCompactAdaptation(.popover)
//                            .interactiveDismissDisabled()
//                            .lineLimit(10)
//                    }
////                    .background(.yellow)
//                }
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
//struct HighlightAnchorKey: PreferenceKey {
//    static var defaultValue: [Int: Highlight] = [:]
//    static func reduce(value: inout [Int : Highlight], nextValue: () -> [Int : Highlight])  {
//        value.merge(nextValue()) { $1 }
//    }
//}
