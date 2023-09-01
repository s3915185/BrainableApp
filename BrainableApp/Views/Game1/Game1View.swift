//
//  Game1View.swift
//  BrainableApp
//
//  Created by Vu Tran Hoang on 19/08/2023.
//

import Foundation
import SwiftUI


class GameMode: ObservableObject {
    @Published var Easy = NonogramEasy()
    @Published var Intermediate = NonogramIntermediate()
    @Published var Hard = NonogramHard()
    
    
    func reset () {
        Easy = NonogramEasy()
        Intermediate = NonogramIntermediate()
        Hard = NonogramHard()
    }
}

struct Game1View: View {
    @Binding var level:Int
    @Binding var playerLoggin:Player

    @State var storage = [[Int]]()
    @State var colorChoice:Bool = true
    @State var choice:Int = 2
    @State var life:Int = 5
    
    @State var reset:Bool = false
    @State var totalClicked:Int  = 0
    
    @State var showLoseTab:Bool = false
    @State var showWinTab:Bool = false
    @State var levelUpgrade:Int = 1
    
    @State var gameTime: Double = 0
    @State var timer: Timer?
    @State var isTimerRunning = false
    
    @State var maxTime: Double = 2000

    @StateObject var gm:GameMode = GameMode()
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    
                    Spacer()
                    
                    HStack (spacing: 8) {
                        ForEach(1..<life+1) { i in
                            Image(systemName: life >= i ? "heart.fill" : "heart")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.red)
                        }
                    }
                    .frame(width: CGFloat(40*life) + 20)
                    .onChange(of: life) { _ in
                        life == 0 ? showLoseTab = true : nil
                        life == 0 ? stopPlayerTimer() : nil
                    }
                    .onChange(of: showLoseTab) { _ in
                        if (!showLoseTab && life == 0) {
                            resetGame()
                            resetPlayerTimer()
                            startPlayerTimer()
                        }
                    }
                    .onChange(of: totalClicked) { _ in
                        if (totalClicked == ((level + levelUpgrade) * 5) * ((level + levelUpgrade) * 5)) {
                            showWinTab = true
                            stopPlayerTimer()
                        }
                    }
                    .onChange(of: reset, perform: { _ in
                        if reset {
                            resetPlayerTimer()
                            startPlayerTimer()
                        }
                    })
                    
                    
                    Spacer()
                    
                  
                    
                }
                HStack {
                    Text("Time: ")
                    Text("\(String(format: "%.1f", gameTime))")
                        .font(.system(size: 16, weight: .regular, design: .monospaced))
                        .frame(width: 70)
                        .onAppear{
                            startPlayerTimer()
                    }
                }
                .frame(width: 140)
                HStack {
                    Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                        GridRow {
                            Text("")
                            ForEach(0..<((level + levelUpgrade) * 5)) { u in
                                VStack {
                                    Spacer()
                                    if (level == 0) {
                                        Text(gm.Easy.x_dimensions[u])
                                            .padding(.bottom, 4)
                                    }
                                    else if (level == 1) {
                                        Text(gm.Intermediate.x_dimensions[u])
                                            .padding(.bottom, 4)
                                    }
                                    else {
                                        Text(gm.Hard.x_dimensions[u])
                                            .padding(.bottom, 4)
                                    }
                                }
                                .font(.system(size: 12, weight: .regular))
                                .frame(width:CGFloat( 50 / (level + levelUpgrade)), height: 200)
                            }
                        }
                        
                        ForEach(0..<((level + levelUpgrade) * 5)) { a in
                            GridRow {
                                if (level == 0) {
                                    HStack {
                                        Text(gm.Easy.y_dimensions[a])
                                            .font(.system(size: 12, weight: .regular))
                                            .frame(height: CGFloat(50 / (level + levelUpgrade)))
                                    }
                                    
                                    
                                    ForEach(0..<((level + levelUpgrade) * 5)) { b in
                                        if (level == 0) {
                                            let c = gm.Easy[a, b]
                                            let d = (c == 2) ? true : false
                                            if (d) {
                                                ColorSquare(level: $level, choice: $choice, xCoordinate: a, yCoordinate: b, reset: $reset, life: $life, totalClicked: $totalClicked, gm: gm)
                                            }
                                            
                                            else {
                                                ColorSquare(level: $level, choice: $choice, xCoordinate: a, yCoordinate: b, reset: $reset, life: $life, totalClicked: $totalClicked, gm: gm)
                                            }
                                        }
                                        else if (level == 1) {
                                            let c = gm.Intermediate[a, b]
                                            let d = (c == 2) ? true : false
                                            if (d) {
                                                ColorSquare(level: $level, choice: $choice, xCoordinate: a, yCoordinate: b, reset: $reset, life: $life, totalClicked: $totalClicked, gm: gm)
                                            }
                                            
                                            else {
                                                ColorSquare(level: $level, choice: $choice, xCoordinate: a, yCoordinate: b, reset: $reset, life: $life, totalClicked: $totalClicked, gm: gm)
                                            }
                                        }
                                        else {
                                            let c = gm.Hard[a, b]
                                            let d = (c == 2) ? true : false
                                            if (d) {
                                                ColorSquare(level: $level, choice: $choice, xCoordinate: a, yCoordinate: b, reset: $reset, life: $life, totalClicked: $totalClicked, gm: gm)
                                            }
                                            
                                            else {
                                                ColorSquare(level: $level, choice: $choice, xCoordinate: a, yCoordinate: b, reset: $reset, life: $life, totalClicked: $totalClicked, gm: gm)
                                            }
                                        }
                                    }
                                }
                                else if (level == 1) {
                                    Text(gm.Intermediate.y_dimensions[a])
                                        .font(.system(size: 12, weight: .regular))
                                        .frame(height: CGFloat(50 / (level + 2)))
                                    
                                    
                                    ForEach(0..<((level + levelUpgrade) * 5)) { b in
                                        if (level == 0) {
                                            let c = gm.Easy[a, b]
                                            let d = (c == 2) ? true : false
                                            if (d) {
                                                ColorSquare(level: $level, choice: $choice, xCoordinate: a, yCoordinate: b, reset: $reset, life: $life, totalClicked: $totalClicked, gm: gm)
                                            }
                                            
                                            else {
                                                ColorSquare(level: $level, choice: $choice, xCoordinate: a, yCoordinate: b, reset: $reset, life: $life, totalClicked: $totalClicked, gm: gm)
                                            }
                                        }
                                        else if (level == 1) {
                                            let c = gm.Intermediate[a, b]
                                            let d = (c == 2) ? true : false
                                            if (d) {
                                                ColorSquare(level: $level, choice: $choice, xCoordinate: a, yCoordinate: b, reset: $reset, life: $life, totalClicked: $totalClicked, gm: gm)
                                            }
                                            
                                            else {
                                                ColorSquare(level: $level, choice: $choice, xCoordinate: a, yCoordinate: b, reset: $reset, life: $life, totalClicked: $totalClicked, gm: gm)
                                            }
                                        }
                                        else {
                                            let c = gm.Hard[a, b]
                                            let d = (c == 2) ? true : false
                                            if (d) {
                                                ColorSquare(level: $level, choice: $choice, xCoordinate: a, yCoordinate: b, reset: $reset, life: $life, totalClicked: $totalClicked, gm: gm)
                                            }
                                            
                                            else {
                                                ColorSquare(level: $level, choice: $choice, xCoordinate: a, yCoordinate: b, reset: $reset, life: $life, totalClicked: $totalClicked, gm: gm)
                                            }
                                        }
                                    }
                                }
                                else {
                                    Text(gm.Hard.y_dimensions[a])
                                        .font(.system(size: 12, weight: .regular))
                                        .frame(height: CGFloat(50 / (level + 2)))
                                    
                                    
                                    ForEach(0..<((level + levelUpgrade) * 5)) { b in
                                        if (level == 0) {
                                            let c = gm.Easy[a, b]
                                            let d = (c == 2) ? true : false
                                            if (d) {
                                                ColorSquare(level: $level, choice: $choice, xCoordinate: a, yCoordinate: b, reset: $reset, life: $life, totalClicked: $totalClicked, gm: gm)
                                            }
                                            
                                            else {
                                                ColorSquare(level: $level, choice: $choice, xCoordinate: a, yCoordinate: b, reset: $reset, life: $life, totalClicked: $totalClicked, gm: gm)
                                            }
                                        }
                                        else if (level == 1) {
                                            let c = gm.Intermediate[a, b]
                                            let d = (c == 2) ? true : false
                                            if (d) {
                                                ColorSquare(level: $level, choice: $choice, xCoordinate: a, yCoordinate: b, reset: $reset, life: $life, totalClicked: $totalClicked, gm: gm)
                                            }
                                            
                                            else {
                                                ColorSquare(level: $level, choice: $choice, xCoordinate: a, yCoordinate: b, reset: $reset, life: $life, totalClicked: $totalClicked, gm: gm)
                                            }
                                        }
                                        else {
                                            let c = gm.Hard[a, b]
                                            let d = (c == 2) ? true : false
                                            if (d) {
                                                ColorSquare(level: $level, choice: $choice, xCoordinate: a, yCoordinate: b, reset: $reset, life: $life, totalClicked: $totalClicked, gm: gm)
                                            }
                                            
                                            else {
                                                ColorSquare(level: $level, choice: $choice, xCoordinate: a, yCoordinate: b, reset: $reset, life: $life, totalClicked: $totalClicked, gm: gm)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                HStack {
                    VStack{
                        Color.blue
                            .frame(width:CGFloat( 65), height: CGFloat(65))
                            .border(choice == 2 ? .red.opacity(1) : .black.opacity(0.1), width: 1.5)
                    }
                    .onTapGesture {
                        playClickSound()
                        choice = 2
                    }
                    VStack {
                        Color.gray.opacity(0.3)
                            .frame(width:CGFloat( 65), height: CGFloat(65))
                            .border(choice == 1 ? .red.opacity(1) : .black.opacity(0.1), width: 1.5)
                    }
                    .onTapGesture {
                        playClickSound()
                        choice = 1
                    }
                }
            }
            if (showLoseTab) {
                ZStack {
                    Spacer()
                        .frame(width: 1000, height: 1000)
                        .background(Color.gray.opacity(0.4))
                    LoseTab(playerLoggin: $playerLoggin, showLoseTab: $showLoseTab, level: level, time: gameTime)
                }
            }
            if (showWinTab) {
                ZStack {
                    Spacer()
                        .frame(width: 1000, height: 1000)
                        .background(Color.gray.opacity(0.4))
                    WinTab(showWinTab: $showWinTab, storage: $storage, colorChoice: $colorChoice, choice: $choice, life: $life, gm: gm, reset: $reset, totalClicked: $totalClicked, playerLoggin: $playerLoggin, level: level, time: gameTime)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            playClickSound()
            playBackgroundSound()
        }
    }
    
    func resetGame() {
        storage = [[Int]]()
        colorChoice = true
        choice = 2
        life = 5
        gm.reset()
        reset = true
        totalClicked = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            reset = false
        }
    }
    
    func startPlayerTimer() {
        if timer == nil {
            isTimerRunning = true
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true){ _ in
                if gameTime >= maxTime {
                    stopPlayerTimer()
                } else {
                    gameTime += 0.1

                }
            }
        }
    }
    
    func resetPlayerTimer() {
        timer?.invalidate()
        timer = nil
        isTimerRunning = false
        gameTime = 0
    }
    
    func stopPlayerTimer() {
        timer?.invalidate()
        timer = nil
        isTimerRunning = false
    }
}

struct Game1View_Previews: PreviewProvider {
    static var previews: some View {
        Game1View(level: .constant(2), playerLoggin: .constant(players[0]))
        Game1View(level: .constant(1), playerLoggin: .constant(players[0]))
        Game1View(level: .constant(0), playerLoggin: .constant(players[0]))
    }
}

struct LoseTab: View {
    @Binding var playerLoggin:Player
    @Binding var showLoseTab:Bool
    var level:Int
    var time:Double
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
              updatePlayerInfo(player: playerLoggin, level: level, time: time, isWin: false)
              for i in 0..<players.count {
                  if (players[i].id == playerLoggin.id) {
                      playerLoggin = players[i]
                  }
              }
              playLoserSound()
          }
    }
}

func updatePlayerInfo(player: Player, level: Int, time: Double, isWin: Bool) {
    var playerChange = Player(id: player.id, name: player.name, password: player.password, scoreEasy: player.scoreEasy, scoreIntermediate: player.scoreIntermediate, scoreHard: player.scoreHard, maxWinStreak: player.maxWinStreak, winStreak: player.winStreak, gameTotal: player.gameTotal, winners: player.winners, losers: player.losers, achievements: player.achievements)
    for i in 0..<players.count {
        if (players[i].id == player.id) {
            if (isWin) {
                if (level == 0) {
                    playerChange.scoreEasy = time < playerChange.scoreEasy ? time : playerChange.scoreEasy
                }
                else if (level == 1) {
                    playerChange.scoreIntermediate = time < playerChange.scoreIntermediate ? time : playerChange.scoreIntermediate
                }
                else {
                    playerChange.scoreHard = time < playerChange.scoreHard ? time : playerChange.scoreHard
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
            players[i] = playerChange
        }
    }
    
}

struct WinTab: View {
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
              updatePlayerInfo(player: playerLoggin, level: level, time: time, isWin: true)
              for i in 0..<players.count {
                  if (players[i].id == playerLoggin.id) {
                      playerLoggin = players[i]
                  }
              }
              playWinnerSound()
          }
    }
}


struct ColorSquare: View {
    @Binding var level: Int
    @Binding var choice: Int
    @State var isCorrect:Int = 0
    var xCoordinate:Int
    var yCoordinate:Int
    @Binding var reset:Bool
    @Binding var life:Int
    @Binding var totalClicked:Int
    
    @State var clicked:Bool = false
    @State var rightValue: Bool = false
    @State var valueAdded: Bool = false
    
    
    @State var levelUpgrade:Int = 1
    
    
    var borderColor:Color {
        if (clicked && !rightValue) {return .red.opacity(1)}
        return .black.opacity(0.1)
    }
    
    @ObservedObject var gm: GameMode
    var body: some View {
        VStack{
            let checkBlue = isCorrect == 2 ? true : false
            let checkGray = isCorrect == 1 ? true : false
            if (checkBlue && !reset) {
                Color.blue
                    .frame(width:CGFloat( 65 / (level + levelUpgrade)), height: CGFloat(65 / (level + levelUpgrade)))
                    .border(borderColor)
            }
            else if (checkGray && !reset){
                Color.gray.opacity(0.3)
                    .frame(width:CGFloat( 65 / (level + levelUpgrade)), height: CGFloat(65 / (level + levelUpgrade)))
                    .border(borderColor)

            }
            else {
                Color.white
                    .frame(width:CGFloat( 65 / (level + levelUpgrade)), height: CGFloat(65 / (level + levelUpgrade)))
                    .border(borderColor)

            }
        }
        .onTapGesture {
            playClickSound()
            if (!clicked) {
                clicked = true
                print("is clicked = true, total clicked =  \(totalClicked)")
                
            }
            isCorrect = choice
            if (level == 0) {
                if (gm.Easy.storage[xCoordinate][yCoordinate] != isCorrect) {
                    life -= 1
                    print(life);
                }
                else {
                    rightValue = true
                    
                }
            }else if (level == 1) {
                if (gm.Intermediate.storage[xCoordinate][yCoordinate] != isCorrect) {
                    life -= 1
                    print(life);
                }
                else {
                    rightValue = true
                    
                }
            }
            else if (level == 2) {
                if (gm.Hard.storage[xCoordinate][yCoordinate] != isCorrect) {
                    life -= 1
                    print(life);
                }
                else {
                    rightValue = true
                    
                }
            }
            if (rightValue) {
                if (!valueAdded) {
                    totalClicked+=1
                    valueAdded = true
                }}
        
  
        }
        .onChange(of: reset) { _ in
           if reset {
               isCorrect = 0
               clicked = false
               rightValue = false
               valueAdded = false
           }
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
    init() {
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
                if (Int.random(in: 1...20) == 1) {
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
    init() {
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
                if (Int.random(in: 1...3) == 1) {
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
    init() {
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
                if (Int.random(in: 1...3) == 1) {
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
