//
//  GameMode.swift
//  BrainableApp
//
//  Created by Lê Ngọc Trâm on 02/09/2023.
//

import SwiftUI

class GameMode: ObservableObject {
    private var easyRandomDegrade = 20
    private var intermediateRandomDegrade = 6
    private var hardRandomDegrade = 6
    @Published var Easy = NonogramEasy(fromRandom: 20)
    @Published var Intermediate = NonogramIntermediate(fromRandom: 6)
    @Published var Hard = NonogramHard(fromRandom: 6)
    func easyReset() {
        easyRandomDegrade -= 5
        easyRandomDegrade = (easyRandomDegrade < 5) ? 5 : easyRandomDegrade
        Easy = NonogramEasy(fromRandom: easyRandomDegrade)
    }
    func intermediateReset() {
        intermediateRandomDegrade -= 1
        intermediateRandomDegrade = (intermediateRandomDegrade < 3) ? 3 : intermediateRandomDegrade
        Intermediate = NonogramIntermediate(fromRandom: intermediateRandomDegrade)

    }
    func hardReset() {
        hardRandomDegrade -= 1
        hardRandomDegrade = (hardRandomDegrade < 3) ? 3 : hardRandomDegrade
        Hard = NonogramHard(fromRandom: hardRandomDegrade)
    }
    func reset () {
        Easy = NonogramEasy(fromRandom: easyRandomDegrade)
        Intermediate = NonogramIntermediate(fromRandom: intermediateRandomDegrade)
        Hard = NonogramHard(fromRandom: hardRandomDegrade)
    }
}

func updatePlayerInfo(players: PlayerModel, player: Player, level: Int, time: Int, isWin: Bool) {
    @AppStorage("players")var playersData: Data = Data()
    var playerChange = Player(id: player.id, name: player.name, password: player.password, scoreEasy: player.scoreEasy, scoreIntermediate: player.scoreIntermediate, scoreHard: player.scoreHard, maxWinStreak: player.maxWinStreak, winStreak: player.winStreak, gameTotal: player.gameTotal, winners: player.winners, losers: player.losers, achievements: player.achievements)
    for i in 0..<players.players.count {
        if (players.players[i].id == player.id) {
            if (isWin) {
                if (level == 0) {
                    if (time < playerChange.scoreEasy) {
                        playerChange.scoreEasy = time
                        var object:Achievement = Achievement(id: 100, achieveName: "noname", timeCount: 50000, mode: "nomode", image: "noimage", modeID: 0)
                        var hasObject:Achievement = Achievement(id: 100, achieveName: "noname", timeCount: 50000, mode: "nomode", image: "noimage", modeID: 0)
                        var caughtAchieve:Bool = false
                        var caughtLowerTimeAchieve:Bool = false
                        innerLoop: for achi in easyAchieves {
                            if ( achi.timeCount >= time) {
                                caughtAchieve = true
                                object = achi
                                break innerLoop
                            }
                        }
                        print("This is object: ")
                        print(object)
                        if (caughtAchieve) {
                        aLoop: for achi in playerChange.achievements {
                            if (achi.modeID == object.modeID) {
                                if (achi.timeCount >= object.timeCount) {
                                    hasObject = achi
                                    caughtLowerTimeAchieve = true
                                    break aLoop
                                }
                            }
                        }
                            if (!caughtLowerTimeAchieve) {
                                print("No achivements caught in the achievements, then parse in the playerChange")
                                playerChange.achievements.append(object)
                                print("Value in playerChange: ")
                                print(playerChange.achievements)
                            }
                            print("This is caughtAchieve: ")
                            print(hasObject)
                            if (caughtLowerTimeAchieve) {
                                playerChange.achievements.removeAll { Achievement in
                                    Achievement == hasObject
                                }
                                playerChange.achievements.append(object)
                                print("Remove hasObject, then add object in")
                            }
                        }
                    }
                }
                else if (level == 1) {
                    if (time < playerChange.scoreIntermediate) {
                        playerChange.scoreIntermediate = time
                        var object:Achievement = Achievement(id: 100, achieveName: "noname", timeCount: 50000, mode: "nomode", image: "noimage", modeID: 0)
                        var hasObject:Achievement = Achievement(id: 100, achieveName: "noname", timeCount: 50000, mode: "nomode", image: "noimage", modeID: 0)
                        var caughtAchieve:Bool = false
                        var caughtLowerTimeAchieve:Bool = false
                        innerLoop: for achi in intermediateAchieves {
                            if ( achi.timeCount >= time) {
                                caughtAchieve = true
                                object = achi
                                break innerLoop
                            }
                        }
                        print("This is object: ")
                        print(object)
                        if (caughtAchieve) {
                        aLoop: for achi in playerChange.achievements {
                            if (achi.modeID == object.modeID) {
                                if (achi.timeCount >= object.timeCount) {
                                    hasObject = achi
                                    caughtLowerTimeAchieve = true
                                    break aLoop
                                }
                            }
                        }
                            if (!caughtLowerTimeAchieve) {
                                print("No achivements caught in the achievements, then parse in the playerChange")
                                playerChange.achievements.append(object)
                                print("Value in playerChange: ")
                                print(playerChange.achievements)
                            }
                            print("This is caughtAchieve: ")
                            print(hasObject)
                            if (caughtLowerTimeAchieve) {
                                playerChange.achievements.removeAll { Achievement in
                                    Achievement == hasObject
                                }
                                playerChange.achievements.append(object)
                                print("Remove hasObject, then add object in")
                            }
                        }
                    }
                }
                else {
                    if (time < playerChange.scoreHard) {
                        playerChange.scoreHard = time
                        var object:Achievement = Achievement(id: 100, achieveName: "noname", timeCount: 50000, mode: "nomode", image: "noimage", modeID: 0)
                        var hasObject:Achievement = Achievement(id: 100, achieveName: "noname", timeCount: 50000, mode: "nomode", image: "noimage", modeID: 0)
                        var caughtAchieve:Bool = false
                        var caughtLowerTimeAchieve:Bool = false
                        innerLoop: for achi in hardAchieves {
                            if ( achi.timeCount >= time) {
                                caughtAchieve = true
                                object = achi
                                break innerLoop
                            }
                        }
                        print("This is object: ")
                        print(object)
                        if (caughtAchieve) {
                        aLoop: for achi in playerChange.achievements {
                            if (achi.modeID == object.modeID) {
                                if (achi.timeCount >= object.timeCount) {
                                    hasObject = achi
                                    caughtLowerTimeAchieve = true
                                    break aLoop
                                }
                            }
                        }
                            if (!caughtLowerTimeAchieve) {
                                print("No achivements caught in the achievements, then parse in the playerChange")
                                playerChange.achievements.append(object)
                                print("Value in playerChange: ")
                                print(playerChange.achievements)
                            }
                            print("This is caughtAchieve: ")
                            print(hasObject)
                            if (caughtLowerTimeAchieve) {
                                playerChange.achievements.removeAll { Achievement in
                                    Achievement == hasObject
                                }
                                playerChange.achievements.append(object)
                                print("Remove hasObject, then add object in")
                            }
                        }
                    }
                }
                playerChange.winStreak  = playerChange.winStreak + 1
                playerChange.gameTotal = playerChange.gameTotal + 1
                playerChange.winners = playerChange.winners + 1
                playerChange.maxWinStreak = playerChange.maxWinStreak < playerChange.winStreak ? playerChange.winStreak : playerChange.maxWinStreak
            }
            else {
                playerChange.winStreak = 0
                playerChange.gameTotal = playerChange.gameTotal + 1
                playerChange.losers = playerChange.gameTotal + 1
            }
            players.players[i] = playerChange
            savePlayers()
            
        }
    }
    
    func savePlayers() {
        do {
            let encodedPlayers = try JSONEncoder().encode(players.players)
            playersData = encodedPlayers
            print("Already saved to AppStorage")
        } catch {
            print("Error saving players: ")
        }
    }
    
}

class NonogramEasy {
    @State var levelUpgrade:Int = 1
    var level:Int = 0
    var storage = [[Int]]()
    var y_dimensions = [String]()
    var x_dimensions = [String]()
    var valueGrid = [[Int]]()
    init(fromRandom random: Int) {
        for _ in 0..<((level + levelUpgrade) * 5) {
                    var subArray = [Int]()
                    for _ in 0..<((level + levelUpgrade) * 5) {
                        subArray.append(0)
                    }
                    valueGrid.append(subArray)
                }
        
        for h in 0..<((level + levelUpgrade) * 5) {
            var subArray = [Int]()
            var y_dimension = 0
            var y_string = ""
            var subY = [Int]()
            for j in 0..<((level + levelUpgrade) * 5) {
                if (Int.random(in: 1...random) == 1) {
                    if (y_dimension != 0) {
                        subY.append(y_dimension)
                        y_dimension = 0
                    }
                    subArray.append(1)
                    valueGrid[h][j] = 1
                }
                else {
                    y_dimension += 1
                    subArray.append(2)
                    valueGrid[h][j] = 2;
                }
            }
            if (y_dimension != 0) {
                subY.append(y_dimension)
                y_dimension = 0
            }
            
            for z in 0..<subY.count {
                y_string.insert(contentsOf: "\(subY[z]) ", at: y_string.endIndex)
            }
            y_dimensions.append(y_string)
            storage.append(subArray)
        }
        
        for a in 0..<((level + levelUpgrade) * 5) {
            var x_dimension = 0
            var x_string = ""
            var subX = [Int]()
            for b in 0..<((level + levelUpgrade) * 5) {
                let value = storage[b][a]
                if (value == 1) {
                    if (x_dimension != 0) {
                        subX.append(x_dimension)
                        x_dimension = 0
                    }
                }
                else {
                    x_dimension += 1
                }
            }
            if (x_dimension != 0) {
                subX.append(x_dimension)
                x_dimension = 0
            }
            for e in 0..<subX.count {
                x_string.insert(contentsOf: "\(subX[e])\n", at: x_string.endIndex)
            }
            x_dimensions.append(x_string)
        }
    }
    subscript(row: Int, column: Int) -> Int {
        get {
            // This could validate arguments.
            return storage[row][column]
        }
        set {
            // This could also validate.
            storage[row][column] = newValue
        }
    }
}

class NonogramIntermediate {
    @State var levelUpgrade:Int = 1
    
    @State var level:Int = 1
    var storage = [[Int]]()
    var y_dimensions = [String]()
    var x_dimensions = [String]()
    var valueGrid = [[Int]]()
    init(fromRandom randomrate: Int) {
        for _ in 0..<((level + levelUpgrade) * 5) {
                    var subArray = [Int]()
                    for _ in 0..<((level + levelUpgrade) * 5) {
                        subArray.append(0)
                    }
                    valueGrid.append(subArray)
                }
        
        for h in 0..<((level + levelUpgrade) * 5) {
            var subArray = [Int]()
            var y_dimension = 0
            var y_string = ""
            var subY = [Int]()
            for j in 0..<((level + levelUpgrade) * 5) {
                if (Int.random(in: 1...randomrate) == 1) {
                    if (y_dimension != 0) {
                        subY.append(y_dimension)
                        y_dimension = 0
                    }
                    subArray.append(1)
                    valueGrid[h][j] = 1
                }
                else {
                    y_dimension += 1
                    subArray.append(2)
                    valueGrid[h][j] = 2
                }
            }
            if (y_dimension != 0) {
                subY.append(y_dimension)
                y_dimension = 0
            }
            
            for z in 0..<subY.count {
                y_string.insert(contentsOf: "\(subY[z]) ", at: y_string.endIndex)
            }
            y_dimensions.append(y_string)
            storage.append(subArray)
        }
        
        for a in 0..<((level + levelUpgrade) * 5) {
            var x_dimension = 0
            var x_string = ""
            var subX = [Int]()
            for b in 0..<((level + levelUpgrade) * 5) {
                var value = storage[b][a]
                if (value == 1) {
                    if (x_dimension != 0) {
                        subX.append(x_dimension)
                        x_dimension = 0
                    }
                }
                else {
                    x_dimension += 1
                }
            }
            if (x_dimension != 0) {
                subX.append(x_dimension)
                x_dimension = 0
            }
            for e in 0..<subX.count {
                x_string.insert(contentsOf: "\(subX[e])\n", at: x_string.endIndex)
            }
            x_dimensions.append(x_string)
        }
    }
    subscript(row: Int, column: Int) -> Int {
        get {
            // This could validate arguments.
            return storage[row][column]
        }
        set {
            // This could also validate.
            storage[row][column] = newValue
        }
    }
}

class NonogramHard {
    @State var levelUpgrade:Int = 1
    @State var level:Int = 2
    var storage = [[Int]]()
    var y_dimensions = [String]()
    var x_dimensions = [String]()
    var valueGrid = [[Int]]()
    init(fromRandom randomrate: Int) {
        for _ in 0..<((level + levelUpgrade) * 5) {
                    var subArray = [Int]()
                    for _ in 0..<((level + levelUpgrade) * 5) {
                        subArray.append(0)
                    }
                    valueGrid.append(subArray)
                }
        for h in 0..<((level + levelUpgrade) * 5) {
            var subArray = [Int]()
            var y_dimension = 0
            var y_string = ""
            var subY = [Int]()
            for j in 0..<((level + levelUpgrade) * 5) {
                if (Int.random(in: 1...randomrate) == 1) {
                    if (y_dimension != 0) {
                        subY.append(y_dimension)
                        y_dimension = 0
                    }
                    subArray.append(1)
                    valueGrid[h][j] = 1
                }
                else {
                    y_dimension += 1
                    subArray.append(2)
                    valueGrid[h][j] = 2
                }
            }
            if (y_dimension != 0) {
                subY.append(y_dimension)
                y_dimension = 0
            }
            
            for z in 0..<subY.count {
                y_string.insert(contentsOf: "\(subY[z]) ", at: y_string.endIndex)
            }
            y_dimensions.append(y_string)
            storage.append(subArray)
        }
        
        for a in 0..<((level + levelUpgrade) * 5) {
            var x_dimension = 0
            var x_string = ""
            var subX = [Int]()
            for b in 0..<((level + levelUpgrade) * 5) {
                var value = storage[b][a]
                if (value == 1) {
                    if (x_dimension != 0) {
                        subX.append(x_dimension)
                        x_dimension = 0
                    }
                }
                else {
                    x_dimension += 1
                }
            }
            if (x_dimension != 0) {
                subX.append(x_dimension)
                x_dimension = 0
            }
            for e in 0..<subX.count {
                x_string.insert(contentsOf: "\(subX[e])\n", at: x_string.endIndex)
            }
            x_dimensions.append(x_string)
        }
    }
    subscript(row: Int, column: Int) -> Int {
        get {
            // This could validate arguments.
            return storage[row][column]
        }
        set {
            // This could also validate.
            storage[row][column] = newValue
        }
    }
}
