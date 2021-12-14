//
//  ContentView.swift
//  ARound
//
//  Created by leonardo on 10/12/21.
//

import SwiftUI
import RealityKit

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

