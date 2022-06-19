//
//  SplashScreen.swift
//  Pomodoro
//
//  Created by Leptos on 5/21/22.
//

import SwiftUI

struct SplashScreen: View {
    @ScaledMetric(relativeTo: .largeTitle) private var fontSize = 36
    
    var body: some View {
        //Component 1
        VStack{
            CircleComponents(isSplashScreen: true)
            
            Text("Pomodoro")
                .font(.custom("DM Serif Text Regular", size: fontSize))
                .foregroundColor(.primaryText)
                .multilineTextAlignment(.center)
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
