//
//  MainView.swift
//  BrainableApp
//
//  Created by Vu Tran Hoang on 11/08/2023.
//

import Foundation
import SwiftUI

import AVFoundation

var audio: AVAudioPlayer!
var background: AVAudioPlayer!

struct MainView: View {
    @AppStorage("players")private var playersData: Data = Data()
    @StateObject private var players:PlayerModel = PlayerModel()
    
    @State private var isOn:Bool = false
    @State private var levelIndex:Int = 0
    @State private var languageIndex:Int = 0
    
    @State private var name:String = ""
    @State private var password:String = ""

    @State private var nameLogin:String = ""
    @State private var passwordLogin:String = ""
    
    @State private var nameTemp:String = ""
    @State private var passwordTemp:String = ""
    
    @State private var playersCount:Int = 0
    
    @State private var showingHowToPlay = false
    @State private var playerLoggin:Player = Player(id: 100, name: "noname", password: "nopassword", scoreEasy: 50000, scoreIntermediate: 50000, scoreHard: 50000, maxWinStreak: 0, winStreak: 0, gameTotal: 0, winners: 0, losers: 0, achievements: [])
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack {
                    HStack{
                        Text("Master Mind")
                            .padding(.leading)
                        Spacer()
                        if (checkForAccount(login: nameLogin, password: passwordLogin)) {
                            NavigationLink (destination:SettingView(isOn: $isOn, levelIndex: $levelIndex, languageIndex: $languageIndex, name: $nameLogin, password: $passwordLogin)) {
                                Image(systemName: "medal")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(isOn ? .white : .black)
                                    .padding(.trailing)
                            }
                            NavigationLink (destination:SettingView(isOn: $isOn, levelIndex: $levelIndex, languageIndex: $languageIndex, name: $nameLogin, password: $passwordLogin)) {
                                Image(systemName: "gearshape.circle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(isOn ? .white : .black)
                                    .padding(.trailing)
                            }
                        }
                    }
                    List {
                        Section {
                            HStack {
                                Text("Has account?")
                                Spacer()
                                Button(action: {
                                    if (checkForAccount(login: name, password: password)) {
                                        nameLogin = name
                                        passwordLogin = password
                                    }
                                    playClickSound()
                                }, label: {
                                    Text("Log In")
                                })
                            }
                            HStack {
                                Text("Username: ")
                                Spacer()
                                TextField (
                                    "Enter your player name ", text: $name
                                ).frame(width: 210)
                            }
                            HStack {
                                Text("Password: ")
                                Spacer()
                                TextField (
                                    "Enter password ", text: $password
                                ).frame(width: 210)
                            }
                        }
                        Section {
                            HStack {
                                Text("Create new account")
                                Spacer()
                                Button(action: {
//                                    if (!checkForAccount(login: nameTemp, password: passwordTemp)) {
                                        printValue()
                                        addAccount(loginValue: nameTemp, passwordValue: passwordTemp)
//                                    }
                                    nameTemp = ""
                                    passwordTemp = ""
                                    playClickSound()
                                }, label: {
                                    Text("Create")
                                })
                            }
                            HStack {
                                Text("Username: ")
                                Spacer()
                                TextField (
                                    "Enter your player name ", text: $nameTemp
                                ).frame(width: 210)
                            }
                            HStack {
                                Text("Password: ")
                                Spacer()
                                TextField (
                                    "Enter password ", text: $passwordTemp
                                )
                                .frame(width: 210)
                            }
                        }
                        Section {
                            HStack {
                                Spacer()
                                Text("Master Mind")
                                Spacer()
                            }
                        }.background(.clear)
                        Section {
                            if (checkForAccount(login: nameLogin, password: passwordLogin)) {
                                NavigationLink (destination: Game1View(players: players, level: $levelIndex, playerLoggin: $playerLoggin)){
                                    ZStack {
                                        Text("Play!")
                                    }
                                }
                            }
                            NavigationLink (destination: Leaderboard(players: players)){
                                ZStack {
                                    Text("Leaderboard")
                                }
                            }
                            Button("How To Play") {
                                showingHowToPlay.toggle()
                                playClickSound()
                            }
                            .sheet(isPresented: $showingHowToPlay) {
                                HowToPlayView()
                            }
                        }
                    }
                    
                }
            }
            .onAppear {
                playersCount = players.players.count
                checkForAccount(login: nameLogin, password: passwordLogin)
                playClickSound()
            }
        }
        .onAppear {
            loadPlayers()
            //clearData()
        }
        .environment(\.colorScheme, isOn ? .dark : .light)
    }
    
    func loadPlayers() {
        do {
            let decodedPlayers = try JSONDecoder().decode([Player].self, from: playersData)
            self.players.players = decodedPlayers
            print("Loading players")
        } catch {
            print("Error loading Players")
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
    
    func clearData() {
        players.players = []
        do {
            let encodedPlayers = try JSONEncoder().encode(players.players)
            playersData = encodedPlayers
            print("Already saved to AppStorage")
        } catch {
            print("Error saving players: ")
        }
    }
    
    func checkForAccount(login: String, password: String) -> Bool{
        print("Go into check account")
        var hasAccount:Bool = false
        players.players.forEach { player in
            if (player.name == login && player.password == password) {
                hasAccount = true
                playerLoggin = player
                print("Caught a value in this")
            }
        }
        print("Has Account is \(hasAccount)")
        return hasAccount
    }
    func printValue() {
        print("Got through state")
    }
    
    func addAccount(loginValue: String, passwordValue: String) {
        print("Calling add Function")
        var newPlayer = Player(id: players.players.count + 1, name: loginValue, password: passwordValue, scoreEasy: 50000, scoreIntermediate: 50000, scoreHard: 50000, maxWinStreak: 0, winStreak: 0, gameTotal: 0, winners: 0, losers: 0, achievements: [])
        players.players.append(newPlayer)
        print(newPlayer)
        print("Below is list: ")
        print(players.players)
        savePlayers()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


func playClickSound() {
    let url = Bundle.main.url(forResource: "click", withExtension: "mp3")
    
    guard url != nil else {
        return
    }
    
    do {
        audio = try AVAudioPlayer(contentsOf: url!)
        audio?.play()
    }
    catch {
        print(error)
    }
}

func playWinnerSound() {
    let url = Bundle.main.url(forResource: "winner", withExtension: "mp3")
    
    guard url != nil else {
        return
    }
    
    do {
        background = try AVAudioPlayer(contentsOf: url!)
        background?.play()
    }
    catch {
        print(error)
    }
}

func playBackgroundSound() {
    let url = Bundle.main.url(forResource: "background", withExtension: "mp3")
    
    guard url != nil else {
        return
    }
    
    do {
        background = try AVAudioPlayer(contentsOf: url!)
        background.numberOfLoops = 100
        background?.play()
    }
    catch {
        print(error)
    }
}

func playMainbackgroundSound() {
    let url = Bundle.main.url(forResource: "mainbackground", withExtension: "mp3")
    
    guard url != nil else {
        return
    }
    
    do {
        background = try AVAudioPlayer(contentsOf: url!)
        background.numberOfLoops = 100
        background?.play()
    }
    catch {
        print(error)
    }
}

func playLoserSound() {
    let url = Bundle.main.url(forResource: "loser", withExtension: "mp3")
    
    guard url != nil else {
        return
    }
    
    do {
        background = try AVAudioPlayer(contentsOf: url!)
        background?.play()
    }
    catch {
        print(error)
    }
}
