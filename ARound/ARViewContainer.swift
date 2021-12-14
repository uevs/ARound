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
        let focusSquare = FocusEntity(on: arView, focus: .classic)
        ar.currentPos = focusSquare.position
        
        let sceneAnchor = try! Experience.loadEmpty()
        sceneAnchor.name = "start"
        sceneAnchor.position = ar.currentPos
        arView.scene.anchors.append(sceneAnchor)
        
        ar.view.addCoaching(ar.coachingOverlay)
        
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
