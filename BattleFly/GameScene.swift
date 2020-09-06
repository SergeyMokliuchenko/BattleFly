//
//  GameScene.swift
//  BattleFly
//
//  Created by Serhii Mokliuchenko on 05.09.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var player: PlayerPlane!
    
    override func didMove(to view: SKView) {
        
        configureStartScene()
        spawnClouds()
        spawnIslands()
        player.performFly()
        
        let powerUp = PowerUp()
        powerUp.performRotation()
        powerUp.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        self.addChild(powerUp)
    }
    
    fileprivate func configureStartScene() {
        
        let screenCenterPoint = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        let background = Background.populateBackground(at: screenCenterPoint)
        background.size = self.size
        self.addChild(background)
        
        let screen = UIScreen.main.bounds
        
//        let island1 = Island.populate(at: CGPoint(x: 200, y: 200))
//        self.addChild(island1)
//        let island2 = Island.populate()
//        self.addChild(island2)
//        let island3 = Island.populate()
//        self.addChild(island3)
//
//        let cloud = Cloud.populate()
//        self.addChild(cloud)

        player = PlayerPlane.populate(at: CGPoint(x: screen.size.width / 2, y: 100))
        self.addChild(player)
        

    }
    
    fileprivate func spawnClouds() {
        
        let spawnCloudWait = SKAction.wait(forDuration: 2)
        let spawnCloudAction = SKAction.run {
            let cloud = Cloud.populate(at: nil)
            self.addChild(cloud)
        }
        
        let spownCloudSequence = SKAction.sequence([spawnCloudWait, spawnCloudAction])
        let spownCloudForever = SKAction.repeatForever(spownCloudSequence)
        run(spownCloudForever)
    }
    
    fileprivate func spawnIslands() {
        
        let spawnIslandWait = SKAction.wait(forDuration: 0.5)
        let spawnIslandAction = SKAction.run {
            let island = Island.populate(at: nil)
            self.addChild(island)
        }
        
        let spownIslandSequence = SKAction.sequence([spawnIslandWait, spawnIslandAction])
        let spownIslandForever = SKAction.repeatForever(spownIslandSequence)
        run(spownIslandForever)
    }
     
    override func didSimulatePhysics() {
        super.didSimulatePhysics()
        
        player.checkPosition()
        enumerateChildNodes(withName: "backgroundSprite") { (node, _) in
            if node.position.y < -199 {
                node.removeFromParent()
            }
        }
    }
}
