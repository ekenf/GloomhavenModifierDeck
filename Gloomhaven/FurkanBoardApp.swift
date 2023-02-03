//
//  FurkanBoardApp.swift
//  FurkanBoard
//
//  Created by Salihcan Kahya on 1.11.2022.
//

import SwiftUI

@main
struct FurkanBoardApp: App {
    var body: some Scene {
        WindowGroup {
            SuffleView(viewModel: .init(deck: CardFactory().getCardListByNumber()))
        }
    }
}
