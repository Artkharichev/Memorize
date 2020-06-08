//
//  EmojiMemoryGameTheme.swift
//  Memorize
//
//  Created by Артём Харичев on 07.06.2020.
//  Copyright © 2020 Artem Kharichev. All rights reserved.
//

import SwiftUI

struct Theme {
    var name: String
    var setOfEmojis: Array<String>
    var numberOfPairForShow: Int?
    var themeColor: Color
}

let themes: [Theme] = [
    
    Theme(name: "Halloween",
          setOfEmojis: ["👻","🎃","🕷","🧟‍♂️","🦉","💀","🕸","🐞","🦇","🐺","🖤","👺"],
          numberOfPairForShow: 9,
          themeColor: .orange),
    
    Theme(name: "Sport",
          setOfEmojis: ["🏀","⚽️","🏈","🎱","🥊","⛸","🏒","🛹","⛷","🏄🏻","🥌","🏓"],
          numberOfPairForShow: nil,
          themeColor:  .blue),
    
    Theme(name: "Animals",
          setOfEmojis: ["🐼","🦆","🐝","🐙","🐫","🦜","🦥","🦩","🐕","🐭","🙈","🐧"],
          numberOfPairForShow: nil,
          themeColor:  .yellow),
    
    Theme(name: "Food",
          setOfEmojis: ["🍏","🥑","🌶","🥩","🧀","🍕","🥕","🥥","🍉","🥨","🍳","🥞"],
          numberOfPairForShow: nil,
          themeColor:  .green),
    
    Theme(name: "Flags",
          setOfEmojis: ["🇷🇺","🇮🇱","🇮🇹","🇩🇪","🇹🇷","🇬🇷","🇵🇱","🇲🇪","🇨🇾","🇦🇹","🇬🇪","🇨🇿"],
          numberOfPairForShow: nil,
          themeColor:  .gray),
    
    Theme(name: "Faces",
          setOfEmojis: ["😍","😎","😡","🥶","🥺","🤪","😉","😮","💩","🙀","🤕","🤔"],
          numberOfPairForShow: nil,
          themeColor:  .purple)
]

