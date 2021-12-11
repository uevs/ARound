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
    
    @State var properties = (tapped: false, object: 0, text: "text")
    @FocusState private var fieldIsFocused: Bool
    
    
    var body: some View {
        ZStack {
            ARViewContainer(properties: $properties).edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                TextField("text", text: $properties.text, prompt: Text("aaa"))
                    .focused($fieldIsFocused)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack() {
                        ForEach(1...5, id:\.self) { i in
                            Button {
                                properties.object = i
                                properties.tapped.toggle()

                            } label: {
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(width: 100, height: 100)
                                    .padding(.horizontal, 1)
                                    .overlay(Text("\(i)").foregroundColor(.white))
                            }
                        }
                    }
                    .padding()
                }
                Button {
                    properties.object = 6
                    properties.tapped.toggle()
                } label: {
                    Text("3D Text")
                        .font(.headline)
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)

                        
                }
                .padding()
                .buttonStyle(.borderedProminent)
                
 
                
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button("Done") {
                        fieldIsFocused = false
                    }
                }
            }
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    @Binding var properties: (tapped: Bool, object: Int, text: String)
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

        place(arView)
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
                
            case 6:
                let choosenObj = try! Experience.loadText()
                let textEntity: Entity = choosenObj.text!.children[0].children[0]
                var textModelComponent: ModelComponent = (textEntity.components[ModelComponent.self])!
                textModelComponent.mesh = .generateText(properties.text,
                                                        extrusionDepth: 0.03,
                                                        font: .boldSystemFont(ofSize: 0.1),
                                                        containerFrame: CGRect.zero,
                                                     alignment: .center,
                                                 lineBreakMode: .byCharWrapping)
                
                choosenObj.children[0].children[0].components.set(textModelComponent)
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
