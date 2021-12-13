//
//  arViewClass.swift.swift
//  ARound
//
//  Created by leonardo on 13/12/21.
//

import Foundation
import RealityKit
import ARKit

class ArModel: ObservableObject {
    
    @Published var start: Bool = false
    @Published var object: Int = 0
    @Published var text: String = ""
    @Published var main: Bool = true
    
    @Published var view: ARView
    @Published var coachingOverlay = ARCoachingOverlayView()

    @Published var currentPos: SIMD3<Float> = SIMD3()
    
    init(view: ARView) {
        self.view = view
    }
    
    
}
