//
//  BitMaskCategory.swift
//  BattleFly
//
//  Created by Serhii Mokliuchenko on 06.09.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import SpriteKit

extension SKPhysicsBody {
    
    var category: BitMaskCategory {
        
        get { return BitMaskCategory.init(rawValue: self.categoryBitMask) }
        set { self.categoryBitMask = newValue.rawValue }
    }
}

struct BitMaskCategory: OptionSet {
    
    let rawValue: UInt32
    
    static let none    = BitMaskCategory(rawValue: 0 << 0)
    static let player  = BitMaskCategory(rawValue: 1 << 0)       // 0000 0000 0000 0000 0000 0000 0000 0001
    static let enemy   = BitMaskCategory(rawValue: 1 << 1)         // 0000 0000 0000 0000 0000 0000 0000 0010
    static let poverUp = BitMaskCategory(rawValue: 1 << 2)         // 0000 0000 0000 0000 0000 0000 0000 0100
    static let shot    = BitMaskCategory(rawValue: 1 << 3)         // 0000 0000 0000 0000 0000 0000 0000 1000
    static let all     = BitMaskCategory(rawValue: 1 << 1)
}
