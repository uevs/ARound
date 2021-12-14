//
//  ButtonsView.swift
//  ARound
//
//  Created by leonardo on 14/12/21.
//

import SwiftUI

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
                    ar.reset()
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

struct MaterialButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.primary)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding()
    }
}
