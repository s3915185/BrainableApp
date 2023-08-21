//
//  Game2View.swift
//  BrainableApp
//
//  Created by Vu Tran Hoang on 19/08/2023.
//

import Foundation
import SwiftUI

struct Game2View: View {
    @Binding var level:Int
    @State private var input = ""
    @FocusState private var keyboardFocused: Bool
    
    
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    ForEach(0..<100) {
                        a in
                        buildElement()
                    }
                }
                HStack {
                    TextField("Input result", text: $input)
                        .padding()
                        .focused($keyboardFocused)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                keyboardFocused = true
                            }
                        }
                    Button(action: {
                        print("Clicked Enter")
                    }, label: {
                        Text("Enter")
                            .padding()
                    })
                }
            }
        }
    }
    
    @ViewBuilder func buildElement() -> some View {
        Text("\(Int.random(in:1...9)) + \(Int.random(in: 1...9)) = ")
    }
}

struct Game2View_Previews: PreviewProvider {
    static var previews: some View {
        Game2View(level: .constant(2))
        Game2View(level: .constant(1))
        Game2View(level: .constant(0))
    }
}
