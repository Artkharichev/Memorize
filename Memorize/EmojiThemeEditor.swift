//
//  EmojiThemeEditor.swift
//  Memorize
//
//  Created by Артём Харичев on 14.07.2020.
//  Copyright © 2020 Artem Kharichev. All rights reserved.
//

import SwiftUI

struct EmojiThemeEditor: View {
    
    var theme: Theme
    
    @EnvironmentObject var store: EmojiThemeStore
    
    @Binding var isShowing: Bool
    @Binding var editMode: EditMode
    
    @State private var themeName: String = ""
    @State private var newEmoji: String = ""
    @State private var emojis: [String] = []
    @State private var numberOfPairs = 2
    @State private var color : UIColor.RGB?
    @State private var removeEmoji: [String] = []
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Text(theme.name).font(Font.headline)
                HStack {
                    Button(action: {
                        self.isShowing = false
                    }, label: { Text ("Cancel")}).padding().foregroundColor(.red)
                    Spacer()
                    Button(action: {
                        self.updateTheme()
                        self.isShowing = false
                        }, label: { Text("Done")}).padding()
                }
            }
            Divider()
            GeometryReader { geometry in
                Form {
                   
                    // Theme Name
                    Section {
                        TextField("Theme Name", text: self.$themeName)
                    }
                    
                    // Add Emoji
                    Section(header: Text("Add Emoji").font(Font.callout)) {
                        HStack{
                            TextField("Emoji", text: self.$newEmoji)
                            Spacer()
                            Button(action: {
                                self.newEmoji.forEach{ self.emojis.append(String($0))}
                                self.newEmoji = ""
                                
                            }, label: { Text("Add") })
                            .disabled(self.newEmoji.isEmpty)
                        }
                    }
                    
                    // Emojis
                    Section(header:
                        HStack {
                            Text("Emojis").font(Font.callout)
                            Spacer()
                            Text("tap emoji to exclude")
                        }
                    ) {
                        EmojisSection(emojis: self.$emojis) { emoji in
                            self.removeEmoji.append(emoji)
                        }
                        HStack {
                            Image(systemName: "trash")
                            EmojisSection(emojis: self.$removeEmoji) { emoji in
                                self.emojis.append(emoji)
                            }
                        }
                    }
                    
                    // Card Count
                    Section(header: Text("Card Count").font(Font.callout)) {
                        HStack{
                            Text("\(self.numberOfPairs) Pairs")
                            Spacer()
                            Stepper("", value: self.$numberOfPairs, in: 2...self.theme.setOfEmojis.count)
                        }
                    }
                    
                    // Color
                    Section(header: Text("Color").font(Font.callout)) {
                        ColorPalette() { color in
                            self.color = color
                        }
                        .frame(width: geometry.size.width * 0.9, height: 200)
                    }
                }
            }
        }
        .onAppear {
            self.themeName = self.theme.name
            self.emojis = self.theme.setOfEmojis
            self.numberOfPairs = self.theme.numberOfPairForShow
        }
        .onDisappear {
            withAnimation {
                self.editMode = .inactive
            }
        }
    }
    
    func updateTheme() {
        let name = self.themeName.isEmpty ? theme.name : self.themeName
        let color = self.color ?? theme.themeColor
        
        let newTheme = Theme(name: name, setOfEmojis: emojis, numberOfPairForShow: numberOfPairs, themeColor: color)
        
        for index in store.themes.indices {
            if store.themes[index].id == theme.id {
                store.themes[index] = newTheme
            }
        }
    }
}

struct EmojisSection: View {
    
    @Binding var emojis: [String]
    
    var removeEmoji: (String) -> Void
    
    var body: some View {
        Grid(emojis, id: \.self) { emoji in
            Text(emoji).font(Font.system(size: self.fontSize))
                .onTapGesture {
                    if let emoji = self.emojis.removeLast(matching: emoji) {
                        self.removeEmoji(emoji)
                    }
                    
            }
        }
        .frame(height: self.height)
    }
    
    //MARK: - Drawing constants
    
    var height: CGFloat {
        CGFloat((emojis.count - 1) / 6) * 70 + 70
    }
    
    let fontSize: CGFloat = 40
}

