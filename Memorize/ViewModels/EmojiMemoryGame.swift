//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Артём Харичев on 01.06.2020.
//  Copyright © 2020 Artem Kharichev. All rights reserved.
//
//  View Model

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    //@Published -> objectWillChange.send()
    @Published private var model: MemoryGame<String>
    
    let theme: Theme
    
    init(theme: Theme){
        self.theme = theme
        self.model = EmojiMemoryGame.createMemoryGame(with: theme)
    }
    
    private static func createMemoryGame(with theme: Theme) -> MemoryGame<String> {
        let emojis = theme.setOfEmojis.shuffled()
        let numberOfPairsOfCards = theme.numberOfPairForShow //?? Int.random(in: 3...6)
        return MemoryGame<String>(numberOfPairsOfCards: numberOfPairsOfCards) { emojis[$0] }
    }
    
    //MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    var score: Int {
        model.score
    }
    
    //MARK: - Intents
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func newGame() {
        model = EmojiMemoryGame.createMemoryGame(with: theme)
    }
}
