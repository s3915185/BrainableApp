//
//  AchievementView.swift
//  BrainableApp
//
//  Created by Lê Ngọc Trâm on 01/09/2023.
//

import SwiftUI

struct AchievementView: View {
    var player:Player
    @Binding var levelIndex:Int
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    HStack {
                        VStack {
                            HStack {
                                Text("\(player.name)")
                                    .font(.system(size: 22).bold())
                                Spacer()
                            }
                            HStack {
                                Text("Time: ")
                                if (levelIndex == 0) {
                                    Text("\(player.scoreEasy / 60) min")
                                    Text("\(player.scoreEasy % 60) s")
                                }
                                else if (levelIndex == 1) {
                                    Text("\(player.scoreIntermediate / 60) min")
                                    Text("\(player.scoreIntermediate % 60) s")
                                    
                                }
                                else {
                                    Text("\(player.scoreHard / 60) min")
                                    Text("\(player.scoreHard % 60) s")
                                }
                                Spacer()
                            }
                        }
                        Divider()
                        HStack {
                            VStack{
                                HStack {
                                    Text("Winrates: ")
                                        .font(.system(size: 18))
                                    Spacer()
                                    Text("\(player.winners * 100 / player.gameTotal)%")
                                        .font(.system(size: 22).bold())
                                        .foregroundColor(.red)
                                }
                                HStack{
                                    Text("Game Total: ")
                                    Spacer()
                                    Text("\(player.gameTotal)")
                                }
                                HStack{
                                    Text("Max Win Streak: ")
                                    Spacer()
                                    Text("\(player.maxWinStreak)")
                                }
                            }
                        }
                        Spacer()
                    }
                }
                Spacer()
                Divider()
                VStack {
                    HStack {
                        Text("Achievements")
                        Spacer()
                    }
                    ScrollView(.horizontal) {
                        HStack(spacing: 0) {
                            ForEach(0..<player.achievements.count, id: \.self) { i in
                                    VStack{
                                        HStack {
                                            Spacer()
                                            VStack {
                                                HStack {
                                                    Image("\(player.achievements[i].image)")
                                                        .resizable()
                                                        .frame(width: 50, height: 50)
                                                    Spacer()
                                                    Text("\(player.achievements[i].mode)")
                                                }
                                                Text("\(player.achievements[i].achieveName)")
                                            }
                                            Divider()
                                        }
                                    }
                            }
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}

struct AchievementView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementView(player: testPlayer, levelIndex: .constant(0))
    }
}
