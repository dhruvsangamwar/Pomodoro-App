//
//  View+NavigationChild.swift
//  Pomodoro
//
//  Created by Leptos on 5/21/22.
//

import SwiftUI

extension View {
    @ViewBuilder
    func navigationChild<Child: View>(isActive: Binding<Bool>, @ViewBuilder child: () -> Child) -> some View {
        VStack {
            self
            NavigationLink(isActive: isActive, destination: child) {
                EmptyView()
            }
        }
    }
}
