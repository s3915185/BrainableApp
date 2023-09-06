
/*
 RMIT University Vietnam
 Course: COSC2659 IOS Development
 Semester: 2022B
 Assessment: Assignment 2
 Author: Tran Hoang Vu
 ID: 3915185
 Created date: 15/8/2023
 Last modified: 6/9/2023
 Acknowledgement: Your lectures, tutorials, information linked in the report
 */

import Foundation
import SwiftUI

struct GameView: View {
    @AppStorage("hasPlayerContinue") private var hasPlayerContinueData: Data = Data()
    @AppStorage("playerLoggin") private var playerLogginData: Data = Data()
    
    @AppStorage("answerGrid") private var answerGridData: Data = Data()
    @AppStorage("playerGrid") private var playerGridData: Data = Data()
    @AppStorage("x_dimens") private var x_dimensData: Data = Data()
    @AppStorage("y_dimens") private var y_dimensData: Data = Data()
    
    @AppStorage("levelIndex") private var levelData: Data = Data()
    @AppStorage("life") private var lifeData: Data = Data()
    @AppStorage("totalClicked") private var totalClickedData: Data = Data()
    
    @AppStorage("gameTime") private var gameTimeData: Data = Data()
    
    @ObservedObject var players:PlayerModel
    @Binding var levelIndex:Int
    @Binding var hasPlayerContinue:Bool
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
    
    @State var gameTime: Int = 0
    @State var minute:Int = 0
    @State var second:Int = 0
    @State var timer: Timer?
    @State var isTimerRunning = false
    
    @State var maxTime: Int = 50000
    @Environment(\.dismiss) var dismiss
    @State var showInstructions:Bool = false
    @Binding var isOn:Bool
    
    @State private var answerGrid:[[Int]] = [[1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 1], [2, 1, 2, 2, 1, 2, 1, 2, 2, 2, 2, 2, 2, 1, 1], [1, 2, 2, 2, 2, 1, 1, 1, 2, 1, 2, 2, 2, 2, 2], [2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2], [2, 1, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2], [1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2], [2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 1, 2, 1, 2], [2, 2, 1, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2], [2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2], [2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2], [2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2], [1, 2, 2, 2, 2, 2, 1, 2, 2, 1, 1, 2, 1, 2, 2], [2, 2, 2, 2, 2, 2, 2, 1, 2, 1, 1, 2, 2, 2, 2], [2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2], [2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 1, 2, 2]]
    @State private var playerGrid:[[Int]] = [[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]
    @State private var x_dimens:[String] = ["1\n2\n5\n3\n", "1\n2\n10\n", "7\n7\n", "15\n", "1\n13\n", "2\n12\n", "1\n3\n4\n3\n", "2\n6\n2\n1\n", "7\n7\n", "2\n1\n6\n2\n", "11\n2\n", "6\n8\n", "10\n2\n", "1\n4\n8\n", "13\n"]
    @State private var y_dimens:[String] = ["11 1 ", "1 2 1 6 ", "4 1 5 ", "15 ", "1 7 5 ", "14 ", "6 4 1 1 ", "2 5 6 ", "15 ", "7 7 ", "15 ", "5 2 1 2 ", "7 1 4 ", "15 ", "7 4 2 "]

    var levelString:[String] = ["Easy", "Intermediate", "Hard"]
    @State var gm:GameMode = GameMode()
    @State var heartLose:Bool = false
    @State var blueClick:Bool = false
    @State var grayClick:Bool = false
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    HStack {
                        HStack {
                            Button(action: {
                                playMainbackgroundSound()
                                hasPlayerContinue = false
                                saveHasPlayerContinue()
                                loadHasPlayerContinue()
                                hasPlayerContinue = false
                                print("At this state hasplayerContinute: \(hasPlayerContinue)")
                                dismiss()
                            }, label: {
                                Text("exit")
                                    .accentColor(.black)
                            })
                        }
                        .background {
                            Rectangle()
                                .fill(.white)
                                .frame(width: 50, height: 25)
                                .cornerRadius(20)
                                .overlay (
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.blue, lineWidth: 1)
                                )
                        }
                        
                        Spacer()
                        HStack {
                            Button(action: {
                                showInstructions.toggle()
                            }, label: {
                                Text("instructions")
                                    .accentColor(.black)
                            })
                            .padding(.trailing)
                            .sheet(isPresented: $showInstructions) {
                                HowToPlayView()
                            }
                        }.background {
                            Rectangle()
                                .fill(.white)
                                .frame(width: 100, height: 25)
                                .cornerRadius(20)
                                .padding(.trailing)
                                .overlay (
                                    RoundedRectangle(cornerRadius: 40)
                                        .stroke(Color.blue, lineWidth: 1)
                                        .padding(.trailing)
                                )
                        }
                    }.padding(.leading)
                }
                VStack {
                    Spacer()
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
                            heartLose = true
                            playOuchSound()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                                heartLose = false

                            })
                            life == 0 ? stopPlayerTimer() : nil
                            if (life == 0) {
                                withAnimation(.easeIn(duration: 0.5)) {
                                    showLoseTab = true
                                }
                            }
                            
                        }
                        .onChange(of: showLoseTab) { _ in
                            if (!showLoseTab && life == 0) {
                                resetGame()
                                resetPlayerTimer()
                                startPlayerTimer()
                            }
                        }
                        .onChange(of: totalClicked) { _ in
                            if (totalClicked == ((levelIndex + levelUpgrade) * 5) * ((levelIndex + levelUpgrade) * 5)) {
                                withAnimation(.easeIn(duration: 0.5)) {
                                    showWinTab = true
                                }
                                stopPlayerTimer()
                            }
                        }
                        .onChange(of: reset, perform: { _ in
                            if reset {
                                if (levelIndex == 0) {
                                    answerGrid = gm.Easy.valueGrid
                                    x_dimens = gm.Easy.x_dimensions
                                    y_dimens = gm.Easy.y_dimensions
                                }
                                else if (levelIndex == 1) {
                                    answerGrid = gm.Intermediate.valueGrid
                                    x_dimens = gm.Intermediate.x_dimensions
                                    y_dimens = gm.Intermediate.y_dimensions
                                }
                                else {
                                    answerGrid = gm.Hard.valueGrid
                                    x_dimens = gm.Hard.x_dimensions
                                    y_dimens = gm.Hard.y_dimensions
                                }
                                playerGrid = [[Int]]()
                                for _ in 0..<((levelIndex + levelUpgrade) * 5) {
                                    var subArray = [Int]()
                                    for _ in 0..<((levelIndex + levelUpgrade) * 5) {
                                        subArray.append(0)
                                    }
                                    playerGrid.append(subArray)
                                }
                                saveAnswerGrid()
                                saveXDimens()
                                saveYDimens()
                                resetPlayerTimer()
                                startPlayerTimer()
                            }
                        })
                        Spacer()
                    }
                    HStack {
                        Text("time")
                            .font(.system(size: 16, weight: .regular, design: .monospaced))
                            .frame(width: 80)
                        Text("\(minute) ")
                            .font(.system(size: 16, weight: .regular, design: .monospaced))
                            .frame(width: 20)
                        Text("minutes")
                            .font(.system(size: 16, weight: .regular, design: .monospaced))
                            .frame(width: 100)
                        Text("\(second % 60) ")
                            .font(.system(size: 16, weight: .regular, design: .monospaced))
                            .frame(width: 20)
                        Text("seconds")
                            .font(.system(size: 16, weight: .regular, design: .monospaced))
                            .frame(width: 80)
                            .onAppear{
                                startPlayerTimer()
                            }
                    }
                    .background {
                        Rectangle()
                            .fill(isOn ? .black : .white)
                            .frame(width: 330, height: 25)
                            .cornerRadius(20)
                            .overlay (
                                RoundedRectangle(cornerRadius: 40)
                                    .stroke(Color.blue, lineWidth: 1)
                            )
                    }
                    .cornerRadius(5)
                    .onChange(of: second, perform: { _ in
                        if (second % 60 == 0 && second != 0) {
                            minute += 1
                        }
                    })
                    .frame(width: 290)
                    VStack {
                        HStack {
                            Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                                GridRow {
                                    Text("")
                                    ForEach(0..<((levelIndex + levelUpgrade) * 5)) { u in
                                        VStack {
                                            Spacer()
                                            Text(x_dimens[u])
                                                .padding(.bottom, 4)
                                        }
                                        .font(.system(size: 12, weight: .regular))
                                        .frame(width:CGFloat( 50 / (levelIndex + levelUpgrade)), height: 200)
                                    }
                                    .background {
                                        Rectangle()
                                            .fill(isOn ? .gray : .white)
                                            .frame(width: CGFloat( 60 / (levelIndex + 1)), height: 130)
                                            .cornerRadius(20)
                                            .offset(y: 60)
                                    }
                                }
                                .offset(y: 15)
                                
                                ForEach(0..<((levelIndex + levelUpgrade) * 5)) { a in
                                    GridRow {
                                        VStack {
                                            HStack {
                                                Spacer()
                                                Text(y_dimens[a])
                                                    .font(.system(size: 12, weight: .regular))
                                                    .frame(height: CGFloat(50 / (levelIndex + levelUpgrade)))
                                            }}.frame(width: 60)
                                        .background {
                                            Rectangle()
                                                .fill(isOn ? .gray : .white)
                                                .frame(width: 100, height: CGFloat( 60 / (levelIndex + 1)))
                                                .cornerRadius(20)
                                                .offset(x: 15)
                                        }
                                        ForEach(0..<((levelIndex + levelUpgrade) * 5)) { b in
                                            ColorSquare(level: $levelIndex, choice: $choice, xCoordinate: a, yCoordinate: b, reset: $reset, life: $life, totalClicked: $totalClicked, answerGrid: $answerGrid, playerGrid: $playerGrid)
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
                                    .scaleEffect(blueClick ? 1.5 : 1)
                                    .animation(.spring(response: 0.4, dampingFraction: 0.6))
                            }
                            .onTapGesture {
                                blueClick = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    blueClick = false
                                }
                                playClickSound()
                                choice = 2
                            }
                            VStack {
                                Color.gray
                                    .frame(width:CGFloat( 65), height: CGFloat(65))
                                    .border(choice == 1 ? .red.opacity(1) : .black.opacity(0.1), width: 1.5)
                                    .scaleEffect(grayClick ? 1.5 : 1)
                                    .animation(.spring(response: 0.4, dampingFraction: 0.6))
                            }
                            .onTapGesture {
                                grayClick = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    grayClick = false
                                }
                                playClickSound()
                                choice = 1
                            }
                        }
                    }
                    .offset(y: -60)
                }
                Spacer()
            }
        }
        .overlay {
            if heartLose {
                Rectangle()
                    .frame(width: 400, height: 1000)
                    .foregroundColor(.red.opacity(0.4))
                    .zIndex(99)
                    .animation(.linear(duration: 0.3), value: heartLose)
            }
            if (showLoseTab) {
                ZStack {
                    Spacer()
                        .frame(width: 1000, height: 1000)
                        .background(Color.gray.opacity(0.4))
                    LoseTab(players: players, showLoseTab: $showLoseTab, storage: $storage, colorChoice: $colorChoice, choice: $choice, life: $life, gm: gm, reset: $reset, totalClicked: $totalClicked, playerLoggin: $playerLoggin,hasPlayerContinue: $hasPlayerContinue, level: levelIndex, time: gameTime)
                        .onAppear {
                            hasPlayerContinue = false
                            saveHasPlayerContinue()
                        }
                }
            }
            if (showWinTab) {
                
                ZStack {
                    Spacer()
                        .frame(width: 1000, height: 1000)
                        .background(Color.gray.opacity(0.4))
                    WinTab(players: players, showWinTab: $showWinTab, storage: $storage, colorChoice: $colorChoice, choice: $choice, life: $life, gm: gm, reset: $reset, totalClicked: $totalClicked, playerLoggin: $playerLoggin,hasPlayerContinue: $hasPlayerContinue, level: levelIndex, time: gameTime)
                        .onAppear {
                            hasPlayerContinue = false
                            saveHasPlayerContinue()
                        }
                }
            }
        }
        .background {
            Image(isOn ? "gamebackground-black" : "gamebackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all, edges: .all)
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            if (hasPlayerContinue) {
                playerGrid = [[Int]]()
                loadAnswerGrid()
                loadPlayerGrid()
                loadXDimens()
                loadYDimens()
                loadLife()
                loadTotalClicked()
                loadGameTime()
                minute = gameTime / 60
                second = gameTime
                print("This is playerGrid after: \(playerGrid)")
            }
            else {
                if (levelIndex == 0) {
                    answerGrid = gm.Easy.valueGrid
                    x_dimens = gm.Easy.x_dimensions
                    y_dimens = gm.Easy.y_dimensions
                }
                else if (levelIndex == 1) {
                    answerGrid = gm.Intermediate.valueGrid
                    x_dimens = gm.Intermediate.x_dimensions
                    y_dimens = gm.Intermediate.y_dimensions
                }
                else {
                    answerGrid = gm.Hard.valueGrid
                    x_dimens = gm.Hard.x_dimensions
                    y_dimens = gm.Hard.y_dimensions
                }
                playerGrid = [[Int]]()
                for _ in 0..<((levelIndex + levelUpgrade) * 5) {
                    var subArray = [Int]()
                    for _ in 0..<((levelIndex + levelUpgrade) * 5) {
                        subArray.append(0)
                    }
                    playerGrid.append(subArray)
                }
                saveAnswerGrid()
                savePlayerGrid()
                saveXDimens()
                saveYDimens()
            }
            saveLevel()
            loadLevel()
            hasPlayerContinue = true
            print("Got bugs")
            saveHasPlayerContinue()
            playClickSound()
            playBackgroundSound()
        }
    }
    func loadLevel() {
        do {
            let decodedLevel = try JSONDecoder().decode(Int.self, from: levelData)
            self.levelIndex = decodedLevel
        } catch {
            print("Error loading Level")
        }
    }
    
    func loadAnswerGrid() {
        do {
            let decodedAnswerGrid = try JSONDecoder().decode([[Int]].self, from: answerGridData)
            self.answerGrid = decodedAnswerGrid
        } catch {
            print("Error loading AnswerGrid")
        }
    }
    
    func loadLife() {
        do {
            let decodedLife = try JSONDecoder().decode(Int.self, from: lifeData)
            self.life = decodedLife
        } catch {
            print("Error loading life")
        }
    }
    
    func loadTotalClicked() {
        do {
            let decodedTotalClicked = try JSONDecoder().decode(Int.self, from: totalClickedData)
            self.totalClicked = decodedTotalClicked
        } catch {
            print("Error loading totalClicked")
        }
    }
    
    func loadPlayerGrid() {
        do {
            let decodedPlayerGrid = try JSONDecoder().decode([[Int]].self, from: playerGridData)
            self.playerGrid = decodedPlayerGrid
        } catch {
            print("Error loading PlayerGrid")
        }
    }
    
    func loadXDimens() {
        do {
            let decodedXDimens = try JSONDecoder().decode([String].self, from: x_dimensData)
            self.x_dimens = decodedXDimens
        } catch {
            print("Error loading XDimens")
        }
    }
    
    func loadYDimens() {
        do {
            let decodedYDimens = try JSONDecoder().decode([String].self, from: y_dimensData)
            self.y_dimens = decodedYDimens
        } catch {
            print("Error loading YDimens")
        }
    }
    func loadGameTime() {
        do {
            let decodedGameTime = try JSONDecoder().decode(Int.self, from: gameTimeData)
            self.gameTime = decodedGameTime
        } catch {
            print("Error loading gameTime")
        }
    }
    
    func saveGameTime() {
        do {
            let encodedGameTime = try JSONEncoder().encode(gameTime)
            gameTimeData = encodedGameTime
        } catch {
            print("Error saving gameTime")
        }
    }
    
    func saveAnswerGrid() {
        do {
            let encodedAnswerGrid = try JSONEncoder().encode(answerGrid)
            answerGridData = encodedAnswerGrid
        } catch {
            print("Error saving answerGrid")
        }
    }
    
    func savePlayerGrid() {
        do {
            let encodedPlayerGrid = try JSONEncoder().encode(playerGrid)
            playerGridData = encodedPlayerGrid
        } catch {
            print("Error saving playerGrid")
        }
    }
    
    func saveXDimens() {
        do {
            let encodedXDimens = try JSONEncoder().encode(x_dimens)
            x_dimensData = encodedXDimens
        } catch {
            print("Error saving XDimens")
        }
    }
    
    func saveYDimens() {
        do {
            let encodedYDimens = try JSONEncoder().encode(y_dimens)
            y_dimensData = encodedYDimens
        } catch {
            print("Error saving YDimens")
        }
    }
    
    func saveLevel() {
        do {
            let encodedLevel = try JSONEncoder().encode(levelIndex)
            levelData = encodedLevel
        } catch {
            print("Error saving level")
        }
    }
    
    func saveHasPlayerContinue() {
        do {
            let encodedHasPlayerContinue = try JSONEncoder().encode(hasPlayerContinue)
            hasPlayerContinueData = encodedHasPlayerContinue
        } catch {
            print("Error saving HasPlayerContinue")
        }
    }
    
    func loadHasPlayerContinue() {
        do {
            let decodedHasPlayerContinue = try JSONDecoder().decode(Bool.self, from: hasPlayerContinueData)
            self.hasPlayerContinue = decodedHasPlayerContinue
            print("This value is : \(hasPlayerContinue)")
        } catch {
            print("Error loading HasPlayerContinue")
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
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ _ in
                if gameTime >= maxTime {
                    stopPlayerTimer()
                } else {
                    gameTime += 1
                    second += 1
                    saveGameTime()
                }
            }
        }
    }
    
    func resetPlayerTimer() {
        timer?.invalidate()
        timer = nil
        isTimerRunning = false
        gameTime = 0
        second = 0
        minute = 0
    }
    
    func stopPlayerTimer() {
        timer?.invalidate()
        timer = nil
        isTimerRunning = false
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(players: PlayerModel(), levelIndex: .constant(2), hasPlayerContinue: .constant(false), playerLoggin: .constant(testPlayer), isOn: .constant(false))
        GameView(players: PlayerModel(), levelIndex: .constant(1), hasPlayerContinue: .constant(false), playerLoggin: .constant(testPlayer), isOn: .constant(false))
        GameView(players: PlayerModel(), levelIndex: .constant(0), hasPlayerContinue: .constant(false), playerLoggin: .constant(testPlayer), isOn: .constant(false))
    }
}
