//
//  Card.swift
//  FurkanBoard
//
//  Created by Salihcan Kahya on 1.11.2022.
//
import SwiftUI
import Foundation

struct Card: Identifiable {
    let id = UUID()
    let title: String
}

struct CardFactory {
    func createCard(type: CardType) -> Card {
        return Card(title: type.rawValue)
    }

    func getCardListByNumber() -> [Card] {
        let allTypes = CardType.allCases
        var cardArray = [Card]()

        allTypes.forEach { type in
            let loopCount = type.defaultDeck()

            for _ in 0..<loopCount {
                cardArray.append(createCard(type: type))
            }
        }
        return cardArray.shuffled()
    }
}

enum CardType: String, CaseIterable {
    case zero
    case minusone
    case minustwo
    case plusone
    case plustwo
    case miss
    case crit

    func defaultDeck() -> Int {
        switch self {
            case .zero:
                return 6
            case .minusone, .plusone:
                return 5
            case .minustwo, .plustwo, .miss, .crit:
                return 1
        }
    }
}
