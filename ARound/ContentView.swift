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

    @StateObject var ar = ArModel(view: ARView(frame: .zero))
    
    var body: some View {
        
        ZStack {
            ARViewContainer(ar: ar).edgesIgnoringSafeArea(.all)
            
            ButtonsView(ar: ar)
            
            if ar.main {
                MainView(ar: ar)
                
            } else {
                TextView(ar: ar)
            }
        }
    }
}
// MARK: - Buttons
struct ButtonsView: View {
    
    @ObservedObject var ar: ArModel
    
    var body: some View {
        VStack {
            HStack {
                if ar.main == false {
                    Button {
                        ar.main = true
                    } label: {
                        Image(systemName: "arrowshape.turn.up.backward.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                }


                Spacer()
                
                Button {
                    //
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                        .resizable()
                        .frame(width: 25, height: 25)

                }
            }
            .padding()
            Spacer()
        }
    }
}

// MARK: - Main View

struct MainView: View {
    
    @ObservedObject var ar: ArModel
    
    var body: some View {
        
        VStack {
            Text("Tap to place the object!")
                .font(Font.system(size: 40).bold())
                .foregroundColor(.white)
                .padding()
            
            Spacer()
            
            Spacer()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack() {
                    ForEach(1...5, id:\.self) { i in
                        Button {
                            ar.object = i
                            place(ar)
                            
                        } label: {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: 120, height: 120)
                                .padding(.horizontal, 1)
                                .overlay(Text("\(i)").foregroundColor(.white))
                        }
                    }
                }
                .padding()
            }
            
            Button {
                ar.object = 6
                ar.main = false
                
            } label: {
                Text("3D Text")
                    .font(.headline)
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)

            }
            .padding()
            .buttonStyle(.borderedProminent)
            
        }
        
    }
}

// MARK: - Text View


struct TextView: View {
    
    @ObservedObject var ar: ArModel
    @FocusState private var fieldIsFocused: Bool
    
    var body: some View {
        
        VStack {
            Spacer()
            
            TextField("", text: $ar.text, prompt: Text("Choose your text"))
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
//                .onAppear(perform: {fieldIsFocused = true})
                .focused($fieldIsFocused, equals: true)
            
            Button {
                place(ar)
                ar.main = true
                
            } label: {
                Text("Place Text")
                    .font(.headline)
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                
            }
            .disabled(ar.text == "")
            .padding()
            .buttonStyle(.borderedProminent)
                

        
        }
    }
}

// MARK: - ArView

struct ARViewContainer: UIViewRepresentable {
    
    @ObservedObject var ar: ArModel
    
    func makeUIView(context: Context) -> ARView {
        print("ARViewContainer")
        let arView = ar.view
        let session = arView.session
        let focusSquare = FocusEntity(on: arView, focus: .classic)
        ar.currentPos = focusSquare.position
        
        
        // Overlay while scanning the scene
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.session = session
        coachingOverlay.goal = .horizontalPlane
        arView.addSubview(coachingOverlay)
        
        
        let sceneAnchor = try! Experience.loadEmpty()
        sceneAnchor.position = ar.currentPos
        arView.scene.anchors.append(sceneAnchor)
                
 
        return arView
        
    }
    
    func updateUIView(_ arView: ARView, context: Context) {
    }
}

func place(_ ar: ArModel) {
    
    let arView = ar.view
    
    switch ar.object {
    case 1:
        let choosenObj = try! Experience.load_1()
        choosenObj.position = ar.currentPos
        arView.scene.anchors.append(choosenObj)
        
    case 2:
        let choosenObj = try! Experience.load_2()
        choosenObj.position = ar.currentPos
        arView.scene.anchors.append(choosenObj)
        
    case 3:
        let choosenObj = try! Experience.load_3()
        choosenObj.position = ar.currentPos
        arView.scene.anchors.append(choosenObj)
        
    case 4:
        let choosenObj = try! Experience.load_4()
        choosenObj.position = ar.currentPos
        arView.scene.anchors.append(choosenObj)
        
    case 5:
        let choosenObj = try! Experience.load_5()
        choosenObj.position = ar.currentPos
        arView.scene.anchors.append(choosenObj)
        
    case 6:
        let choosenObj = try! Experience.loadText()
        let textEntity: Entity = choosenObj.text!.children[0].children[0]
        var textModelComponent: ModelComponent = (textEntity.components[ModelComponent.self])!
        textModelComponent.mesh = .generateText(ar.text,
                                                extrusionDepth: 0.03,
                                                font: .boldSystemFont(ofSize: 0.1),
                                                containerFrame: CGRect.zero,
                                                alignment: .center,
                                                lineBreakMode: .byCharWrapping)
        
        choosenObj.children[0].children[0].components.set(textModelComponent)
        choosenObj.position = ar.currentPos
        arView.scene.anchors.append(choosenObj)
        
    default:
        let choosenObj = try! Experience.loadEmpty()
        choosenObj.position = ar.currentPos
        arView.scene.anchors.append(choosenObj)
        
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
