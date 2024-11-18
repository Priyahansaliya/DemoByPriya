//
//  ActivityView.swift
//  DemoSwiftUIByPriya
//
//  Created by Priya Hansaliya on 10/09/24.
//

import SwiftUI

struct ActivityView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

public struct CommonActivityViews: View {
    @State var isLoading = true
    public var body: some View {
        ZStack {
            Color.black.opacity(0)
            HStack {
                Spacer()
                ActivityIndicatorViews(isVisible: $isLoading, type: .arcs(count: 1, lineWidth: 1)).frame(width: 50, height: 50).foregroundColor(.blue)
                Spacer()
            }
        }.ignoresSafeArea()
    }
}




#Preview {
    CommonActivityViews()
}



public struct ActivityIndicatorViews: View {

    public enum IndicatorType {
        case arcs(count: Int = 3, lineWidth: CGFloat = 2)
    }

    @Binding var isVisible: Bool
    var type: IndicatorType

    public init(isVisible: Binding<Bool>, type: IndicatorType) {
        _isVisible = isVisible
        self.type = type
    }

    public var body: some View {
        if isVisible {
            indicator
        } else {
            EmptyView()
        }
    }
    
    // MARK: - Private
    
    private var indicator: some View {
        ZStack {
            IndicatorView(count: 1)
        }
    }
}

struct IndicatorView: View {

    let count: Int
    let lineWidth: CGFloat = 2

    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<count, id: \.self) { index in
                IndicatorItemView(lineWidth: 5, index: index, count: count, size: geometry.size)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

struct IndicatorItemView: View {

    let lineWidth: CGFloat
    let index: Int
    let count: Int
    let size: CGSize

    @State private var rotation: Double = 0

    var body: some View {
        let animation = Animation.default
            .speed(Double.random(in: 0.2...0.5))
            .repeatForever(autoreverses: false)

        return Group { () -> Path in
            var p = Path()
            p.addArc(center: CGPoint(x: size.width / 2, y: size.height / 2),
                     radius: size.width / 2 - CGFloat(index) * CGFloat(count),
                     startAngle: .degrees(0),
                     endAngle: .degrees(Double(Int.random(in: 120...300))),
                     clockwise: true)
            return p.strokedPath(.init(lineWidth: lineWidth))
        }
        .frame(width: size.width, height: size.height)
        .rotationEffect(.degrees(rotation))
        .onAppear {
            rotation = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                withAnimation(animation) {
                    rotation = 360
                }
            }
        }
    }
}
