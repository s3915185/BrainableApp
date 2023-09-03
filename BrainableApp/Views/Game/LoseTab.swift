//
//  LoseTab.swift
//  BrainableApp
//
//  Created by Lê Ngọc Trâm on 02/09/2023.
//

import SwiftUI

struct LoseTab: View {
    @ObservedObject var players:PlayerModel
    @Binding var playerLoggin:Player
    @Binding var showLoseTab:Bool
    var level:Int
    var time:Int
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Spacer()
            Text("GAME OVER")
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
                    showLoseTab = false
                    playBackgroundSound()
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
              updatePlayerInfo(players: players, player: playerLoggin, level: level, time: time, isWin: false)
              for i in 0..<players.players.count {
                  if (players.players[i].id == playerLoggin.id) {
                      playerLoggin = players.players[i]
                  }
              }
              playLoserSound()
          }
    }
}
