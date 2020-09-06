//
//  PlayerPlane.swift
//  BattleFly
//
//  Created by Serhii Mokliuchenko on 05.09.2020.
//  Copyright © 2020 Serhii Mokliuchenko. All rights reserved.
//

import SpriteKit
import CoreMotion

class PlayerPlane: SKSpriteNode {
    
    private let motionManager = CMMotionManager()
    private var xAcceleration: CGFloat = 0
    private let screenSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    
    private let animationSpriteStrides = [(13, 1, -1), (13, 26, 1), (13, 13, 1)]
    private var leftTextureAnimation: [SKTexture] = []
    private var rightTextureAnimation: [SKTexture] = []
    private var forwardTextureAnimation: [SKTexture] = []
    
    private var moveDirection: TurnDirection = .none
    private var stillTurning: Bool = false
    
    
    static func populate(at point: CGPoint) -> PlayerPlane {
        
        let playerPlaneTexture = SKTexture(imageNamed: "airplane_3ver2_13")
        let playerPlane = PlayerPlane(texture: playerPlaneTexture)
        playerPlane.setScale(0.4)
        playerPlane.position = point
        playerPlane.zPosition = 20
        
        return playerPlane
    }
    
    func checkPosition() {
        
        self.position.x += xAcceleration * 50
        if self.position.x < -70 {
            self.position.x = screenSize.width + 70
        } else if self.position.x > screenSize.width + 70 {
            self.position.x = -70
        }
    }
    
    func performFly() {
        
        preloadTextureArray()
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
            if let data = data {
                let acceleration = data.acceleration
                self.xAcceleration = CGFloat(acceleration.x) * 0.7 + self.xAcceleration * 0.3
            }
        }
        
        let planeWaitAction = SKAction.wait(forDuration: 1.0)
        let planeDirectionCheckAction = SKAction.run { [unowned self] in
            self.movementDirectionCheck()
        }
        let planeSequence = SKAction.sequence([planeWaitAction, planeDirectionCheckAction])
        let planeSequenceForever = SKAction.repeatForever(planeSequence)
        self.run(planeSequenceForever)
    }
    
    private func preloadTextureArray() {
        
        for i in 0...2 {
            self.preloadArray(_stride: animationSpriteStrides[i]) { [unowned self] array in
                switch i {
                case 0: self.leftTextureAnimation = array
                case 1: self.rightTextureAnimation = array
                case 2: self.forwardTextureAnimation = array
                default: break
                }
            }
        }
    }
    
    private func preloadArray(_stride: (Int, Int, Int), completion: @escaping([SKTexture]) -> Void) {

        var array = [SKTexture]()

        for i in stride(from: _stride.0, through: _stride.1, by: _stride.2) {
            let number = String(format: "%02d", i)
            let texture = SKTexture(imageNamed: "airplane_3ver2_\(number)")
            array.append(texture)
        }

        SKTexture.preload(array) {
            completion(array)
        }
    }
    
    fileprivate func movementDirectionCheck() {
        
        if xAcceleration > 0.01, moveDirection != .right, stillTurning == false {
            stillTurning = true
            moveDirection = .right
            turnPlane(direction: .right)
        } else if xAcceleration < -0.01, moveDirection != .left, stillTurning == false {
            stillTurning = true
            moveDirection = .left
            turnPlane(direction: .left)
        } else if stillTurning == false {
            turnPlane(direction: .none)
        }
    }
    
    fileprivate func turnPlane(direction: TurnDirection) {
        
        var array: [SKTexture] = []
        
        if direction == .right {
            array = rightTextureAnimation
        } else if direction == .left {
            array = leftTextureAnimation
        } else {
            array = forwardTextureAnimation
        }
        
        let forwardAction = SKAction.animate(with: array, timePerFrame: 0.05, resize: true, restore: false)
        let backwardAction = SKAction.animate(with: array.reversed(), timePerFrame: 0.05, resize: true, restore: false)
        let sequenceAction = SKAction.sequence([forwardAction, backwardAction])
        self.run(sequenceAction) { [unowned self] in
            self.stillTurning = false
        }
    }
}

enum TurnDirection {
    case left
    case right
    case none
}
