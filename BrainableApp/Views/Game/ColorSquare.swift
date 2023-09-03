//
//  ColorSquare.swift
//  BrainableApp
//
//  Created by Lê Ngọc Trâm on 02/09/2023.
//

import SwiftUI

struct ColorSquare: View {
    @AppStorage("playerGrid") private var playerGridData: Data = Data()
    @AppStorage("life") private var lifeData: Data = Data()
    @AppStorage("totalClicked") private var totalClickedData: Data = Data()
    @Binding var level: Int
    @Binding var choice: Int
    @State var isCorrect:Int = 0
    var xCoordinate:Int
    var yCoordinate:Int
    @Binding var reset:Bool
    @Binding var life:Int
    @Binding var totalClicked:Int
    
    @State var clicked:Bool = false
    @State var rightValue: Bool = false
    @State var valueAdded: Bool = false
    @State var levelUpgrade:Int = 1
    
    
    var borderColor:Color {
        if (clicked && !rightValue) {return .red.opacity(1)}
        return .black.opacity(0.1)
    }
    
    @Binding var answerGrid:[[Int]]
    @Binding var playerGrid:[[Int]]
    var body: some View {
        VStack{
            let checkBlue = isCorrect == 2 ? true : false
            let checkGray = isCorrect == 1 ? true : false
            if (checkBlue && !reset) {
                Color.blue
                    .frame(width:CGFloat( 65 / (level + levelUpgrade)), height: CGFloat(65 / (level + levelUpgrade)))
                    .border(borderColor)
            }
            else if (checkGray && !reset){
                Color.gray.opacity(0.3)
                    .frame(width:CGFloat( 65 / (level + levelUpgrade)), height: CGFloat(65 / (level + levelUpgrade)))
                    .border(borderColor)

            }
            else {
                Color.white
                    .frame(width:CGFloat( 65 / (level + levelUpgrade)), height: CGFloat(65 / (level + levelUpgrade)))
                    .border(borderColor)

            }
        }
        .onAppear {
            isCorrect = playerGrid[xCoordinate][yCoordinate]
        }
        .onTapGesture {
            playerGrid[xCoordinate][yCoordinate] = choice
            savePlayerGrid()
            print("This is playerGrid before: \(playerGrid)")
            playClickSound()
            if (!clicked) {
                clicked = true
                
            }
            isCorrect = choice
            if (level == 0) {
                if (answerGrid[xCoordinate][yCoordinate] != isCorrect) {
                    life -= 1
                }
                else {
                    rightValue = true
                    
                }
            }else if (level == 1) {
                if (answerGrid[xCoordinate][yCoordinate] != isCorrect) {
                    life -= 1
                }
                else {
                    rightValue = true
                    
                }
            }
            else if (level == 2) {
                if (answerGrid[xCoordinate][yCoordinate] != isCorrect) {
                    life -= 1
                }
                else {
                    rightValue = true
                    
                }
            }
            if (rightValue) {
                if (!valueAdded) {
                    totalClicked+=1
                    valueAdded = true
                }}
            saveLife()
            saveTotalClicked()
        }
        .onChange(of: reset) { _ in
           if reset {
               isCorrect = 0
               clicked = false
               rightValue = false
               valueAdded = false
           }
        }
    }
    func savePlayerGrid() {
        do {
            let encodedPlayerGrid = try JSONEncoder().encode(playerGrid)
            playerGridData = encodedPlayerGrid
        } catch {
            print("Error saving playerGrid")
        }
    }
    func saveLife() {
        do {
            let encodedLife = try JSONEncoder().encode(life)
            lifeData = encodedLife
        } catch {
            print("Error saving Life")
        }
    }
    func saveTotalClicked() {
        do {
            let encodedTotalClicked = try JSONEncoder().encode(totalClicked)
            totalClickedData = encodedTotalClicked
        } catch {
            print("Error saving totalClicked")
        }
    }
    func loadPlayerGrid() {
        do {
            let decodedPlayerGrid = try JSONDecoder().decode([[Int]].self, from: playerGridData)
            self.playerGrid = decodedPlayerGrid
        } catch {
            print("Error loading PlayerGrid")
        }
    }
}

