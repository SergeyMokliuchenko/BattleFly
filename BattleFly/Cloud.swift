//
//  Cloud.swift
//  BattleFly
//
//  Created by Serhii Mokliuchenko on 05.09.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import SpriteKit
import GameplayKit

final class Cloud: SKSpriteNode, GameBackgroundSpriteable {
    
    static func populate() -> Cloud {
        
        let cloudImageName = configureName()
        let cloud = Cloud(imageNamed: cloudImageName)
        cloud.setScale(randomScaleFactor)
        cloud.position = randomPoint()
        cloud.zPosition = randomPositionFactor
        cloud.run(move(from: cloud.position))
        
        return cloud
    }
    
    fileprivate static func configureName() -> String {
        
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 3)
        let randomNamber = distribution.nextInt()
        let imageName = "cl\(randomNamber)"
        
        return imageName
    }
    
    fileprivate static var randomScaleFactor: CGFloat {
        
        let distribution = GKRandomDistribution(lowestValue: 20, highestValue: 30)
        let randomNamber = CGFloat(distribution.nextInt() / 10)
        
        return randomNamber
    }
    
    fileprivate static var randomPositionFactor: CGFloat {
        
        let distribution = GKRandomDistribution(lowestValue: 15, highestValue: 25)
        let randomNamber = CGFloat(distribution.nextInt())
        
        return randomNamber
    }
    
    fileprivate static func move(from point: CGPoint) -> SKAction {
        
        let movePoint = CGPoint(x: point.x, y: -200)
        let moveDistance = point.y + 200
        let movementSpeed: CGFloat = 150.0
        let duration = moveDistance / movementSpeed
        
        return SKAction.move(to: movePoint, duration: TimeInterval(duration))
    }
}
