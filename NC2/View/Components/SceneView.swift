import SwiftUI
import SceneKit

struct SceneView: UIViewRepresentable {
    func makeUIView(context: Context) -> SCNView {
        let scnView = SCNView()
        scnView.scene = createScene()
        scnView.allowsCameraControl = true
        scnView.backgroundColor = UIColor.clear
        return scnView
    }

    func updateUIView(_ uiView: SCNView, context: Context) {
        // Update the view if needed
    }

    func createScene() -> SCNScene? {
        let scene = SCNScene()
        
        // Load your 3D model, e.g., a .dae, .obj, or .scn file
        guard let node = SCNScene(named: "FullHouse.scn")?.rootNode else {
            return nil
        }

        // Scale the node to 1:100
        node.scale = SCNVector3(0.02, 0.02, 0.02)

        scene.rootNode.addChildNode(node)
        
        // Add a camera
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(0, 0, 15)
        scene.rootNode.addChildNode(cameraNode)
        
        // Add a light
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .ambient
        lightNode.position = SCNVector3(0, 10, 10)
        scene.rootNode.addChildNode(lightNode)

        return scene
    }
}
