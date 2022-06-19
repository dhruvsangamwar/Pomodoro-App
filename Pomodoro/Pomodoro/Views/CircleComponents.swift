//
//  CircleComponents.swift
//  Pomodoro
//
//  Created by Leptos on 5/25/22.
//

import SwiftUI

struct CircleComponents: View {
    let isSplashScreen: Bool
    
    var body: some View {
        ZStack {
            
        }
        .overlay(alignment: isSplashScreen ? .topLeading : .bottomLeading) {
            ZStack(alignment: isSplashScreen ? .bottomTrailing : .topTrailing) {
                Circle()
                    .fill(Color.themeTertiary)
                    .frame(width: 470, height: 470)
                    .rotationEffect(.degrees(-179.72))
                
                Ellipse()
                    .fill(Color.themeSecondary)
                    .frame(width: 400, height: 402)
                    .rotationEffect(.degrees(-179.72))
                
                Ellipse()
                    .fill(Color.themePrimary)
                    .frame(width: 312, height: 302)
                    .rotationEffect(.degrees(0))
            }
        }
        .overlay(alignment: isSplashScreen ? .bottomTrailing : .topTrailing) {
            ZStack(alignment: isSplashScreen ? .topLeading : .bottomLeading) {
                Circle()
                    .fill(Color.themeTertiary)
                    .frame(width: 470, height: 470)
                    .rotationEffect(.degrees(-179.72))
                
                Ellipse()
                    .fill(Color.themeSecondary)
                    .frame(width: 400, height: 402)
                    .rotationEffect(.degrees(-179.72))
                
                Ellipse()
                    .fill(Color.themePrimary)
                    .frame(width: 312, height: 302)
                    .rotationEffect(.degrees(0))
            }
        }
        .ignoresSafeArea(.all)
    }
}

struct CircleComponents_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CircleComponents(isSplashScreen: true)
        }
        VStack {
            CircleComponents(isSplashScreen: false)
        }
    }
}
