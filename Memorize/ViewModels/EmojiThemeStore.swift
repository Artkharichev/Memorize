//
//  EmojiThemeStore.swift
//  Memorize
//
//  Created by Артём Харичев on 13.07.2020.
//  Copyright © 2020 Artem Kharichev. All rights reserved.
//
//  ViewModel - Theme Store

import SwiftUI
import Combine

class EmojiThemeStore: ObservableObject {
    
    @Published var themes = defaultThemes
    
    private var autosave: AnyCancellable?
    
    init() {
        if let data = UserDefaults.standard.array(forKey: EmojiThemeStore.userDefaultKey) {
            self.themes = data.compactMap { element in
                Theme(json: element as? Data)
            }
        }
        
        autosave = $themes.sink{ themes in
            let data = themes.map { $0.json }
            UserDefaults.standard.set(data, forKey: EmojiThemeStore.userDefaultKey)
        }
    }
    
    func addTheme() {
        themes.append(standartTheme)
    }
    
    private static var userDefaultKey = "EmojiThemeStore"
}
