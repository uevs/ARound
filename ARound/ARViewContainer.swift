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

        let arView = ar.view
        ar.addFocus()
        ar.view.addCoaching(ar.coachingOverlay)

        let sceneAnchor = try! Experience.loadEmpty()
        sceneAnchor.position = ar.currentPos
        arView.scene.anchors.append(sceneAnchor)
        
        
        return arView
        
    }
    
    func updateUIView(_ arView: ARView, context: Context) {
    }
}


extension ARView: ARCoachingOverlayViewDelegate {
    
    func addCoaching(_ coachingOverlay: ARCoachingOverlayView) {
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.session = self.session
        coachingOverlay.delegate = self
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.goal = .horizontalPlane
        self.addSubview(coachingOverlay)
    }
    

    
    public func coachingOverlayViewWillActivate(_ coachingOverlayView: ARCoachingOverlayView) {
//        start = false
        print("Activated")
    }
    
    public func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
//        start = true
        print("Deactivated")
    }
}
