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
                    List(players, id: \.id) {
                        player in
                        Text(player.name)
                    }
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
