//
//  Island.swift
//  BattleFly
//
//  Created by Serhii Mokliuchenko on 05.09.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import SpriteKit
import GameplayKit

final class Island: SKSpriteNode, GameBackgroundSpriteable {
    
    static func populate(at point: CGPoint?) -> Island {
        
        let islandImageName = configureName()
        let island = Island(imageNamed: islandImageName)
        island.setScale(randomScaleFactor)
        island.position = point ?? randomPoint()
        island.zPosition = 1
        island.name = "sprite"
        island.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        island.run(rotateForRandomAngle())
        island.run(move(from: island.position ))
        
        return island
    }
    
    static func populate(at point: CGPoint) -> Island {
        
        let islandImageName = configureName()
        let island = Island(imageNamed: islandImageName)
        island.setScale(randomScaleFactor)
        island.position = point
        island.zPosition = 1
        island.run(rotateForRandomAngle())
        island.run(move(from: island.position ))
        
        return island
    }
    
    fileprivate static func configureName() -> String {
        
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 4)
        let randomNamber = distribution.nextInt()
        let imageName = "is\(randomNamber)"
        
        return imageName
    }
    
    fileprivate static var randomScaleFactor: CGFloat {
        
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 10)
        let randomNamber = CGFloat(distribution.nextInt() / 10)
        
        return randomNamber
    }
    
    fileprivate static func rotateForRandomAngle() -> SKAction {
        
        let distribution = GKRandomDistribution(lowestValue: 0, highestValue: 360)
        let randomNamber = CGFloat(distribution.nextInt())
        let randomRadianNumber = randomNamber * CGFloat(Double.pi / 180)
        
        return SKAction.rotate(toAngle: randomRadianNumber, duration: 0)
    }
    
    fileprivate static func move(from point: CGPoint) -> SKAction {
        
        let movePoint = CGPoint(x: point.x, y: -200)
        let moveDistance = point.y + 200
        let movementSpeed: CGFloat = 100.0
        let duration = moveDistance / movementSpeed
        
        return SKAction.move(to: movePoint, duration: TimeInterval(duration))
    }
}
