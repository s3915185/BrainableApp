//
//  WinTab.swift
//  BrainableApp
//
//  Created by Lê Ngọc Trâm on 02/09/2023.
//

import SwiftUI

struct WinTab: View {
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
    var level:Int
    var time:Double
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Spacer()
            Text("You've won the them")
                .font(.title).bold()
                .foregroundColor(.black)
            Text("Play again?")
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
                    choice = 2
                    life = 5
                    gm.reset()
                    reset = true
                    totalClicked = 0
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
              updatePlayerInfo(players: players, player: playerLoggin, level: level, time: time, isWin: true)
              for i in 0..<players.players.count {
                  if (players.players[i].id == playerLoggin.id) {
                      playerLoggin = players.players[i]
                  }
              }
              playWinnerSound()
          }
    }
}

