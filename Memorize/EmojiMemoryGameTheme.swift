//
//  EmojiMemoryGameTheme.swift
//  Memorize
//
//  Created by Артём Харичев on 07.06.2020.
//  Copyright © 2020 Artem Kharichev. All rights reserved.
//

import SwiftUI

struct Theme: Codable {
    var name: String
    var setOfEmojis: Array<String>
    var numberOfPairForShow: Int
    var themeColor: UIColor.RGB
    
    var json: Data? {
       try? JSONEncoder().encode(self)
    }
    
    
}

let themes: [Theme] = [
    
    Theme(name: "Halloween",
          setOfEmojis: ["👻","🎃","🕷","🧟‍♂️","🦉","💀","🕸","🐞","🦇","🐺","🖤","👺"],
          numberOfPairForShow: 9,
          themeColor: .init(red: 0.991, green: 0.509, blue: 0.033, alpha: 1.0)),
    
    Theme(name: "Sport",
          setOfEmojis: ["🏀","⚽️","🏈","🎱","🥊","⛸","🏒","🛹","⛷","🏄🏻","🥌","🏓"],
          numberOfPairForShow: 6,
          themeColor: .init(red: 0.041, green: 0.375, blue: 0.998, alpha: 1.0)),
    
    Theme(name: "Animals",
          setOfEmojis: ["🐼","🦆","🐝","🐙","🐫","🦜","🦥","🦩","🐕","🐭","🙈","🐧"],
          numberOfPairForShow: 9,
          themeColor: .init(red: 0.161, green: 0.781, blue: 0.197, alpha: 1.0)),
    
    Theme(name: "Food",
          setOfEmojis: ["🍏","🥑","🌶","🥩","🧀","🍕","🥕","🥥","🍉","🥨","🍳","🥞"],
          numberOfPairForShow: 6,
          themeColor: .init(red: 0.995, green: 0.764, blue: 0.037, alpha: 0.9)),
    
    Theme(name: "Flags",
          setOfEmojis: ["🇷🇺","🇮🇱","🇮🇹","🇩🇪","🇹🇷","🇬🇷","🇵🇱","🇲🇪","🇨🇾","🇦🇹","🇬🇪","🇨🇿"],
          numberOfPairForShow: 4,
          themeColor: .init(red: 0.984, green: 0.051, blue: 0.267, alpha: 1.0)),
    
    Theme(name: "Faces",
          setOfEmojis: ["😍","😎","😡","🥶","🥺","🤪","😉","😮","💩","🙀","🤕","🤔"],
          numberOfPairForShow: 6,
          themeColor: .init(red: 0.616, green: 0.200, blue: 0.839, alpha: 1.0))
]

