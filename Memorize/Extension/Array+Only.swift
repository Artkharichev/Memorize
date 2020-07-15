//
//  Array+Only.swift
//  Memorize
//
//  Created by Артём Харичев on 04.06.2020.
//  Copyright © 2020 Artem Kharichev. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
