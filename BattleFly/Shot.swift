//
//  Shot.swift
//  BattleFly
//
//  Created by Serhii Mokliuchenko on 06.09.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import SpriteKit

class Shot: SKSpriteNode {
    
    fileprivate let screenSize = UIScreen.main.bounds
    fileprivate let initialSize = CGSize(width: 52, height: 52)
    fileprivate let textureAtlas: SKTextureAtlas!
    fileprivate var textureNameBeginWith: String!
    fileprivate var animationSpriteArray: [SKTexture] = []
    
    init(textureAtlas: SKTextureAtlas) {
        self.textureAtlas = textureAtlas
        let textureName = textureAtlas.textureNames.sorted()[0]
        let texture = textureAtlas.textureNamed(textureName)
        textureNameBeginWith = String(textureName.dropLast(6))
        super.init(texture: texture, color: .clear, size: initialSize)
        self.name = "shotSprite"
        self.zPosition = 30
        self.setScale(0.2)
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startMovement() {
        
        performRotation()
        let moveForward = SKAction.moveTo(y: screenSize.height + 100, duration: 2)
        self.run(moveForward)
    }
        
    fileprivate func performRotation() {
        
        for i in 1...32 {
            let number = String(format: "%02d", i)
            animationSpriteArray.append(SKTexture(imageNamed: textureNameBeginWith + number.description))
        }
            
        SKTexture.preload(animationSpriteArray) { [unowned self] in
            
            let rotation = SKAction.animate(with: self.animationSpriteArray, timePerFrame: 0.05, resize: true, restore: false)
            let rotationForever = SKAction.repeatForever(rotation)
            self.run(rotationForever)
        }
    }
}
