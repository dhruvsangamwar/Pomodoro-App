//
//  SwipeView.swift
//  Pomodoro
//
//  Created by Dhruv Sangamwar on 5/27/22.
//

import SwiftUI

struct Card: Identifiable, Equatable {
    let id = UUID()
    let Statement: String
    let breaktime: Int
    let worktime: Double
}

final class Deck: ObservableObject {
    
    var count: Int {
        return cards.count
    }
    
    func position(of card: Card) -> Int {
        return cards.firstIndex(of: card) ?? 0
    }
    
    func scale(of card: Card) -> CGFloat {
        let deckPosition = position(of: card)
        let scale = CGFloat(deckPosition) * 0.02
        return (1 - scale)
    }
    
    func deckOffset(of card: Card) -> CGFloat {
        let deckPosition = position(of: card)
        let offset = deckPosition * -10
        return CGFloat(offset)
    }
    
    func zIndex(of card: Card) -> Double {
        return Double(count - position(of: card))
    }
    
    func moveToBack(_ state: Card) {
        let topCard = cards.remove(at: position(of: state))
        cards.append(topCard)
    }
    
    func moveToFront(_ state: Card) {
        let topCard = cards.remove(at: position(of: state))
        cards.insert(topCard, at: 0)
    }
    
    @Published var cards = [
        Card(Statement: "Each interval consists of 25 minutes of work and 5 minutes of break", breaktime: 5, worktime: 25),
        Card(Statement: "Each interval consists of 35 minutes of work and 10 minutes of break", breaktime: 10, worktime: 35),
        Card(Statement: "Each interval consists of 45 minutes of work and 15 minutes of break", breaktime: 15, worktime: 45)
    ]
}

struct SwipeView: View {
    let card: Card
    
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        ZStack {
            Text(card.Statement)
                .font(.title3)
                .multilineTextAlignment(.center)
                .foregroundColor((colorScheme == .dark) ? .black : .white)
                .padding(.horizontal)
            Spacer()
        }
        .padding()
        .frame(width: 300, height: 125)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.themePrimary)
        )
    }
}


struct SwipeView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeView(card: Card(Statement: "Each interval consists of 45 minutes of work and 15 minutes of break", breaktime: 15, worktime: 25))
    }
}
