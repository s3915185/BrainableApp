//
//  Game1View.swift
//  BrainableApp
//
//  Created by Vu Tran Hoang on 19/08/2023.
//

import Foundation
import SwiftUI

struct Game1View: View {
    @Binding var level:Int
    var body: some View {
        HStack {
            Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                GridRow {
                    Text("")
                    ForEach(0..<((level + 2) * 5)) { _ in
                        VStack {
                            Spacer()
                            Text("2\n5\n2\n5\n2\n5\n5\n2\n5\n2")
                                .padding(.bottom, 4)
                        }
                        .font(.system(size: 12, weight: .regular))
                        .frame(width:CGFloat( 50 / (level + 2)), height: 200)
                    }
                }
                ForEach(0..<((level + 2) * 5)) { _ in
                    GridRow {
                        Text("2 5 2 5 2 5 2 5 2 5 ")
                            .font(.system(size: 12, weight: .regular))
                            .frame(height: CGFloat(50 / (level + 2)))
                            

                        ForEach(0..<((level + 2) * 5)) { _ in
                            ColorSquare(color: Int.random(in: 1...2) == 2 ? .blue : .gray.opacity(0.2), level: $level)
                        }
                    }
                }
              }
            .border(.black, width: 0.3)
//            .padding(.trailing, 16)
        }
    
    }
}

struct Game1View_Previews: PreviewProvider {
    static var previews: some View {
        Game1View(level: .constant(2))
        Game1View(level: .constant(1))
        Game1View(level: .constant(0))
    }
}

struct ColorSquare: View {
    let color: Color
    @Binding var level: Int
    var body: some View {
        color
        .frame(width:CGFloat( 65 / (level + 2)), height: CGFloat(65 / (level + 2)))
        .border(.black.opacity(0.1))
    }
}
