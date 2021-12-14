//
//  arViewClass.swift.swift
//  ARound
//
//  Created by leonardo on 13/12/21.
//

import Foundation
import RealityKit
import ARKit
import FocusEntity

class ArModel: ARView, ObservableObject {
    
    @Published var start: Bool = false
    @Published var object: Int = 0
    @Published var text: String = ""
    @Published var main: Bool = true
            
//    @Published var view: ARView
    @Published var coachingOverlay = ARCoachingOverlayView()

    @Published var currentPos: SIMD3<Float> = SIMD3()
//
//
//    init(view: ARView) {
//        self.view = view
//    }
    
    func reset() {
        self.scene.anchors.removeAll()
        addFocus()
    }
    
    func addFocus() {
        let focusSquare = FocusEntity(on: self, focus: .classic)
        self.currentPos = focusSquare.position
    }
    
    
    func place() {
        
//        let arView = self
        
        switch self.object {
        case 1:
            let choosenObj = try! Experience.load_1()
            choosenObj.position = self.currentPos
            self.scene.anchors.append(choosenObj)
            
        case 2:
            let choosenObj = try! Experience.load_2()
            choosenObj.position = self.currentPos
            self.scene.anchors.append(choosenObj)
            
        case 3:
            let choosenObj = try! Experience.load_3()
            choosenObj.position = self.currentPos
            self.scene.anchors.append(choosenObj)
            
        case 4:
            let choosenObj = try! Experience.load_4()
            choosenObj.position = self.currentPos
            self.scene.anchors.append(choosenObj)
            
        case 5:
            let choosenObj = try! Experience.load_5()
            choosenObj.position = self.currentPos
            self.scene.anchors.append(choosenObj)
            
        case 6:
            let choosenObj = try! Experience.loadText()
            let textEntity: Entity = choosenObj.text!.children[0].children[0]
            var textModelComponent: ModelComponent = (textEntity.components[ModelComponent.self])!
            print(self.currentPos.x)
            textModelComponent.mesh = .generateText(self.text,
                                                    extrusionDepth: 0.03,
                                                    font: .boldSystemFont(ofSize: 0.1),
                                                    containerFrame: .init(x: (Double(self.text.count) * -0.025), y: Double(self.currentPos.y), width: 0, height: 0),
                                                    alignment: .left,
                                                    lineBreakMode: .byCharWrapping)
            
            choosenObj.children[0].children[0].components.set(textModelComponent)
            choosenObj.position = self.currentPos
            self.scene.anchors.append(choosenObj)
            
        default:
            let choosenObj = try! Experience.loadEmpty()
            choosenObj.position = self.currentPos
            self.scene.anchors.append(choosenObj)
            
            
        }
        
    }
    
}


