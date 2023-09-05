//
//  WinTab.swift
//  BrainableApp
//
//  Created by Lê Ngọc Trâm on 02/09/2023.
//

import SwiftUI

struct WinTab: View {
    @AppStorage("hasPlayerContinue") private var hasPlayerContinueData: Data = Data()
    @AppStorage("totalClicked") private var totalClickedData: Data = Data()
    @ObservedObject var players:PlayerModel
    @Binding var showWinTab:Bool
    @Binding var storage:[[Int]]
    @Binding var colorChoice:Bool
    @Binding var choice:Int
    @Binding var life:Int
    
    @ObservedObject var gm:GameMode
    
    @Binding var reset:Bool
    @Binding var totalClicked:Int
    @Binding var playerLoggin:Player
    @Binding var hasPlayerContinue:Bool
    var level:Int
    var time:Int
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Spacer()
            Text("game-won")
                .font(.title).bold()
                .foregroundColor(.black)
            Text("play-again?")
            Spacer()
            HStack {
                Button(action: {
                    dismiss()
                    playMainbackgroundSound()
                }, label: {
                    Image(systemName: "clear.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.red)
                        
            })
                Spacer()
                Button(action: {
                    showWinTab = false
                    storage = [[Int]]()
                    colorChoice = true
                    hasPlayerContinue = true
                    saveHasPlayerContinue()
                    choice = 2
                    life = 5
                    if (level == 0) {
                        gm.easyReset()
                    }
                    else if (level == 1) {
                        gm.intermediateReset()
                    }
                    else {
                        gm.hardReset()
                    }
                    reset = true
                    totalClicked = 0
                    saveTotalClicked()
                    playBackgroundSound()

                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        reset = false
                    }
                    
                }, label: {
                    Image(systemName: "arrow.forward.square.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.green)
                        
            })
            }
        }
          .frame(width: 300, height: 200)
          .padding(20)
          .background(Color.white)
          .cornerRadius(10.0)
          .onAppear {
              totalClicked = 0
              saveTotalClicked()
              updatePlayerInfo(players: players, player: playerLoggin, level: level, time: time, isWin: true)
              for i in 0..<players.players.count {
                  if (players.players[i].id == playerLoggin.id) {
                      playerLoggin = players.players[i]
                  }
              }
              playWinnerSound()
          }
    }
    func saveHasPlayerContinue() {
        do {
            let encodedHasPlayerContinue = try JSONEncoder().encode(hasPlayerContinue)
            hasPlayerContinueData = encodedHasPlayerContinue
        } catch {
            print("Error saving HasPlayerContinue")
        }
    }
    func saveTotalClicked() {
        do {
            let encodedTotalClicked = try JSONEncoder().encode(totalClicked)
            totalClickedData = encodedTotalClicked
        } catch {
            print("Error saving TotalClicked")
        }
    }
}

