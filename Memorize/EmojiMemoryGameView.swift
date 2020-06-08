//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Артём Харичев on 01.06.2020.
//  Copyright © 2020 Artem Kharichev. All rights reserved.
//
//  View

import SwiftUI

struct EmojiMemoryGameView: View {
    // @ObservedObject - Redraw (update)
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        
        VStack  {
            HStack{
                
                Text(self.viewModel.theme.name).foregroundColor(self.viewModel.theme.themeColor)
                Spacer()
                
                Button("New Game") {
                    self.viewModel.newGame()
                }
                .padding(.horizontal)
                .foregroundColor(.black)
                .background(self.viewModel.theme.themeColor)
                .cornerRadius(cornerRadius)
            }.padding()
                .font(Font.system(size: fontSize))
            
            Grid (viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
                .padding(5)
            }
            .padding()
            .foregroundColor(self.viewModel.theme.themeColor)
            
            Text("Score: \(self.viewModel.score)")
        }.font(Font.system(size: fontSize))
    }
    
    private let cornerRadius: CGFloat = 12.0
    private let fontSize: CGFloat = 32.0
}


struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View{
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Pie(startAngel: Angle.degrees(0-90), endAngel: Angle.degrees(110-90), clockwise: true)
                    .padding(5).opacity(0.4)
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    //MARK: - Drawing Constants
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.65
    }
}

//MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
