//
//  StanfordApp.swift
//  Stanford
//
//  Created by iosdev on 8.11.2023.
//

import SwiftUI

@main
struct StanfordApp: App {
    @StateObject var game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
