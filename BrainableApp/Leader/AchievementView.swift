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
                                    Text("\(String(format: "%.1f", player.scoreEasy))")
                                }
                                else if (levelIndex == 1) {
                                    Text("\(String(format: "%.1f", player.scoreIntermediate))")
                                    
                                }
                                else {
                                    Text("\(String(format: "%.1f", player.scoreHard))")
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
                                    Text("Win Streak: ")
                                    Spacer()
                                    Text("\(player.winStreak)")
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
                                                    Image(achievementsList[(player.achievements[i] - 1)].image)
                                                        .resizable()
                                                        .frame(width: 50, height: 50)
                                                    Spacer()
                                                    Text(achievementsList[(player.achievements[i] - 1)].mode)
                                                }
                                                Text(achievementsList[
                                                    (player.achievements[i] - 1)].achieveName)
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
        AchievementView(player: players[0], levelIndex: .constant(0))
    }
}
