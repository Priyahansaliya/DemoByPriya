//
//  SpotLightView.swift
//  DemoSwiftUIByPriya
//
//  Created by Priya Hansaliya on 23/07/24.
//

import SwiftUI

struct Highlight: Identifiable, Equatable {
    var id: UUID = .init()
    var anchor: Anchor<CGRect>
    var img: ImageResource
    var title: String
    var cornerRadius: CGFloat
    var style: RoundedCornerStyle = .continuous
    var scale: CGFloat = 1
    var isCapsule: Bool
}

struct HighlightAnchorKey: PreferenceKey {
    static var defaultValue: [Int: Highlight] = [:]
    static func reduce(value: inout [Int: Highlight], nextValue: () -> [Int: Highlight]) {
        value.merge(nextValue()) { $1 }
    }
}

extension View {
    @ViewBuilder
    func showCase(order: Int, img: ImageResource, title: String, cornerRadius: CGFloat, style: RoundedCornerStyle = .continuous, scale: CGFloat = 1, isCapsule: Bool) -> some View {
        self.anchorPreference(key: HighlightAnchorKey.self, value: .bounds, transform: { anchor in
            let highlight = Highlight(anchor: anchor, img: img, title: title, cornerRadius: cornerRadius, style: style, scale: scale, isCapsule: isCapsule)
            return [order: highlight]
        })
    }
}

struct ShowCaseRoot: ViewModifier {
    var showHighLight: Bool
    var onFinished: () -> ()
    
    @Namespace private var animation
    @State private var highlightedOrder: [Int] = []
    @State private var currentHighlight: Int = 0
    @State private var showView: Bool = true
    @State private var showTitle: Bool = false  // Adjust initial state
    
    func body(content: Content) -> some View {
        content
            .onPreferenceChange(HighlightAnchorKey.self) { value in
                highlightedOrder = Array(value.keys).sorted()
            }
            .overlayPreferenceValue(HighlightAnchorKey.self) { preferences in
                if highlightedOrder.indices.contains(currentHighlight), showHighLight, showView {
                    if let highlight = preferences[highlightedOrder[currentHighlight]] {
                        HighlightView(highlight)
                    }
                }
            }
    }
    
    @ViewBuilder
    private func HighlightView(_ highlight: Highlight) -> some View {
        GeometryReader { reader in
            let highlightRect = reader[highlight.anchor]
            let safeArea = reader.safeAreaInsets

            // Only render if highlightRect is valid and has dimensions
            if highlightRect.size.width > 0 && highlightRect.size.height > 0 {
                Rectangle()
                    .fill(Color.black.opacity(0.7))
                    .reverseMask {
                        let shape = highlight.isCapsule ? AnyShape(Capsule()) : AnyShape(Circle())
                        shape
                            .matchedGeometryEffect(id: "HIGHLIGHTSHAPE", in: animation)
                            .frame(width: highlightRect.width, height: highlightRect.height)
                            .scaleEffect(highlight.scale)
                            .offset(x: highlightRect.minX, y: highlightRect.minY + safeArea.top)
                    }
                    .ignoresSafeArea()
                    .onTapGesture  {
                        if currentHighlight >= highlightedOrder.count - 1 {
                            // End the showcase
                            withAnimation(.easeInOut(duration: 0.25)) {
                                showView = false
                            }
                            onFinished()
                        } else {
                            withAnimation(.interactiveSpring(response: 0.1, dampingFraction: 0.3, blendDuration: 0.3)) {
                                showTitle = false
                                currentHighlight += 1
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                showTitle = true
                            }
                        }
                    }
                    .onAppear {
                            showTitle = true
                    }
                PopoverView(highlight: highlight, highlightRect: highlightRect)
            } else {
                Color.clear // Placeholder while the geometry is being calculated
                    .onAppear {
                        // Trigger updates when the size changes
                        DispatchQueue.main.async {
                            showTitle = highlightRect.size.width > 0 ? true : false
                        }
                    }
            }
        }
    }


    // Helper method to handle tap gesture logic
    private func handleTapGesture() {
        if currentHighlight >= highlightedOrder.count - 1 {
            withAnimation(.easeInOut(duration: 0.25)) {
                showView = false
            }
            onFinished()
        } else {
            withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.7, blendDuration: 0.7)) {
                showTitle = false
                currentHighlight += 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        showTitle = true
                }
            }
        }
    }

    
    @ViewBuilder
    private func PopoverView(highlight: Highlight, highlightRect: CGRect) -> some View {
        Rectangle()
            .foregroundColor(.clear)
            .frame(width: highlightRect.width, height: highlightRect.height )
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .popover(isPresented: $showTitle, arrowEdge: .top) {
                HStack {
                    Image(highlight.img).renderingMode(.template)
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 20, height: 20)
                        .padding(.trailing, 8)
                        .padding(.leading, 8)
                    
                    Text(highlight.title)
                        .lineLimit(10)
                        .foregroundColor(.white)
                        .padding(.trailing, 8)
                        .padding(.vertical)
                }
                .padding(.all, 0)
                .frame(width: SCREEN_WIDTH - 60)
                .background(.orange)
                .presentationCompactAdaptation(.popover)
                .presentationContentInteraction(.automatic)
                .interactiveDismissDisabled()
            }
            .padding(.all, 16)
            .scaleEffect(highlight.scale)
            .offset(x: highlightRect.minX + 10, y: highlightRect.minY + 10)
    }
}

extension View {
    @ViewBuilder
    func reverseMask<Content: View>(@ViewBuilder content: @escaping () -> Content) -> some View {
        self.mask {
            Rectangle()
                .overlay(alignment: .topLeading) {
                    content()
                        .blendMode(.destinationOut)
                }
        }
    }
}

