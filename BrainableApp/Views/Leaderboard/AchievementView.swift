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
                                VStack {
                                    HStack {
                                        Text("time")
                                        Spacer()
                                    }
                                    if (levelIndex == 0) {
                                        HStack {
                                            Text("\(player.scoreEasy / 60) ")
                                            Text("min")
                                            Text("\(player.scoreEasy % 60) ")
                                            Text("s")
                                            Spacer()
                                        }
                                    }
                                    else if (levelIndex == 1) {
                                        HStack {
                                            Text("\(player.scoreIntermediate / 60) ")
                                            Text("min")
                                            Text("\(player.scoreIntermediate % 60) ")
                                            Text("s")
                                        }
                                        
                                    }
                                    else {
                                        HStack {
                                            Text("\(player.scoreHard / 60) ")
                                            Text("min")
                                            Text("\(player.scoreHard % 60) ")
                                            Text("s")
                                        }
                                    }
                                }
                                Spacer()
                            }
                        }
                        Divider()
                        HStack {
                            VStack{
                                HStack {
                                    Text("winrates")
                                        .font(.system(size: 18))
                                    Spacer()
                                    Text("\(player.winners * 100 / player.gameTotal)%")
                                        .font(.system(size: 22).bold())
                                        .foregroundColor(.red)
                                }
                                HStack{
                                    Text("game-total")
                                    Spacer()
                                    Text("\(player.gameTotal)")
                                }
                                HStack{
                                    Text("max-win-streak")
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
                        Text("achievements")
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
                                                    Text(LocalizedStringKey(player.achievements[i].mode))
                                                }
                                                Text(LocalizedStringKey(player.achievements[i].achieveName))
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
