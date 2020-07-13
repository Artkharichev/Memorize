//
//  EmojiThemeChooserView.swift
//  Memorize
//
//  Created by Артём Харичев on 13.07.2020.
//  Copyright © 2020 Artem Kharichev. All rights reserved.
//

import SwiftUI

struct EmojiThemeChooserView: View {
    
    @EnvironmentObject var store: EmojiThemeStore
    
    @State private var editMode: EditMode = .inactive
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading) {
                List {
                    ForEach(store.themes) { theme in
                        NavigationLink(destination:
                            EmojiMemoryGameView(viewModel: EmojiMemoryGame(theme: theme))
                        ) {
                               // Text(theme.name)
                            ThemeRow(theme: theme, editMode: self.$editMode)
                                .environmentObject(self.store)
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { self.store.themes.remove(at: $0)}
                    }
                }
            .navigationBarTitle("Memorize")
                .navigationBarItems(leading: Button(action: {
                    self.store.addTheme()
                }, label: {
                    Image(systemName: "plus").imageScale(.large)
                }), trailing: EditButton()
                )
                .environment(\.editMode, $editMode)
            }
        }
    }
}


struct ThemeRow: View {
    
    var theme: Theme
    
    @Binding var editMode: EditMode
    
    @EnvironmentObject var store: EmojiThemeStore
    
    @State private var showThemeEditor = false
    
    private var emojis: String {
        theme.setOfEmojis.reduce(into: "") { (result, emoji) in
            result.append(contentsOf: emoji)
        }
    }
    
    var body: some View {
        HStack {
            if editMode == .active {
                Image(systemName: "pencil.circle.fill")
                    .font(Font.system(size:self.iconFontSize))
                    .onTapGesture {
                        self.showThemeEditor = true
                }
            }
            VStack(alignment: .leading) {
                Text(theme.name).font(Font.title)
                Text(emojis).lineLimit(1)
            }
        }
        .foregroundColor(Color(theme.themeColor))
    }
    
    private let iconFontSize: CGFloat = 30
}

