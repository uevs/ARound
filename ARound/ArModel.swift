//
//  ArModel.swift
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
    @Published var coachingOverlay = ARCoachingOverlayView()

    
    func reset() {
        self.scene.anchors.removeAll()
        object = 0
        text = ""
        main = true
        addFocus()
    }
    
    func addFocus() {
        _ = FocusEntity(on: self, style: .classic(color: .white))
    }
    
    
    func place() {
        
        switch self.object {
        case 1:
            let choosenObj = try! Experience.load_1()
            self.scene.anchors.append(choosenObj)
            
        case 2:
            let choosenObj = try! Experience.load_2()
            self.scene.anchors.append(choosenObj)
            
        case 3:
            let choosenObj = try! Experience.load_3()
            self.scene.anchors.append(choosenObj)
            
        case 4:
            let choosenObj = try! Experience.load_4()
            self.scene.anchors.append(choosenObj)
            
        case 5:
            let choosenObj = try! Experience.load_5()
            self.scene.anchors.append(choosenObj)
            
        case 6:
            let choosenObj = try! Experience.load_6()
            self.scene.anchors.append(choosenObj)
            
        case 7:
            let choosenObj = try! Experience.loadText()
            let textEntity: Entity = choosenObj.text!.children[0].children[0]
            var textModelComponent: ModelComponent = (textEntity.components[ModelComponent.self])!
            textModelComponent.mesh = .generateText(self.text,
                                                    extrusionDepth: 0.03,
                                                    font: .boldSystemFont(ofSize: 0.1),
                                                    containerFrame: .init(x: (Double(self.text.count) * -0.025), y: 0.0, width: 0, height: 0),
                                                    alignment: .left,
                                                    lineBreakMode: .byCharWrapping)
            
            choosenObj.children[0].children[0].components.set(textModelComponent)
            self.scene.anchors.append(choosenObj)
            
        default:
            let choosenObj = try! Experience.loadEmpty()
            self.scene.anchors.append(choosenObj)
        }
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
        self.addFocus()

        print("Deactivated")
    }
}
