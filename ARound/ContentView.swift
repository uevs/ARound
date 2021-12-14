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
            
            if ar.start {

                if ar.main {
                    MainView(ar: ar)
                    
                } else {
                    TextView(ar: ar)
                }
            }
        }
    }
}

// MARK: - Buttons
struct ButtonsView: View {
    
    @ObservedObject var ar: ArModel
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                if ar.main == false {
                    Button {
                        ar.main = true
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.primary)
                            .frame(width: 20, height: 20)
                            .padding()
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                }
                
                
                Spacer()
                
                Button {
                    //
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                        .foregroundColor(.primary)
                        .frame(width: 20, height: 20)
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                }

            }
            .padding(.horizontal)
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
                                .fill(.ultraThinMaterial)
                                .frame(width: 120, height: 120)
                                .padding(.horizontal, 1)
                                .overlay(Text("\(i)").foregroundColor(.primary))
                        }
                    }
                }
                .padding(.horizontal)
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
            .buttonStyle(MaterialButton())
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
                    .foregroundColor(ar.text == "" ? .secondary : .primary)
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                
            }
            .disabled(ar.text == "")
            .buttonStyle(MaterialButton())
        }
    }
}

// MARK: - ArView

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


// MARK: - Place

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
        print(ar.currentPos.x)
        textModelComponent.mesh = .generateText(ar.text,
                                                extrusionDepth: 0.03,
                                                font: .boldSystemFont(ofSize: 0.1),
                                                containerFrame: .init(x: (Double(ar.text.count) * -0.025), y: Double(ar.currentPos.y), width: 0, height: 0),
                                                alignment: .left,
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

struct MaterialButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.primary)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding()
    }
}
