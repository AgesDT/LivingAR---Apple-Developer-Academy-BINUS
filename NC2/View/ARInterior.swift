
import SwiftUI
import RealityKit
import ARKit

struct ARInterior: View {
    var body: some View {
        ARInteriorView().edgesIgnoringSafeArea(.all)
    }
}

struct ARInteriorView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)

        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        configuration.environmentTexturing = .automatic

        arView.session.run(configuration)

        guard let house3D = try? Entity.load(named: "Simple_Modern_Living_Room.usdz") else {
            fatalError("Failed to load the 3D file.")
        }

        // Create a horizontal plane anchor for the content
        let anchor = AnchorEntity(.plane(.horizontal, classification: .floor, minimumBounds: SIMD2<Float>(0.2, 0.2)))
        anchor.addChild(house3D)

        arView.scene.anchors.append(anchor)

        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}
 /*
 1. masukkin 3d object -UDAH
 2. ganti 3d object di ARInterior -UDAH
 3. bikin design miro
 4. rapihin code -DIKIT LAGI
*/


 

