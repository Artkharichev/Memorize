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
                
                Text(self.viewModel.theme.name).foregroundColor(themeColor)
                Spacer()
                
                Button("New Game") {
                    withAnimation(.easeInOut) {
                        self.viewModel.newGame()
                    }
                }
                .padding(.horizontal)
                .foregroundColor(.black)
                .background(themeColor)
                .cornerRadius(cornerRadius)
            }.padding()
                .font(Font.system(size: fontSize))
            
            Grid (viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear) {
                        self.viewModel.choose(card: card)
                    }
                }
                .padding(5)
            }
            .padding()
            .foregroundColor(themeColor)
            
            Text("Score: \(self.viewModel.score)")
        }.font(Font.system(size: fontSize))
    }
    
    private let cornerRadius: CGFloat = 10.0
    private let fontSize: CGFloat = 32.0
    private var themeColor: Color {
        Color.init(self.viewModel.theme.themeColor)
    }
}


struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View{
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngel: Angle.degrees(0-90), endAngel: Angle.degrees(-animatedBonusRemaining*360-90), clockwise: true)
                            
                            .onAppear {
                                self.startBonusTimeAnimation()
                        }
                    } else {
                        Pie(startAngel: Angle.degrees(0-90), endAngel: Angle.degrees(-card.bonusRemaining*360-90), clockwise: true)
                        
                    }
                    }.padding(5).opacity(0.4)
                
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
        }
    }
    
    //MARK: - Drawing Constants
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.65
    }
}

//MARK: - Preview

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        let game = EmojiMemoryGame()
//        game.choose(card: game.cards[0])
//        return EmojiMemoryGameView(viewModel: game)
//    }
//}
