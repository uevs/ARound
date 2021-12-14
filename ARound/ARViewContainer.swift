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

        ar.addFocus()
        ar.addCoaching(ar.coachingOverlay)

        let sceneAnchor = try! Experience.loadEmpty()
        sceneAnchor.position = ar.currentPos
        ar.scene.anchors.append(sceneAnchor)
        
        
        return ar
        
    }
    
    func updateUIView(_ arView: ARView, context: Context) {
    }
}


extension ArModel: ARCoachingOverlayViewDelegate {
    
    func addCoaching(_ coachingOverlay: ARCoachingOverlayView) {
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.session = self.session
        coachingOverlay.delegate = self
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.goal = .horizontalPlane
        self.addSubview(coachingOverlay)
    }
    

    
    public func coachingOverlayViewWillActivate(_ coachingOverlayView: ARCoachingOverlayView) {
        self.start = false
        print("Activated")
    }
    
    public func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        self.start = true
        print("Deactivated")
    }
}


