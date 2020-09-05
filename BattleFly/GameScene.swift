//
//  GameScene.swift
//  BattleFly
//
//  Created by Serhii Mokliuchenko on 05.09.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene {
    
    let motionManager = CMMotionManager()
    var xAcceleration: CGFloat = 0
    var player: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        
        let screenCenterPoint = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        let background = Background.populateBackground(at: screenCenterPoint)
        background.size = self.size
        self.addChild(background)
        
        let screen = UIScreen.main.bounds
        
        let island1 = Island.populate()
        island1.position = CGPoint(x: self.size.width - 100, y: self.size.height - 200)
        self.addChild(island1)
        
        let island2 = Island.populate()
        island2.position = CGPoint(x: 100, y: 200)
        self.addChild(island2)

        
        player = PlayerPlane.populate(at: CGPoint(x: screen.size.width / 2, y: 100))
        self.addChild(player)
    }
}
