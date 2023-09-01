//
//  Leaderboard.swift
//  BrainableApp
//
//  Created by Lê Ngọc Trâm on 31/08/2023.
//

import SwiftUI

struct Leaderboard: View {
    @Binding var levelIndex:Int
    var level = ["Easy", "Intermediate", "Hard"]
    
    var filteredPlayers : [Player] {
        if (levelIndex == 0) {
            return players
                .filter{$0.scoreEasy.isLess(than: 50000)}
                .sorted(by: {$0.scoreEasy < $1.scoreEasy})

        }
        else if (levelIndex == 1) {
            return players
                .filter{$0.scoreIntermediate.isLess(than: 50000)}
                .sorted(by: {$0.scoreIntermediate < $1.scoreIntermediate})
        }
        else {
            return players
                .filter{$0.scoreHard.isLess(than: 50000)}
                .sorted(by: {$0.scoreHard < $1.scoreHard})
        }
        return players
    }
    var body: some View {
        ZStack {
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
                }.frame(height: 100)
                HStack {
                    List(filteredPlayers, id: \.id) {
                        player in
                        VStack {
                            HStack {
                                Text(player.name)
                                Spacer()
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
                            VStack {
                                    ForEach(player.achievements, id: \.self) { achievement in
                                        HStack {
                                            Text(achievement)
                                            Spacer()
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
        Leaderboard(levelIndex: .constant(0))
    }
}
