//
//  ContentView.swift
//  ARound
//
//  Created by leonardo on 10/12/21.
//

import SwiftUI
import RealityKit

struct ContentView: View {

    @StateObject var ar = ArModel()
    
    var body: some View {
        
        ZStack {
            ARViewContainer(ar: ar).edgesIgnoringSafeArea(.all)
            
            ButtonsView(ar: ar)
                .hidden(!ar.start)
            MainView(ar: ar)
                .hidden(!ar.start || !ar.main)
            TextView(ar: ar)
                .hidden(!ar.start || ar.main)
            
        }
    }
}

extension View {
    func hidden(_ isHidden: Bool) -> some View {
        opacity(isHidden ? 0 : 1).disabled(isHidden)
    }
}

