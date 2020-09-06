//
//  YellowShot.swift
//  BattleFly
//
//  Created by Serhii Mokliuchenko on 06.09.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import SpriteKit

class YellowShot: Shot {
    
    init() {
        let texture = Assets.shared.yellowAmmoAtlas
        super.init(textureAtlas: texture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
