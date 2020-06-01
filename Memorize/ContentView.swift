//
//  ContentView.swift
//  Memorize
//
//  Created by Артём Харичев on 01.06.2020.
//  Copyright © 2020 Artem Kharichev. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var viewModel: EmojiMemoryGame

    var body: some View {
        
        return HStack {
            ForEach(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
            }
        }
        .padding()
        .foregroundColor(.orange)
        .font((viewModel.cards.count >= 10 ? Font.footnote : Font.largeTitle))
    }
}


struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View{
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3.0)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10.0).fill()
            }
        }
        .aspectRatio(2/3, contentMode: .fit)
    }
}





























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
    }
}
