//
//  Assets.swift
//  BattleFly
//
//  Created by Serhii Mokliuchenko on 06.09.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import SpriteKit

class Assets {
    
    static let shared = Assets()
    private init() {}
    
    let playerPlaneAtlas = SKTextureAtlas(named: "PlayerPlane")
    let bluePowerUpAtlas = SKTextureAtlas(named: "BluePowerUp")
    let greenPowerUpAtlas = SKTextureAtlas(named: "GreenPowerUp")
    let enemy_1Atlas = SKTextureAtlas(named: "Enemy_1")
    let enemy_2Atlas = SKTextureAtlas(named: "Enemy_2")
    let yellowAmmoAtlas = SKTextureAtlas(named: "YellowAmmo")
    
    func preloadAtlases() {
        
        playerPlaneAtlas.preload { print("PlayerPlane preloaded") }
        bluePowerUpAtlas.preload { print("BluePowerUp preloaded") }
        greenPowerUpAtlas.preload { print("GreenPowerUp preloaded") }
        enemy_1Atlas.preload { print("Enemy_1 preloaded") }
        enemy_2Atlas.preload { print("Enemy_2 preloaded") }
        yellowAmmoAtlas.preload { print("YellowAmmo preloaded") }
    }
}
