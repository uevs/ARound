//
//  TextView.swift
//  ARound
//
//  Created by leonardo on 14/12/21.
//

import SwiftUI

struct TextView: View {
    
    @ObservedObject var ar: ArModel
    @FocusState private var fieldIsFocused: Bool
    
    var body: some View {
        
        VStack {
            Spacer()
            
            TextField("", text: $ar.text, prompt: Text("Choose your text"))
                .opacity(fieldIsFocused ? 1 :0.5)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
                .focused($fieldIsFocused, equals: true)

            
            Button {
                ar.place()
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


