//
//  ARViewContainer.swift
//  ARound
//
//  Created by leonardo on 14/12/21.
//

import SwiftUI
import RealityKit
import ARKit
import FocusEntity

struct ARViewContainer: UIViewRepresentable {
    @ObservedObject var ar: ArModel
    
    func makeUIView(context: Context) -> ARView {

        ar.addCoaching(ar.coachingOverlay)

        let sceneAnchor = try! Experience.loadEmpty()
        ar.scene.anchors.append(sceneAnchor)
        
        return ar
    }
    
    func updateUIView(_ arView: ARView, context: Context) {
    }
}





