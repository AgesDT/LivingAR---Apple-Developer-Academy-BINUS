
import SwiftUI
import RealityKit
import ARKit

// Observable object to hold the ARView
class ARViewContainer: ObservableObject {
    let arView = ARView(frame: .zero)

    init() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        configuration.environmentTexturing = .automatic

        arView.session.run(configuration)

        guard let house3D = try? Entity.load(named: "FullHouse.usdz") else {
            fatalError("Failed to load the 3D file.")
        }

        // Create a horizontal plane anchor for the content
        let anchor = AnchorEntity(.plane(.horizontal, classification: .floor, minimumBounds: SIMD2<Float>(0.2, 0.2)))
        anchor.addChild(house3D)

        arView.scene.anchors.append(anchor)
    }
}

struct ARExterior: View {
    @StateObject var arViewContainer = ARViewContainer()

    var body: some View {
        NavigationStack{
            ZStack(alignment: .top) {
                ARViewRepresentable(arView: arViewContainer.arView)
                    .edgesIgnoringSafeArea(.all)
                ScaleButtonView()
                    .environmentObject(arViewContainer)
            }
        }
    }
}

struct ARViewRepresentable: UIViewRepresentable {
    let arView: ARView

    func makeUIView(context: Context) -> ARView {
        arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {}
}

struct ScaleButtonView: View {
    @EnvironmentObject var arViewContainer: ARViewContainer
    let scaleFactors: [Float] = [1, 0.04, 0.01] // Scale factors for 1:1, 1:2, 1:4, 1:10
    @State private var currentScaleIndex = 0

    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                ForEach(scaleFactors.indices, id: \.self) { index in
                    Button(action: {
                        // Scale the 3D object
                        self.scaleObject(index: index)
                    }) {
                        Circle()
                            .fill(Color.blue)
                            .frame(maxWidth: 45, maxHeight: 45)
                            .overlay {
                                Text("1:\(Int(1 / self.scaleFactors[index]))")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                    }
                }
                Spacer()
            }
        }
        .padding()
    }

    func scaleObject(index: Int) {
        guard let child = self.arViewContainer.arView.scene.anchors.first?.children.first else {
            return
        }

        let currentScaleFactor = self.scaleFactors[currentScaleIndex]
        let newScaleFactor = self.scaleFactors[index]

        let currentScale = child.scale
        let newScale = SIMD3<Float>(currentScale.x * (newScaleFactor / currentScaleFactor), currentScale.y * (newScaleFactor / currentScaleFactor), currentScale.z * (newScaleFactor / currentScaleFactor))

        child.scale = newScale
        self.currentScaleIndex = index
    }
}

