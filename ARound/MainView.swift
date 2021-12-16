//
//  MainView.swift
//  ARound
//
//  Created by leonardo on 14/12/21.
//

import SwiftUI

struct MainView: View {
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @ObservedObject var ar: ArModel
    
    var body: some View {
        
        VStack() {
            Text("Tap an object to pace it!")
                .font(Font.system(size: 40).bold())
                .foregroundColor(.white)
                .padding()
                .hidden(ar.object != 0)
            
            Spacer()
            
            Spacer()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack() {
                    ForEach(1...6, id:\.self) { i in
                        Button {
                            ar.object = i
                            ar.place()
                            
                        } label: {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.ultraThinMaterial)
                                .frame(width: sizeClass == .regular ? 171 : 120, height: sizeClass == .regular ? 171 : 120)
                                .padding(.horizontal, 1)
                                .overlay(Image("\(i)").resizable())
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            Button {
                ar.object = 7
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

