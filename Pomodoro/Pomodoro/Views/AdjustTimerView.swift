//
//  AdjustTimerView.swift
//  Pomodoro
//
//  Created by Dhruv Sangamwar on 5/27/22.
//

import SwiftUI

struct AdjustTimerView: View {
    
    @State private var BreakTime: Float = 0.0
    @State private var childActive = false
    @State private var isSplashScreen: Bool = false
    @StateObject private var deck = Deck()
    var task: String
    
    @ScaledMetric(relativeTo: .title) private var inputFontSize = 32
    
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        //Title
        VStack {
            Spacer()
            
            Text("Adjust your cycle")
                .font(.custom("DM Serif Text Regular", size: inputFontSize))
                .foregroundColor(.primaryText)
                .tracking(-0.5)
                .background{
                    switch colorScheme {
                    case .light:
                        Color.white
                            .blur(radius: 15)
                        
                    case .dark:
                        Color.black
                            .blur(radius: 15)
                        
                    @unknown default:
                        EmptyView()
                    }
                }
                .padding(.vertical, 40)
            
            ZStack {
                ForEach(deck.cards) { card in
                    CardView(card: card, deck: deck)
                        .onTapGesture {
                            childActive = true
                        }
                }
            }
            Spacer()
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            CircleComponents(isSplashScreen: isSplashScreen)
                .onAppear {
                    withAnimation(.spring(dampingFraction: 0.6)) {
                        isSplashScreen = true
                    }
                }
        }
        .navigationChild(isActive: $childActive) {
            if let card = deck.cards.first {
                CountdownView(taskTitle: task, countdown: .init(duration: card.worktime * 60))
            }
        }
    }
}

struct CardView: View {
    private enum MoveDirection {
        case back, front
    }
    
    let card: Card
    @ObservedObject var deck: Deck
    
    @State private var moveDirection: MoveDirection? = .none
    @State private var offset: CGSize = .zero
    
    var rotation: Angle {
        .degrees(offset.width / 20.0)
    }
    
    var body: some View {
        SwipeView(card: card)
            .zIndex(self.deck.zIndex(of: card))
            .shadow(radius: 2)
            .offset(x: offset.width, y: offset.height)
            .scaleEffect(x: self.deck.scale(of: card), y: self.deck.scale(of: card))
            .gesture(
                DragGesture()
                    .onChanged { drag in
                        let translation = drag.translation
                        let xDiff = (translation.width - offset.width)
                        let yDiff = (translation.height - offset.height)
                        let distance = sqrt(xDiff.magnitudeSquared + yDiff.magnitudeSquared)
                        
                        if distance > 0.01 {
                            withAnimation(.spring()) {
                                self.offset = translation
                            }
                        }
                        
                        if translation.width.magnitude > 200
                            || translation.height.magnitude > 250 {
                            moveDirection = .back
                        } else {
                            moveDirection = .front
                        }
                    }
                    .onEnded { drag in
                        withAnimation(.spring()) {
                            offset = .zero
                            
                            switch moveDirection {
                            case .back:
                                deck.moveToBack(card)
                            case .front:
                                deck.moveToFront(card)
                            default:
                                break
                            }
                        }
                    }
            )
            .rotationEffect(rotation)
    }
}

struct AdjustTimerView_Previews: PreviewProvider {
    static var previews: some View {
        AdjustTimerView(task: "Coding")
    }
}
