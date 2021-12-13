//
//  arViewClass.swift.swift
//  ARound
//
//  Created by leonardo on 13/12/21.
//

import Foundation
import RealityKit

class ArModel: ObservableObject {
    @Published var tapped: Bool = false
    @Published var object: Int = 0
    @Published var text: String = ""
    @Published var main: Bool = true
    @Published var view: ARView
    
    init(view: ARView) {
        self.view = view
    }
    
    
}
