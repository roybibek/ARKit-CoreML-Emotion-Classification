//
//  ViewController.swift
//  ARKit-CoreML-Emotion-Classification
//
//  Created by Bibek Roy on 3/29/22.
//

import UIKit
import ARKit
class ViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var faceView: ARSCNView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        faceView.delegate = self
        guard ARFaceTrackingConfiguration.isSupported else {
            statusLabel.text = "AR Face Detection is not supported on this device"
            return
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        faceView.session.run(configuration)
    }
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        faceView.session.pause()
    }
}
extension ViewController: ARSCNViewDelegate
{
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode?
    {
        guard let device = faceView.device else {
            return nil
        }
    
    let faceGeometry = ARSCNFaceGeometry(device: device)
    let faceNode = SCNNode(geometry: faceGeometry)
    faceNode.geometry?.firstMaterial?.fillMode = .lines
    return faceNode
    }
}


