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
    
    let cornerRadius: CGFloat = 12.0
    let fontSize: CGFloat = 32.0
}


struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View{
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                Text(card.content)
            } else {
                if !card.isMatched  {
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                    //RoundedRectangle(cornerRadius: cornerRadius).fill(LinearGradient(gradient: Gradient(colors: [.white, .black]), startPoint: .top, endPoint: .bottom))
                }
            }
        }
            //.aspectRatio(2/3, contentMode: .fit) // HW Lecture 2
            .font(Font.system(size: fontSize(for: size)))
    }
    
    //MARK: - Drawing Constants
    
    let cornerRadius: CGFloat = 12.0
    let edgeLineWidth: CGFloat = 3.0
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.65
    }
}

    //MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
