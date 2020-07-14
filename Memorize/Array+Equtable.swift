//
//  Array+Equtable.swift
//  Memorize
//
//  Created by Артём Харичев on 14.07.2020.
//  Copyright © 2020 Artem Kharichev. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    func lastIndex(matching: Element) -> Int? {
        
        var indiciesFound: [Int] = []
        
        for index in 0..<self.count {
             if self[index] == matching {
               indiciesFound.append(index)
             }
           }
           return indiciesFound.last
    }
    
    mutating func removeLast(matching: Element) -> Element? {
        if let index = self.lastIndex(matching: matching) {
            return self.remove(at: index)
        } else {
            return nil
        }
    }
}
