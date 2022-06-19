//
//  ContentView.swift
//  Pomodoro
//
//  Created by Leptos on 5/13/22.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("Username") private var name: String = ""
    @State private var childActive = false
    @State private var hasTextEntry: Bool = false
    
    var body: some View {
        NavigationView {
            SplashScreen()
                .navigationChild(isActive: $childActive) {
                    if hasTextEntry {
                        TaskView(userName: name)
                    } else {
                        NameEntryView(entry: $name)
                    }
                }
                .navigationBarHidden(true)
        }
        .task {
            do {
                try await Task.sleep(nanoseconds: 3 * NSEC_PER_SEC)
                hasTextEntry = !name.isEmpty
                childActive = true
            } catch {
                print("Task.sleep", error)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

