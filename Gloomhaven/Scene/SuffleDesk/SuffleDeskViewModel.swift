//
//  SuffleDeskViewModel.swift
//  FurkanBoard
//
//  Created by Salihcan Kahya on 1.11.2022.
//

import SwiftUI

final class SuffleDeskViewModel: ObservableObject {

    @Published var deck: [Card]
    @Published var discard: [Card]
    @Published var isShuffle = false
    
    
    let cardWidth: Double = 357
    let widthHeightRatio: Double = 0.65

    init(deck: [Card]) {
        self.deck = deck
        self.discard = []
    }

    func closedCardTap() {
        guard !deck.isEmpty else { return }
        let randomCard = deck.removeLast()
        withAnimation {
            discard.append(randomCard)
        }
    }
}
