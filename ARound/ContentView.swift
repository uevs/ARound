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
    
    @State var properties = (tapped: false, object: 0)
    
    
    var body: some View {
        ZStack {
            ARViewContainer(properties: $properties).edgesIgnoringSafeArea(.all)
//                .onTapGesture { properties.tapped = true }
            VStack {
                Spacer()
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack() {
                        ForEach(1...5, id:\.self) { i in
                            Button {
                                properties.object = i
                            } label: {
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width: 80, height: 80)
                                    .padding(.leading, 1)
                                    .overlay(Text("aaa"))
                            }
                        }
                    }
                }
                Button("3D Text") {
                    properties.tapped = true
                }
                .padding()
                .buttonStyle(.borderedProminent)
                
            }
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    @Binding var properties: (tapped: Bool, object: Int)
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
        
        //        let sceneAnchor = try! Experience.loadEmpty()
        //        sceneAnchor.position = currentPos
        //        arView.scene.anchors.append(sceneAnchor)
        
        return arView
        
    }
    
    func updateUIView(_ arView: ARView, context: Context) {
        if properties.tapped {
            place(arView)
            properties.tapped = false
        }
        
    }
    
    func place(_ arView: ARView) {
        
            switch properties.object {
            case 1:
                let choosenObj = try! Experience.load_1()
                choosenObj.position = currentPos
                arView.scene.anchors.append(choosenObj)
                
            case 2:
                let choosenObj = try! Experience.load_2()
                choosenObj.position = currentPos
                arView.scene.anchors.append(choosenObj)
                
            case 3:
                let choosenObj = try! Experience.load_3()
                choosenObj.position = currentPos
                arView.scene.anchors.append(choosenObj)
                
            case 4:
                let choosenObj = try! Experience.load_4()
                choosenObj.position = currentPos
                arView.scene.anchors.append(choosenObj)
                
            case 5:
                let choosenObj = try! Experience.load_5()
                choosenObj.position = currentPos
                arView.scene.anchors.append(choosenObj)
                            
            default:
                let choosenObj = try! Experience.loadEmpty()
                choosenObj.position = currentPos
                arView.scene.anchors.append(choosenObj)
                                
            
            }
        
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
