//
//  Leaderboard.swift
//  BrainableApp
//
//  Created by Lê Ngọc Trâm on 31/08/2023.
//

import SwiftUI

struct Leaderboard: View {
    @ObservedObject var players:PlayerModel
    @Environment(\.dismiss) var dismiss
    @State var levelIndex:Int = 0
    var level = ["Easy", "Intermediate", "Hard"]
    var filteredPlayers : [Player] {
        if (levelIndex == 0) {
            return players.players
                .filter{$0.scoreEasy.isLess(than: 50000)}
                .sorted(by: {$0.scoreEasy < $1.scoreEasy})

        }
        else if (levelIndex == 1) {
            return players.players
                .filter{$0.scoreIntermediate.isLess(than: 50000)}
                .sorted(by: {$0.scoreIntermediate < $1.scoreIntermediate})
        }
        else {
            return players.players
                .filter{$0.scoreHard.isLess(than: 50000)}
                .sorted(by: {$0.scoreHard < $1.scoreHard})
        }
        return players.players
    }
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack {
                    Spacer(minLength: 80)
                    if (levelIndex == 0) {
                        List {
                            ForEach(0..<filteredPlayers.count) { play in
                                Section {
                                    HStack {
                                        AchievementView(player: filteredPlayers[play], levelIndex: $levelIndex)
                                    }
                                } header: {
                                    HStack {
                                        Text("\(play + 1)")
                                            .font(.title)
                                        Spacer()
                                        if (play + 1 == 1) {
                                            Image("cup1")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                            Image("cup1")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                        }
                                        if (play + 1 == 2) {
                                            Image("cup2")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                            Image("cup2")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                        }
                                        else if (play + 1 == 3) {
                                            Image("cup3")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                            Image("cup3")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    else if (levelIndex == 1) {
                        List {
                            ForEach(0..<filteredPlayers.count) { play in
                                Section {
                                    HStack {
                                        AchievementView(player: filteredPlayers[play], levelIndex: $levelIndex)
                                    }
                                } header: {
                                    HStack {
                                        Text("\(play + 1)")
                                            .font(.title)
                                        Spacer()
                                        if (play + 1 == 1) {
                                            Image("cup1")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                            Image("cup1")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                        }
                                        if (play + 1 == 2) {
                                            Image("cup2")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                            Image("cup2")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                        }
                                        else if (play + 1 == 3) {
                                            Image("cup3")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                            Image("cup3")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    else {
                        List {
                            ForEach(0..<filteredPlayers.count) { play in
                                Section {
                                    HStack {
                                        AchievementView(player: filteredPlayers[play], levelIndex: $levelIndex)
                                    }
                                } header: {
                                    HStack {
                                        Text("\(play + 1)")
                                            .font(.title)
                                        Spacer()
                                        if (play + 1 == 1) {
                                            Image("cup1")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                            Image("cup1")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                        }
                                        if (play + 1 == 2) {
                                            Image("cup2")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                            Image("cup2")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                        }
                                        else if (play + 1 == 3) {
                                            Image("cup3")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                            Image("cup3")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                        }
                                    }
                                }
                            }
                        }

                    }
                }
                .overlay {
                    VStack {
                        HStack {
                            List {
                                Section {
                                    Picker(selection: $levelIndex, label:
                                            Text("Level")) {
                                        ForEach(0 ..< level.count) {
                                            Text(self.level[$0]).tag($0)
                                        }
                                    }
                                }
                            }
                        }.frame(height: 90)
                        Spacer()
                    }
                    .overlay {
                        VStack {
                            HStack {
                                Button(action: {
                                    dismiss()
                                }, label: {
                                    Image(systemName: "arrowshape.backward.fill")
                                })
                                .padding(.leading)
                                Spacer()
                            }
                            Spacer()
                        }
                    }
                }
            }
            .onAppear {
                playClickSound()
            }
        }.navigationBarBackButtonHidden(true)
    }
    func searchForAchievements(id: Int) -> Achievement {
        var object:Achievement = Achievement(id: 100, achieveName: "noname", timeCount: 50000, mode: "nomode", image: "noimage")
        achievementsList.forEach{ achieve in
            if (achieve.id == id) {
                object = achieve
            }
        }
        return object
    }
}

struct LeaderboardCard: View {
    @Binding var player:Player
    @Binding var levelIndex:Int
    var body: some View {
        ZStack {
            HStack {
                Text(player.name)
                
                if (levelIndex == 0) {
                    Text("\(String(format: "%.1f", player.scoreEasy))")
                }
                else if (levelIndex == 1) {
                    Text("\(String(format: "%.1f", player.scoreIntermediate))")
                }
                else {
                    Text("\(String(format: "%.1f", player.scoreHard))")
                }
            }
        }
    }
}
struct Leaderboard_Previews: PreviewProvider {
    static var previews: some View {
        Leaderboard(players: PlayerModel())
    }
}