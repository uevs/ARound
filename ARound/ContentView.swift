//
//  ContentView.swift
//  ARound
//
//  Created by leonardo on 10/12/21.
//

import SwiftUI
import RealityKit
import ARKit
import FocusEntity

struct ContentView: View {
    
    @State var tapped = false
    
    var body: some View {
        ARViewContainer(tapped: $tapped).edgesIgnoringSafeArea(.all)
            .onTapGesture {
                tapped.toggle()
            }

    }
}

struct ARViewContainer: UIViewRepresentable {
    
    @Binding var tapped: Bool
    @State var currentPos: SIMD3<Float> = SIMD3()

    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        let session = arView.session
        let focusSquare = FocusEntity(on: arView, focus: .classic)
        currentPos = focusSquare.position

        
        // Overlay while scanning the scene
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.session = session
        coachingOverlay.goal = .horizontalPlane
        arView.addSubview(coachingOverlay)

        return arView
        
    }
    
    func updateUIView(_ arView: ARView, context: Context) {

        if tapped {
            
            // Load the scene from the "Experience" Reality File
            let sceneAnchor = try! Experience.loadTest()
            sceneAnchor.position = currentPos
            
            // Add the scene anchor to the scene
            arView.scene.anchors.append(sceneAnchor)
        }
        
        
    }

    
}

func addObject(_ arView: ARView) {
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
