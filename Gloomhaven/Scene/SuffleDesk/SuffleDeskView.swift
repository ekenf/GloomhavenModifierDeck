//
//  SuffleDeskView.swift
//  FurkanBoard
//
//  Created by Salihcan Kahya on 1.11.2022.
//

import Foundation
import SwiftUI

struct SuffleView: View {
    @ObservedObject private var viewModel: SuffleDeskViewModel
    
    init(viewModel: SuffleDeskViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {
            VStack {
                if viewModel.discard.contains(where: {$0.title == "miss" || $0.title == "crit"}) {
                    Button {
                            let cards = viewModel.discard
                        cards.reversed().forEach { card in
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    withAnimation(.easeInOut(duration: 0.5) ) {
                                        let removedCard = viewModel.discard.removeLast()
                                        viewModel.deck.append(removedCard)
                                    }
                                }
                        }
//                        viewModel.deck.shuffle()
                    } label: {
                        Label("Shuffle", systemImage: "cross")
                    }
                }
                if viewModel.deck.count != 0 {
                    createCardStack()
                } else {
                    RoundedRectangle(cornerRadius: 0).fill(.clear)
                        .frame(height: 250)
                }
                createOpenedCardStack()
            }
            .padding()
        }
    }

    @ViewBuilder
    private func createCardStack() -> some View {
        VStack {
            ZStack {
                ForEach(viewModel.deck, id: \.id) { _ in
                    Image("back")
                        .resizable()
                        .cornerRadius(10)
                        .frame(width: viewModel.cardWidth, height: viewModel.cardWidth * viewModel.widthHeightRatio)
                }
            }

            HStack {
                Spacer()
                Text("\(viewModel.deck.count)")
            }
        }
        .onTapGesture {
            viewModel.closedCardTap()
        }
    }

    @ViewBuilder
    private func createOpenedCardStack() -> some View {
        VStack {
            ForEach((viewModel.discard.reversed().compactMap ({$0})), id: \.id) { card in
                DeskCardView(card: card, cardWidth: viewModel.cardWidth, cardHeight: viewModel.cardWidth * viewModel.widthHeightRatio)
                    .transition(.move(edge: .top))
                    .offset(y: -40)
            }
        }
    }
}



struct DeskCardView: View {
    let card: Card
    let cardWidth: Double
    let cardHeight: Double
    
    @State var backDegree: Double = 0.0
    @State var frontDegree: Double = -90.0
    @State var isFlipped = false
    
    let durationAndDelay : CGFloat = 0.3

    var body: some View {
        ZStack {
            // back
            Image("back")
                .resizable()
                .cornerRadius(10)
                .frame(width: cardWidth, height: cardHeight)
                .rotation3DEffect(Angle(degrees: backDegree), axis: (x: 1, y: 0, z: 0))

            // front
            if isFlipped {
                Image(card.title)
                    .resizable()
                    .cornerRadius(10)
                    .frame(width: cardWidth, height: cardHeight)
                    .rotation3DEffect(Angle(degrees: frontDegree), axis: (x: 1, y: 0, z: 0))
            }
        }
        .onAppear {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = 90
                isFlipped = true
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                frontDegree = 0
            }
        }
    }
}



struct DeskCardView_Previews: PreviewProvider {
    static var previews: some View {
        SuffleView(viewModel: .init(deck: CardFactory().getCardListByNumber()))
    }
}
