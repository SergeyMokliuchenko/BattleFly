//
//  Cloud.swift
//  BattleFly
//
//  Created by Serhii Mokliuchenko on 05.09.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol GameBackgroundSprireable {
    static func populate() -> Self
    static func randomPoint() -> CGPoint
}

extension GameBackgroundSprireable {
    
    static func randomPoint() -> CGPoint {
        
        let screen = UIScreen.main.bounds
        let distribution = GKRandomDistribution(lowestValue: Int(screen.size.height) + 100, highestValue: Int(screen.size.height) + 200)
        let y = CGFloat(distribution.nextInt())
        let x = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.width)))
        
        return CGPoint(x: x, y: y)
    }
}

final class Cloud: SKSpriteNode, GameBackgroundSprireable {
    
    static func populate() -> Cloud {
        
        let cloudImageName = configureName()
        let cloud = Cloud(imageNamed: cloudImageName)
        cloud.setScale(randomScaleFactor)
        cloud.position = randomPoint()
        cloud.zPosition = 10
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
    
    fileprivate static func move(from point: CGPoint) -> SKAction {
        
        let movePoint = CGPoint(x: point.x, y: -200)
        let moveDistance = point.y + 200
        let movementSpeed: CGFloat = 15.0
        let duration = moveDistance / movementSpeed
        
        return SKAction.move(to: movePoint, duration: TimeInterval(duration))
    }
}
