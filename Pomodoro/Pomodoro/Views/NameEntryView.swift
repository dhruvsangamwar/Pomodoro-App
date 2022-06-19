//
//  NameEntryView.swift
//  Pomodoro
//
//  Created by Leptos on 5/21/22.
//

import SwiftUI

struct NameEntryView: View {
    @Binding var entry: String
    @State private var childActive = false
    
    @ScaledMetric(relativeTo: .title) private var titleFontSize = 29
    @ScaledMetric(relativeTo: .body) private var inputFontSize = 14
    
    @State private var isSplashScreen: Bool = true
    
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack {
            CircleComponents(isSplashScreen: isSplashScreen)
                .onAppear {
                    withAnimation(.spring(dampingFraction: 0.6)) {
                        isSplashScreen = false
                    }
                }
            
            Text("What should we call you?")
                .font(.custom("DM Sans Medium", size: titleFontSize))
                .foregroundColor(.primaryText)
                .tracking(-0.5).multilineTextAlignment(.center)
                .background{
                    switch colorScheme {
                    case .light:
                        Color.white
                            .blur(radius: 15, opaque: false)
                        
                    case .dark:
                        Color.black
                            .blur(radius: 15, opaque: false)
                        
                    @unknown default:
                        EmptyView()
                    }
                }
            
            TextField("Username", text: $entry)
                .font(.custom("Mulish Medium", size: inputFontSize))
                .foregroundColor(.primaryText)
                .textFieldStyle(.roundedBorder)
                .onSubmit(of: .text) {
                    childActive = true
                }
                .scenePadding()
                .navigationChild(isActive: $childActive) {
                    TaskView(userName: entry)
                }
                .navigationBarHidden(true)
                .background{
                    switch colorScheme {
                    case .light:
                        Color.white
                            .blur(radius: 15, opaque: false)
                        
                    case .dark:
                        Color.black
                            .blur(radius: 15, opaque: false)
                        
                    @unknown default:
                        EmptyView()
                    }
                }
        }
    }
}

struct NameEntryView_Previews: PreviewProvider {
    static var previews: some View {
        NameEntryView(entry: .constant("Name"))
    }
}
