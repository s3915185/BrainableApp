//
//  GameView.swift
//  BrainableApp
//
//  Created by Vu Tran Hoang on 19/08/2023.
//

import Foundation
import SwiftUI

struct GameView: View {
    @ObservedObject var players:PlayerModel
    @Binding var level:Int
    @Binding var playerLoggin:Player

    @State var storage = [[Int]]()
    @State var colorChoice:Bool = true
    @State var choice:Int = 2
    @State var life:Int = 5
    
    @State var reset:Bool = false
    @State var totalClicked:Int  = 0
    
    @State var showLoseTab:Bool = false
    @State var showWinTab:Bool = false
    @State var levelUpgrade:Int = 1
    
    @State var gameTime: Double = 0
    @State var minute:Int = 0
    @State var second:Double = 0
    @State var timer: Timer?
    @State var isTimerRunning = false
    
    @State var maxTime: Double = 2000
    @Environment(\.dismiss) var dismiss
    @State var showInstructions:Bool = false


    @StateObject var gm:GameMode = GameMode()
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    HStack {
                        Button(action: {
                            dismiss()
                            playMainbackgroundSound()
                        }, label: {
                            Text("Save and Exit")
                        })
                        Spacer()
                        Button(action: {
                            showInstructions.toggle()
                        }, label: {
                            Text("Instructions")
                        })
                        .padding(.trailing)
                        .sheet(isPresented: $showInstructions) {
                            HowToPlayView()
                        }
                    }.padding(.leading)
                }
                Spacer()
                VStack {
                    HStack {
                        
                        Spacer()
                        
                        HStack (spacing: 8) {
                            ForEach(1..<life+1) { i in
                                Image(systemName: life >= i ? "heart.fill" : "heart")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.red)
                            }
                        }
                        .frame(width: CGFloat(40*life) + 20)
                        .onChange(of: life) { _ in
                            life == 0 ? showLoseTab = true : nil
                            life == 0 ? stopPlayerTimer() : nil
                        }
                        .onChange(of: showLoseTab) { _ in
                            if (!showLoseTab && life == 0) {
                                resetGame()
                                resetPlayerTimer()
                                startPlayerTimer()
                            }
                        }
                        .onChange(of: totalClicked) { _ in
                            if (totalClicked == ((level + levelUpgrade) * 5) * ((level + levelUpgrade) * 5)) {
                                showWinTab = true
                                stopPlayerTimer()
                            }
                        }
                        .onChange(of: reset, perform: { _ in
                            if reset {
                                resetPlayerTimer()
                                startPlayerTimer()
                            }
                        })
                        
                        
                        Spacer()
                        
                        
                        
                    }
                    HStack {
                        Text("Time: ")
                            .font(.system(size: 16, weight: .regular, design: .monospaced))
                            .frame(width: 60)
                        Text("\(minute)  minutes")
                            .font(.system(size: 16, weight: .regular, design: .monospaced))
                            .frame(width: 100)
                        Text("\(String(format: "%.0f", gameTime.truncatingRemainder(dividingBy: 60) )) seconds")
                            .font(.system(size: 16, weight: .regular, design: .monospaced))
                            .frame(width: 100)
                            .onAppear{
                                startPlayerTimer()
                            }
                    }
                    .onChange(of: second, perform: { _ in
                        if (second.truncatingRemainder(dividingBy: 60) == 0) {
                            minute += 1
                        }
                    })
                    .frame(width: 300)
                    HStack {
                        Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                            GridRow {
                                Text("")
                                ForEach(0..<((level + levelUpgrade) * 5)) { u in
                                    VStack {
                                        Spacer()
                                        if (level == 0) {
                                            Text(gm.Easy.x_dimensions[u])
                                                .padding(.bottom, 4)
                                        }
                                        else if (level == 1) {
                                            Text(gm.Intermediate.x_dimensions[u])
                                                .padding(.bottom, 4)
                                        }
                                        else {
                                            Text(gm.Hard.x_dimensions[u])
                                                .padding(.bottom, 4)
                                        }
                                    }
                                    .font(.system(size: 12, weight: .regular))
                                    .frame(width:CGFloat( 50 / (level + levelUpgrade)), height: 200)
                                }
                            }
                            
                            ForEach(0..<((level + levelUpgrade) * 5)) { a in
                                GridRow {
                                    if (level == 0) {
                                        HStack {
                                            Text(gm.Easy.y_dimensions[a])
                                                .font(.system(size: 12, weight: .regular))
                                                .frame(height: CGFloat(50 / (level + levelUpgrade)))
                                        }
                                        
                                        
                                        ForEach(0..<((level + levelUpgrade) * 5)) { b in
                                            if (level == 0) {
                                                let c = gm.Easy[a, b]
                                                let d = (c == 2) ? true : false
                                                if (d) {
                                                    ColorSquare(level: $level, choice: $choice, xCoordinate: a, yCoordinate: b, reset: $reset, life: $life, totalClicked: $totalClicked, gm: gm)
                                                }
                                                
                                                else {
                                                    ColorSquare(level: $level, choice: $choice, xCoordinate: a, yCoordinate: b, reset: $reset, life: $life, totalClicked: $totalClicked, gm: gm)
                                                }
                                            }
                                            else if (level == 1) {
                                                let c = gm.Intermediate[a, b]
                                                let d = (c == 2) ? true : false
                                                if (d) {
                                                    ColorSquare(level: $level, choice: $choice, xCoordinate: a, yCoordinate: b, reset: $reset, life: $life, totalClicked: $totalClicked, gm: gm)
                                                }
                                                
                                                else {
                                                    ColorSquare(level: $level, choice: $choice, xCoordinate: a, yCoordinate: b, reset: $reset, life: $life, totalClicked: $totalClicked, gm: gm)
                                                }
                                            }
                                            else {
                                                let c = gm.Hard[a, b]
                                                let d = (c == 2) ? true : false
                                                if (d) {
                                                    ColorSquare(level: $level, choice: $choice, xCoordinate: a, yCoordinate: b, reset: $reset, life: $life, totalClicked: $totalClicked, gm: gm)
                                                }
                                                
                                                else {
                                                    ColorSquare(level: $level, choice: $choice, xCoordinate: a, yCoordinate: b, reset: $reset, life: $life, totalClicked: $totalClicked, gm: gm)
                                                }
                                            }
                                        }
                                    }
                                    else if (level == 1) {
                                        Text(gm.Intermediate.y_dimensions[a])
                                            .font(.system(size: 12, weight: .regular))
                                            .frame(height: CGFloat(50 / (level + 2)))
                                        
                                        
                                        ForEach(0..<((level + levelUpgrade) * 5)) { b in
                                            if (level == 0) {
                                                let c = gm.Easy[a, b]
                                                let d = (c == 2) ? true : false
                                                if (d) {
                                                    ColorSquare(level: $level, choice: $choice, xCoordinate: a, yCoordinate: b, reset: $reset, life: $life, totalClicked: $totalClicked, gm: gm)
                                                }
                                                
                                                else {
                                                    ColorSquare(level: $level, choice: $choice, xCoordinate: a, yCoordinate: b, reset: $reset, life: $life, totalClicked: $totalClicked, gm: gm)
                                                }
                                            }
                                            else if (level == 1) {
                                                let c = gm.Intermediate[a, b]
                                                let d = (c == 2) ? true : false
                                                if (d) {
                                                    ColorSquare(level: $level, choice: $choice, xCoordinate: a, yCoordinate: b, reset: $reset, life: $life, totalClicked: $totalClicked, gm: gm)
                                                }
                                                
                                                else {
                                                    ColorSquare(level: $level, choice: $choice, xCoordinate: a, yCoordinate: b, reset: $reset, life: $life, totalClicked: $totalClicked, gm: gm)
                                                }
                                            }
                                            else {
                                                let c = gm.Hard[a, b]
                                                let d = (c == 2) ? true : false
                                                if (d) {
                                                    ColorSquare(level: $level, choice: $choice, xCoordinate: a, yCoordinate: b, reset: $reset, life: $life, totalClicked: $totalClicked, gm: gm)
                                                }
                                                
                                                else {
                                                    ColorSquare(level: $level, choice: $choice, xCoordinate: a, yCoordinate: b, reset: $reset, life: $life, totalClicked: $totalClicked, gm: gm)
                                                }
                                            }
                                        }
                                    }
                                    else {
                                        Text(gm.Hard.y_dimensions[a])
                                            .font(.system(size: 12, weight: .regular))
                                            .frame(height: CGFloat(50 / (level + 2)))
                                        
                                        
                                        ForEach(0..<((level + levelUpgrade) * 5)) { b in
                                            if (level == 0) {
                                                let c = gm.Easy[a, b]
                                                let d = (c == 2) ? true : false
                                                if (d) {
                                                    ColorSquare(level: $level, choice: $choice, xCoordinate: a, yCoordinate: b, reset: $reset, life: $life, totalClicked: $totalClicked, gm: gm)
                                                }
                                                
                                                else {
                                                    ColorSquare(level: $level, choice: $choice, xCoordinate: a, yCoordinate: b, reset: $reset, life: $life, totalClicked: $totalClicked, gm: gm)
                                                }
                                            }
                                            else if (level == 1) {
                                                let c = gm.Intermediate[a, b]
                                                let d = (c == 2) ? true : false
                                                if (d) {
                                                    ColorSquare(level: $level, choice: $choice, xCoordinate: a, yCoordinate: b, reset: $reset, life: $life, totalClicked: $totalClicked, gm: gm)
                                                }
                                                
                                                else {
                                                    ColorSquare(level: $level, choice: $choice, xCoordinate: a, yCoordinate: b, reset: $reset, life: $life, totalClicked: $totalClicked, gm: gm)
                                                }
                                            }
                                            else {
                                                let c = gm.Hard[a, b]
                                                let d = (c == 2) ? true : false
                                                if (d) {
                                                    ColorSquare(level: $level, choice: $choice, xCoordinate: a, yCoordinate: b, reset: $reset, life: $life, totalClicked: $totalClicked, gm: gm)
                                                }
                                                
                                                else {
                                                    ColorSquare(level: $level, choice: $choice, xCoordinate: a, yCoordinate: b, reset: $reset, life: $life, totalClicked: $totalClicked, gm: gm)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    HStack {
                        VStack{
                            Color.blue
                                .frame(width:CGFloat( 65), height: CGFloat(65))
                                .border(choice == 2 ? .red.opacity(1) : .black.opacity(0.1), width: 1.5)
                        }
                        .onTapGesture {
                            playClickSound()
                            choice = 2
                        }
                        VStack {
                            Color.gray.opacity(0.3)
                                .frame(width:CGFloat( 65), height: CGFloat(65))
                                .border(choice == 1 ? .red.opacity(1) : .black.opacity(0.1), width: 1.5)
                        }
                        .onTapGesture {
                            playClickSound()
                            choice = 1
                        }
                    }
                }
            }
            if (showLoseTab) {
                ZStack {
                    Spacer()
                        .frame(width: 1000, height: 1000)
                        .background(Color.gray.opacity(0.4))
                    LoseTab(players: players, playerLoggin: $playerLoggin, showLoseTab: $showLoseTab, level: level, time: gameTime)
                }
            }
            if (showWinTab) {
                ZStack {
                    Spacer()
                        .frame(width: 1000, height: 1000)
                        .background(Color.gray.opacity(0.4))
                    WinTab(players: players, showWinTab: $showWinTab, storage: $storage, colorChoice: $colorChoice, choice: $choice, life: $life, gm: gm, reset: $reset, totalClicked: $totalClicked, playerLoggin: $playerLoggin, level: level, time: gameTime)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            playClickSound()
            playBackgroundSound()
        }
    }
    
    func resetGame() {
        storage = [[Int]]()
        colorChoice = true
        choice = 2
        life = 5
        gm.reset()
        reset = true
        totalClicked = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            reset = false
        }
    }
    
    func startPlayerTimer() {
        if timer == nil {
            isTimerRunning = true
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ _ in
                if gameTime >= maxTime {
                    stopPlayerTimer()
                } else {
                    gameTime += 1
                    second += 1
                }
            }
        }
    }
    
    func resetPlayerTimer() {
        timer?.invalidate()
        timer = nil
        isTimerRunning = false
        gameTime = 0
        second = 0
        minute = 0
    }
    
    func stopPlayerTimer() {
        timer?.invalidate()
        timer = nil
        isTimerRunning = false
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(players: PlayerModel(), level: .constant(2), playerLoggin: .constant(testPlayer))
        GameView(players: PlayerModel(), level: .constant(1), playerLoggin: .constant(testPlayer))
        GameView(players: PlayerModel(), level: .constant(0), playerLoggin: .constant(testPlayer))
    }
}
