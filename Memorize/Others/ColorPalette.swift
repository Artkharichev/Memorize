//
//  ColorPalette.swift
//  Memorize
//
//  Created by Артём Харичев on 14.07.2020.
//  Copyright © 2020 Artem Kharichev. All rights reserved.
//

import SwiftUI

struct ColorPalette: View {
    
    @State private var selectedColor: UIColor?
    
    private let onTapColor: (UIColor.RGB) -> Void
    
    init(onTapColor: @escaping (UIColor.RGB) -> Void) {
      self.onTapColor = onTapColor
    }
    
    var body: some View {
        Grid(self.colorPaletteOptions, id: \.self) { color in
            ZStack {
                GeometryReader { geometry in
                    RoundedRectangle(cornerRadius: self.borderRadius)
                        .fill(Color(color))
                    RoundedRectangle(cornerRadius: self.borderRadius).stroke(lineWidth: self.borderWidth)
                        .foregroundColor(.black)
                    if self.selectedColor != nil && color == self.selectedColor {
                        HStack {
                            Spacer()
                            VStack(alignment: .trailing) {
                                Spacer()
                                Image(systemName: "checkmark.circle")
                                    .foregroundColor(.black)
                                    .frame(width: geometry.size.width * 0.3, height: geometry.size.height * 0.3)
                                    .padding(5)
                            }
                        }
                    }
                }
            }
            .frame(width: 60, height: 60)
            .onTapGesture {
                self.selectedColor = color
                let rgb = UIColor.RGB(red: color.rgb.red, green: color.rgb.green, blue: color.rgb.blue, alpha: color.rgb.alpha)
                
                self.onTapColor(rgb)
            }
        }
    }
    
    private let borderRadius: CGFloat = 10
    private let borderWidth: CGFloat = 1
    private let colorPaletteOptions: [UIColor] = [
        #colorLiteral(red: 0.984, green: 0.051, blue: 0.267, alpha: 1.0), #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.041, green: 0.375, blue: 0.998, alpha: 1.0), #colorLiteral(red: 1, green: 0.2527923882, blue: 1, alpha: 1), #colorLiteral(red: 0.616, green: 0.200, blue: 0.839, alpha: 1.0), #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1), #colorLiteral(red: 0.161, green: 0.781, blue: 0.197, alpha: 1.0), #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), #colorLiteral(red: 0.995, green: 0.764, blue: 0.037, alpha: 0.9)
    ]
}
