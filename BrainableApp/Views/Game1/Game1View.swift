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
    @State var storage = [[Int]]()
    @State var colorChoice:Bool = true
    
    var Easy = NonogramEasy()
    var Intermediate = NonogramIntermediate()
    var Hard = NonogramHard()
    
    var body: some View {
        VStack {
            HStack {
                Text("Got Here")
            }
            HStack {
                Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                    GridRow {
                        Text("")
                        ForEach(0..<((level + 2) * 5)) { u in
                            VStack {
                                Spacer()
                                if (level == 0) {
                                    Text(Easy.x_dimensions[u])
                                        .padding(.bottom, 4)
                                }
                                else if (level == 1) {
                                    Text(Intermediate.x_dimensions[u])
                                        .padding(.bottom, 4)
                                }
                                else {
                                    Text(Hard.x_dimensions[u])
                                        .padding(.bottom, 4)
                                }
                            }
                            .font(.system(size: 12, weight: .regular))
                            .frame(width:CGFloat( 50 / (level + 2)), height: 200)
                        }
                    }
                    
                    ForEach(0..<((level + 2) * 5)) { a in
                        GridRow {
                            if (level == 0) {
                                HStack {
                                    Text(Easy.y_dimensions[a])
                                        .font(.system(size: 12, weight: .regular))
                                        .frame(height: CGFloat(50 / (level + 2)))
                                }
                                
                                
                                ForEach(0..<((level + 2) * 5)) { b in
                                    if (level == 0) {
                                        let c = Easy[a, b]
                                        let d = (c == 2) ? true : false
                                        if (d) {
                                            ColorSquare(level: $level)
                                        }
                                        
                                        else {
                                            ColorSquare(level: $level)
                                        }
                                    }
                                    else if (level == 1) {
                                        let c = Intermediate[a, b]
                                        let d = (c == 2) ? true : false
                                        if (d) {
                                            ColorSquare(level: $level)
                                        }
                                        
                                        else {
                                            ColorSquare(level: $level)
                                        }
                                    }
                                    else {
                                        let c = Hard[a, b]
                                        let d = (c == 2) ? true : false
                                        if (d) {
                                            ColorSquare(level: $level)
                                        }
                                        
                                        else {
                                            ColorSquare(level: $level)
                                        }
                                    }
                                }
                            }
                            else if (level == 1) {
                                Text(Intermediate.y_dimensions[a])
                                    .font(.system(size: 12, weight: .regular))
                                    .frame(height: CGFloat(50 / (level + 2)))
                                
                                
                                ForEach(0..<((level + 2) * 5)) { b in
                                    if (level == 0) {
                                        let c = Easy[a, b]
                                        let d = (c == 2) ? true : false
                                        if (d) {
                                            ColorSquare(level: $level)
                                        }
                                        
                                        else {
                                            ColorSquare(level: $level)
                                        }
                                    }
                                    else if (level == 1) {
                                        let c = Intermediate[a, b]
                                        let d = (c == 2) ? true : false
                                        if (d) {
                                            ColorSquare(level: $level)
                                        }
                                        
                                        else {
                                            ColorSquare(level: $level)
                                        }
                                    }
                                    else {
                                        let c = Hard[a, b]
                                        let d = (c == 2) ? true : false
                                        if (d) {
                                            ColorSquare(level: $level)
                                        }
                                        
                                        else {
                                            ColorSquare(level: $level)
                                        }
                                    }
                                }
                            }
                            else {
                                Text(Hard.y_dimensions[a])
                                    .font(.system(size: 12, weight: .regular))
                                    .frame(height: CGFloat(50 / (level + 2)))
                                
                                
                                ForEach(0..<((level + 2) * 5)) { b in
                                    if (level == 0) {
                                        let c = Easy[a, b]
                                        let d = (c == 2) ? true : false
                                        if (d) {
                                            ColorSquare(level: $level)
                                        }
                                        
                                        else {
                                            ColorSquare(level: $level)
                                        }
                                    }
                                    else if (level == 1) {
                                        let c = Intermediate[a, b]
                                        let d = (c == 2) ? true : false
                                        if (d) {
                                            ColorSquare(level: $level)
                                        }
                                        
                                        else {
                                            ColorSquare(level: $level)
                                        }
                                    }
                                    else {
                                        let c = Hard[a, b]
                                        let d = (c == 2) ? true : false
                                        if (d) {
                                            ColorSquare(level: $level)
                                        }
                                        
                                        else {
                                            ColorSquare(level: $level)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
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
    @Binding var level: Int
    @State var isCorrect:Int = 0
    var body: some View {
        VStack{
            let checkBlue = isCorrect == 1 ? true : false
            let checkGray = isCorrect == 2 ? true : false
            if (checkBlue) {
                Color.blue
                    .frame(width:CGFloat( 65 / (level + 2)), height: CGFloat(65 / (level + 2)))
                    .border(.black.opacity(0.1))
            }
            else if (checkGray){
                Color.gray.opacity(0.3)
                    .frame(width:CGFloat( 65 / (level + 2)), height: CGFloat(65 / (level + 2)))
                    .border(.black.opacity(0.1))
            }
            else {
                Color.white
                    .frame(width:CGFloat( 65 / (level + 2)), height: CGFloat(65 / (level + 2)))
                    .border(.black.opacity(0.1))
            }
        }
        .onTapGesture {
            if (isCorrect == 2) {
                isCorrect = 0
            }
            else {
                isCorrect += 1
            }
        }
    }
}
struct ColorSquareController: View {
    let color: Color
    @Binding var level: Int
    var body: some View {
        color
        .frame(width:CGFloat(65), height: CGFloat(65))
        .border(.black.opacity(0.1))
        .onTapGesture {
            print("Tapped Color Controller")
        }
    }
}

class NonogramEasy {
    @State var level:Int = 0
    var storage = [[Int]]()
    var y_dimensions = [String]()
    var x_dimensions = [String]()
    init() {
        for _ in 0..<((level + 2) * 5) {
            var subArray = [Int]()
            var y_dimension = 0
            var y_string = ""
            var subY = [Int]()
            for _ in 0..<((level + 2) * 5) {
                if (Int.random(in: 1...3) == 1) {
                    if (y_dimension != 0) {
                        subY.append(y_dimension)
                        y_dimension = 0
                    }
                    subArray.append(1)
                }
                else {
                    y_dimension += 1
                    subArray.append(2)
                }
            }
            if (y_dimension != 0) {
                subY.append(y_dimension)
                y_dimension = 0
            }
            
            for z in 0..<subY.count {
                y_string.insert(contentsOf: "\(subY[z]) ", at: y_string.endIndex)
            }
            y_dimensions.append(y_string)
            storage.append(subArray)
        }
        
        for a in 0..<((level + 2) * 5) {
            var x_dimension = 0
            var x_string = ""
            var subX = [Int]()
            for b in 0..<((level + 2) * 5) {
                var value = storage[b][a]
                if (value == 1) {
                    if (x_dimension != 0) {
                        subX.append(x_dimension)
                        x_dimension = 0
                    }
                }
                else {
                    x_dimension += 1
                }
            }
            if (x_dimension != 0) {
                subX.append(x_dimension)
                x_dimension = 0
            }
            for e in 0..<subX.count {
                x_string.insert(contentsOf: "\(subX[e])\n", at: x_string.endIndex)
            }
            x_dimensions.append(x_string)
        }
    }
    subscript(row: Int, column: Int) -> Int {
        get {
            // This could validate arguments.
            return storage[row][column]
        }
        set {
            // This could also validate.
            storage[row][column] = newValue
        }
    }
}

class NonogramIntermediate {
    @State var level:Int = 1
    var storage = [[Int]]()
    var y_dimensions = [String]()
    var x_dimensions = [String]()
    init() {
        for _ in 0..<((level + 2) * 5) {
            var subArray = [Int]()
            var y_dimension = 0
            var y_string = ""
            var subY = [Int]()
            for _ in 0..<((level + 2) * 5) {
                if (Int.random(in: 1...3) == 1) {
                    if (y_dimension != 0) {
                        subY.append(y_dimension)
                        y_dimension = 0
                    }
                    subArray.append(1)
                }
                else {
                    y_dimension += 1
                    subArray.append(2)
                }
            }
            if (y_dimension != 0) {
                subY.append(y_dimension)
                y_dimension = 0
            }
            
            for z in 0..<subY.count {
                y_string.insert(contentsOf: "\(subY[z]) ", at: y_string.endIndex)
            }
            y_dimensions.append(y_string)
            storage.append(subArray)
        }
        
        for a in 0..<((level + 2) * 5) {
            var x_dimension = 0
            var x_string = ""
            var subX = [Int]()
            for b in 0..<((level + 2) * 5) {
                var value = storage[b][a]
                if (value == 1) {
                    if (x_dimension != 0) {
                        subX.append(x_dimension)
                        x_dimension = 0
                    }
                }
                else {
                    x_dimension += 1
                }
            }
            if (x_dimension != 0) {
                subX.append(x_dimension)
                x_dimension = 0
            }
            for e in 0..<subX.count {
                x_string.insert(contentsOf: "\(subX[e])\n", at: x_string.endIndex)
            }
            x_dimensions.append(x_string)
        }
    }
    subscript(row: Int, column: Int) -> Int {
        get {
            // This could validate arguments.
            return storage[row][column]
        }
        set {
            // This could also validate.
            storage[row][column] = newValue
        }
    }
}

class NonogramHard {
    @State var level:Int = 2
    var storage = [[Int]]()
    var y_dimensions = [String]()
    var x_dimensions = [String]()
    init() {
        for _ in 0..<((level + 2) * 5) {
            var subArray = [Int]()
            var y_dimension = 0
            var y_string = ""
            var subY = [Int]()
            for _ in 0..<((level + 2) * 5) {
                if (Int.random(in: 1...3) == 1) {
                    if (y_dimension != 0) {
                        subY.append(y_dimension)
                        y_dimension = 0
                    }
                    subArray.append(1)
                }
                else {
                    y_dimension += 1
                    subArray.append(2)
                }
            }
            if (y_dimension != 0) {
                subY.append(y_dimension)
                y_dimension = 0
            }
            
            for z in 0..<subY.count {
                y_string.insert(contentsOf: "\(subY[z]) ", at: y_string.endIndex)
            }
            y_dimensions.append(y_string)
            storage.append(subArray)
        }
        
        for a in 0..<((level + 2) * 5) {
            var x_dimension = 0
            var x_string = ""
            var subX = [Int]()
            for b in 0..<((level + 2) * 5) {
                var value = storage[b][a]
                if (value == 1) {
                    if (x_dimension != 0) {
                        subX.append(x_dimension)
                        x_dimension = 0
                    }
                }
                else {
                    x_dimension += 1
                }
            }
            if (x_dimension != 0) {
                subX.append(x_dimension)
                x_dimension = 0
            }
            for e in 0..<subX.count {
                x_string.insert(contentsOf: "\(subX[e])\n", at: x_string.endIndex)
            }
            x_dimensions.append(x_string)
        }
    }
    subscript(row: Int, column: Int) -> Int {
        get {
            // This could validate arguments.
            return storage[row][column]
        }
        set {
            // This could also validate.
            storage[row][column] = newValue
        }
    }
}
