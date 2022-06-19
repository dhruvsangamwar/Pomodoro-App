//
//  AuroraEffect.swift
//  Pomodoro
//
//  Created by Dhruv Sangamwar on 5/26/22.
//

import SwiftUI

class CloudProvider: ObservableObject {
    let offset: CGSize
    let frameHeightRatio: CGFloat
    init() {
        frameHeightRatio = CGFloat.random(in: 0.7 ..< 1.4)
        offset = CGSize(width: CGFloat.random(in: -150 ..< 150),
                        height: CGFloat.random(in: -150 ..< 150))
    }
}

struct Cloud: View {
    
    @StateObject var provider = CloudProvider()
    @State var move = false
    let alignment: Alignment
    let proxy: GeometryProxy
    let color: Color
    let rotationStart: Double
    let duration: Double

    var body: some View {
        Circle()
            .fill(color)
            .frame(height: proxy.size.height /  provider.frameHeightRatio)
            .offset(provider.offset)
            .rotationEffect(.init(degrees: move ? rotationStart : rotationStart + 360))
            .animation(.linear(duration: duration).repeatForever(autoreverses: false), value: move)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
            .opacity(0.8)
            .onAppear {
                move.toggle()
            }
    }
}

struct FloatingClouds: View {
    @Environment(\.colorScheme) var scheme
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Cloud(alignment: .bottomTrailing,
                      proxy: proxy,
                      color: .bubbleBottomTrailing,
                      rotationStart: 0,
                      duration: 50)
                Cloud(alignment: .topTrailing,
                      proxy: proxy,
                      color: .bubbleTopTrailing,
                      rotationStart: 240,
                      duration: 40)
                Cloud(alignment: .bottomLeading,
                      proxy: proxy,
                      color: .bubbleBottomLeading,
                      rotationStart: 120,
                      duration: 70)
                Cloud(alignment: .topLeading,
                      proxy: proxy,
                      color: .bubbleTopLeading,
                      rotationStart: 180,
                      duration: 60)
            }
            .ignoresSafeArea()
        }
    }
}


struct BubbleEffect: View {
    var body: some View {
        FloatingClouds()
    }
}

struct AuroraEffect_Previews: PreviewProvider {
    static var previews: some View {
        BubbleEffect()
            .preferredColorScheme(.dark)
    }
}
