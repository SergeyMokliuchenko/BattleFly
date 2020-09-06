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
        
        //physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector.zero
        
        configureStartScene()
        spawnClouds()
        spawnIslands()
        player.performFly()
        spawnEnemies()
        spawnPowerUp()
    }
    
    fileprivate func spawnEnemies() {
        
        let waitAction = SKAction.wait(forDuration: 3.0)
        let spawnSpiralAction = SKAction.run { [unowned self] in
            self.spawnSpiralOfEnemies()
        }
        
        let spawnAction = SKAction.sequence([waitAction, spawnSpiralAction])
        let repeatAction = SKAction.repeatForever(spawnAction)
        self.run(repeatAction)
    }
    
    fileprivate func spawnPowerUp() {
        
        let spawnAction = SKAction.run { [unowned self] in
            let randomNumber = Int(arc4random_uniform(2))
            let powerUp = randomNumber == 1 ? GreenPowerUp() : BluePowerUp()
            
            let randomPositionX = CGFloat(arc4random_uniform(UInt32(self.size.width - 30)))
            let positionY = self.size.height + 100
            
            powerUp.position = CGPoint(x: randomPositionX, y: positionY)
            powerUp.startMovement()
            self.addChild(powerUp)
        }
        
        let randomTimeSpown = Double(arc4random_uniform(11) + 10)
        let waitAction = SKAction.wait(forDuration: randomTimeSpown)
        
        let spawnActionSequense = SKAction.sequence([spawnAction, waitAction])
        let repeatAction = SKAction.repeatForever(spawnActionSequense)
        self.run(repeatAction)
    }
    
    fileprivate func spawnSpiralOfEnemies() {
        
        let enemyTextureAtlas1 = Assets.shared.enemy_1Atlas
        let enemyTextureAtlas2 = Assets.shared.enemy_2Atlas
        
        SKTextureAtlas.preloadTextureAtlases([enemyTextureAtlas1, enemyTextureAtlas2]) { [unowned self] in
            
            let randomNumber = Int(arc4random_uniform(2))
            let arrayOfAtlases = [enemyTextureAtlas1, enemyTextureAtlas2]
            let textureAtlas = arrayOfAtlases[randomNumber]
            let waitAction = SKAction.wait(forDuration: 1.0)
            
            let spawnEnemy = SKAction.run { [unowned self] in
                let textureNames = textureAtlas.textureNames.sorted()
                let texture = textureAtlas.textureNamed(textureNames[12])
                let enemy = Enemy(enemyTexture: texture)
                enemy.position = CGPoint(x: self.size.width / 2, y: self.size.height + 150 )
                self.addChild(enemy)
                enemy.flySpiral()
            }
            
            let spawnAction = SKAction.sequence([waitAction, spawnEnemy])
            let repeatAction = SKAction.repeat(spawnAction, count: 3)
            self.run(repeatAction)
        }
    }
    
    fileprivate func configureStartScene() {
        
        let screenCenterPoint = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        let background = Background.populateBackground(at: screenCenterPoint)
        background.size = self.size
        self.addChild(background)
        
        let screen = UIScreen.main.bounds

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
        enumerateChildNodes(withName: "sprite") { (node, _) in
            if node.position.y <= -100 {
                node.removeFromParent()
            }
        }
        
        enumerateChildNodes(withName: "shotSprite") { (node, _) in
            if node.position.y >= self.size.height + 100 {
                node.removeFromParent()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        playerFire()
    }
    
    fileprivate func playerFire() {
        let shot = YellowShot()
        shot.position = self.player.position
        shot.startMovement()
        self.addChild(shot)
    }
}

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let contactCategory: BitMaskCategory = [contact.bodyA.category, contact.bodyB.category]
        switch contactCategory {
        case [.player, .enemy]: print("player vs enemy")
        case [.player, .poverUp]: print("player vs poverUp")
        case[.enemy, .shot]: print("enemy vs shot")
        default: preconditionFailure("Unable to detect collision category")
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        
    }
}
