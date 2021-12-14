//
//  MainView.swift
//  ARound
//
//  Created by leonardo on 14/12/21.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var ar: ArModel
    
    var body: some View {
        
        VStack {
            Text("Tap to place the object!")
                .font(Font.system(size: 40).bold())
                .foregroundColor(.white)
                .padding()
                .hidden(ar.object != 0)
            
            Spacer()
            
            Spacer()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack() {
                    ForEach(1...5, id:\.self) { i in
                        Button {
                            ar.object = i
                            ar.place()
                            
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

