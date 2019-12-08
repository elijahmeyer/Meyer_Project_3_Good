//
//  GameViewController.swift
//  Meyer_Project_3_Good
//
//  Created by administrator on 12/8/19.
//  Copyright © 2019 administrator. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a new scene
        let scene = SCNScene(named: "art.scnassets/MonkeyScene.scn")!
        let monkeyScene = SCNScene(named: "art.scnassets/MechaMonkey.dae")
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 1, z: 5.5)
        
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .directional
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)
        
        // retrieve the mecha monkey node
        let monkey = monkeyScene!.rootNode.childNode(withName: "Mecha_Monkey", recursively: true)!
        monkey.scale = SCNVector3(x: 0.1, y: 0.1, z: 0.1)
        monkey.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(node: monkey, options: [SCNPhysicsShape.Option.keepAsCompound : true]))
        monkey.position = SCNVector3(x: 0, y: 25, z: 0)
        scene.rootNode.addChildNode(monkey)
        
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // set the scene to the view
        scnView.scene = scene
        
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = true
        
        // configure the view
        scnView.backgroundColor = UIColor.black
        
        // add a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        scnView.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        let batarangScene = SCNScene(named: "art.scnassets/Batarang.dae")
        
        let batarang = batarangScene!.rootNode.childNode(withName: "Batarang", recursively: true)!
        
        batarang.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        batarang.physicsBody = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(node: batarang, options: [SCNPhysicsShape.Option.keepAsCompound : true]))
        batarang.position = SCNVector3(x: 0, y: 0.5, z: 0.5)
        
        scnView.scene!.rootNode.addChildNode(batarang)
        
        batarang.physicsBody?.applyForce(SCNVector3(x: 0, y: 0, z: -10), at: SCNVector3(0,0,0), asImpulse: true)
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

}
