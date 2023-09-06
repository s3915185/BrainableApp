
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

import AVFoundation

struct MainView: View {
    @AppStorage("players")private var playersData: Data = Data()
    @AppStorage("hasPlayerContinue") private var hasPlayerContinueData: Data = Data()
    @AppStorage("playerLoggin") private var playerLogginData: Data = Data()
    @AppStorage("levelIndex") private var levelData: Data = Data()
    @ObservedObject var players:PlayerModel
    @Binding var hasPlayerContinue:Bool
    @Binding var playerLoggin:Player
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
    @State private var showPlaying:Bool = false
    @State private var showContinueButton:Bool = true
    @Binding var language:String
    @State private var goesToLeaderboard:Bool = false
    @Environment(\.dismiss) var dismiss
    @State private var settingAnimate:Bool = false
    @State private var loginTap:Bool = false
    @State private var registerTap:Bool = false
    @State private var playTap:Bool = false
    @State private var leaderboardTap:Bool = false
    @State private var howtoplayTap:Bool = false
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    VStack {
                        HStack{
                            Image("icon")
                                .resizable()
                                .cornerRadius(10)
                                .frame(width: 50, height: 50)
                                .padding(.leading)
                            Spacer()
                            Button(action: {
                                clearData()
                                print("Data has cleared")
                                loadPlayers()
                                print(players.players)
                            }, label: {
                                Text("clear-data")
                                    .foregroundColor(.red)
                                    .font(.system(size: 18).bold())
                            })
                            .padding(.trailing)
                                NavigationLink (destination:SettingView(isOn: $isOn, levelIndex: $levelIndex, languageIndex: $languageIndex, name: $nameLogin, password: $passwordLogin, hasPlayerContinue: $hasPlayerContinue, language: $language)) {
                                    Image(systemName: "gearshape.circle.fill")
                                        .resizable()
                                        .rotationEffect(Angle(degrees: settingAnimate ? 360*2 : 0))
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(isOn ? .white : .black)
                                        .padding(.trailing)
                                        .animation(.linear(duration: 2.5), value: settingAnimate)
                                        .onAppear {
                                            settingAnimate.toggle()
                                            Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
                                                self.settingAnimate.toggle()
                                            }
                                        }
                                }
                        }
                        List {
                            if (nameLogin == "" && passwordLogin == "") {
                                Section {
                                    HStack {
                                        Spacer()
                                        Button(action: {
                                            loginTap = true
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                               loginTap = false
                                            }
                                            if (checkForAccount(login: name, password: password)) {
                                                nameLogin = name
                                                passwordLogin = password
                                                name = ""
                                                password = ""
                                            }
                                            playClickSound()
                                        }, label: {
                                            Text("log-in")
                                                .foregroundColor(isOn ? .white : .black)
                                        })
                                        .frame(width: 150, height: 30)
                                        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                                .mask(RoundedRectangle(cornerRadius: 30))
                                                .shadow(color: Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)).opacity(loginTap ? 0.6 : 0.3), radius: loginTap ? 10 : 5, x: 0, y: loginTap ? 0 : 5)
                                               
                                                .scaleEffect(loginTap ? 1.5 : 1)
                                        .animation(.spring(response: 0.4, dampingFraction: 0.6))
                                    }
                                    HStack {
                                        Text("username")
                                        Spacer()
                                        TextField (
                                            "Enter your player name ", text: $name
                                        ).frame(width: 210)
                                            .onChange(of: name, perform: { _ in
                                                playClickSound()
                                            })
                                    }
                                    HStack {
                                        Text("password")
                                        Spacer()
                                        SecureField (
                                            "Enter password ", text: $password
                                        ).frame(width: 210)
                                            .onChange(of: password, perform: { _ in
                                                playClickSound()
                                            })
                                    }
                                } header: {
                                    Text("log-in")
                                        .font(.title)
                                        .bold()
                                        .foregroundColor(isOn ? .white : .black)
                                        .shadow(color:isOn ? .white.opacity(0.3) : .black.opacity(0.3), radius: 5)
                                }
                                .listRowSeparator(.hidden)
                                Section {
                                    HStack {
                                        Spacer()
                                        Button(action: {
                                            registerTap = true
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                registerTap = false
                                            }
                                            if (!checkForAccount(login: nameTemp, password: passwordTemp)) {
                                                addAccount(loginValue: nameTemp, passwordValue: passwordTemp)
                                            }
                                            nameTemp = ""
                                            passwordTemp = ""
                                            playClickSound()
                                        }, label: {
                                            Text("create").foregroundColor(isOn ? .white : .black)
                                        }).frame(width: 70, height: 30)
                                            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
                                                    .mask(RoundedRectangle(cornerRadius: 30))
                                                    .shadow(color: Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)).opacity(registerTap ? 0.6 : 0.3), radius: registerTap ? 10 : 5, x: 0, y: registerTap ? 0 : 5)
                                                   
                                                    .scaleEffect(registerTap ? 1.5 : 1)
                                            .animation(.spring(response: 0.4, dampingFraction: 0.6))
                                    }
                                    HStack {
                                        Text("username")
                                        Spacer()
                                        TextField (
                                            "Enter your player name ", text: $nameTemp
                                        ).frame(width: 210)
                                            .onChange(of: nameTemp, perform: { _ in
                                                playClickSound()
                                            })
                                    }
                                    HStack {
                                        Text("password")
                                        Spacer()
                                        SecureField (
                                            "Enter password ", text: $passwordTemp
                                        )
                                        .frame(width: 210)
                                        .onChange(of: passwordTemp, perform: { _ in
                                            playClickSound()
                                        })
                                    }
                                } header: {
                                    Text("register").font(.title)
                                        .bold()
                                        .foregroundColor(isOn ? .white : .black)
                                        .shadow(color:isOn ? .white.opacity(0.3) : .black.opacity(0.3), radius: 5)
                                }                                .listRowSeparator(.hidden)
}
                            Section {
                                ScrollView() {
                                    VStack {
                                        if (nameLogin != "" && passwordLogin != "") {
                                            VStack {
                                                NavigationLink (destination: GameView(players: players, levelIndex: $levelIndex, hasPlayerContinue: $hasPlayerContinue, playerLoggin: $playerLoggin, isOn: $isOn), isActive: $showPlaying){
                                                    Button(action: {
                                                        playTap = true
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                            playTap = false
                                                        }
                                                        showPlaying = true
                                                    }, label: {
                                                        ZStack {
                                                            Rectangle()
                                                                .fill(.clear)
                                                                .frame(width: geometry.size.width - 38, height: 200)
                                                                .cornerRadius(20)
                                                                .clipped()
                                                                .overlay (
                                                                    Image("play-card")
                                                                        .resizable()
                                                                        .scaledToFit()
                                                                        .blur(radius: 1)
                                                                )
                                                            Text("play")                                                        .shadow(radius: 5)
                                                                .font(.title.bold())
                                                                .foregroundColor(isOn ? .white : .black)
                                                                .offset(y: -30)
                                                        }
                                                    }).scaleEffect(playTap ? 1.2 : 1)
                                                        .animation(.spring(response: 0.4, dampingFraction: 0.6))
                                                }
                                            }}
                                        VStack {
                                            NavigationLink (destination: Leaderboard(players: players), isActive: $goesToLeaderboard){
                                                Button(action: {
                                                    leaderboardTap = true
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                        leaderboardTap = false
                                                    }

                                                    goesToLeaderboard = true
                                                }, label: {
                                                    ZStack {
                                                        Rectangle()
                                                            .fill(.clear)
                                                            .frame(width: geometry.size.width - 38, height: 200)
                                                            .cornerRadius(20)
                                                            .clipped()
                                                            .overlay (
                                                                Image("leaderboard-card")
                                                                    .resizable()
                                                                    .scaledToFit()
                                                                    .blur(radius: 1)

                                                            )
                                                        Text("leaderboard")
                                                            .shadow(radius: 5)

                                                            .font(.title.bold())
                                                            .foregroundColor(isOn ? .white : .black)
                                                            .offset(y: -30)
                                                    }
                                                }).scaleEffect(leaderboardTap ? 1.2 : 1)
                                                    .animation(.spring(response: 0.4, dampingFraction: 0.6))
                                            }
                                        }
                                        VStack {
                                            Button(action: {
                                                howtoplayTap = true
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                    howtoplayTap = false
                                                }

                                                showingHowToPlay.toggle()
                                                print(showingHowToPlay)
                                                playClickSound()
                                            }, label: {
                                                ZStack {
                                                    Rectangle()
                                                        .fill(.clear)
                                                        .frame(width: geometry.size.width - 38, height: 200)
                                                        .cornerRadius(20)
                                                        .clipped()
                                                        .overlay (
                                                            Image("howtoplay-card")
                                                                .resizable()
                                                                .scaledToFit()
                                                                .blur(radius: 1)

                                                        )
                                                    Text("how-to-play")
                                                        .shadow(radius: 5)
                                                        .font(.title.bold())
                                                        .foregroundColor(isOn ? .white : .black)
                                                        .offset(y: -30)
                                                }                                            }).scaleEffect(howtoplayTap ? 2 : 1)
                                                .animation(.spring(response: 0.4, dampingFraction: 0.6))
                                        }
                                    }
                                    .padding(.leading)
                                }
                            } header: {
                                Text("Go to")
                            }
                        }
                        .environment(\.defaultMinListRowHeight, 50)
                        .environment(\.defaultMinListHeaderHeight, 45)
                        .scrollContentBackground(.hidden)
                        
                        
                    }
                    if (hasPlayerContinue && showContinueButton) {
                        VStack {
                            HStack {
                                Text("Continue?")
                                Button(action: {
                                    showPlaying = true
                                    showContinueButton = false
                                }, label: {
                                    Text("Yes")
                                })
                                Button(action: {
                                    showPlaying = false
                                    hasPlayerContinue = false
                                    saveHasPlayerContinue()
                                    print("This is hasPlayerContinue: \(hasPlayerContinue)")
                                    showContinueButton = false
                                }, label: {
                                    Text("No")
                                })
                            }
                        }.frame(width: geometry.size.width, height: geometry.size.height)
                            .background(.white)
                    }
                }
            }.background {
                if (!isOn) {
                    Image("mainbackground")
                        .resizable()
                        .ignoresSafeArea(.all, edges: .all)
                }
                else {
                    Image("mainbackground-black")
                        .resizable()
                        .ignoresSafeArea(.all, edges: .all)
                }
            }
            .onAppear {
                playersCount = players.players.count
                checkForAccount(login: nameLogin, password: passwordLogin)
                playClickSound()
            }
        }.sheet(isPresented: $showingHowToPlay) {
            HowToPlayView()
        }

        .onAppear {
            loadPlayers()
            //clearData()
            print(players.players)
            if (hasPlayerContinue) {
                loadLevel()
                print("This is level caught: \(levelIndex)")
                nameLogin = playerLoggin.name
                passwordLogin = playerLoggin.password
            }
        }
        .environment(\.colorScheme, isOn ? .dark : .light)
        .environment(\.locale, Locale.init(identifier: language))
    }
    
    func loadLevel() {
        do {
            let decodedLevel = try JSONDecoder().decode(Int.self, from: levelData)
            self.levelIndex = decodedLevel
        } catch {
            print("Error loading Level")
        }
    }
    func loadPlayers() {
        do {
            let decodedPlayers = try JSONDecoder().decode([Player].self, from: playersData)
            self.players.players = decodedPlayers
        } catch {
            print("Error loading Players")
        }
    }
    func loadPlayerLoggin() {
        do {
            let decodedPlayerLoggin = try JSONDecoder().decode(Player.self, from: playerLogginData)
            self.playerLoggin = decodedPlayerLoggin
        } catch {
            print("Error loading playerLoggin")
        }
    }
    
    func savePlayers() {
        do {
            let encodedPlayers = try JSONEncoder().encode(players.players)
            playersData = encodedPlayers
        } catch {
            print("Error saving players: ")
        }
    }
    func savePlayerLoggin() {
        do {
            let encodedPlayerLoggin = try JSONEncoder().encode(playerLoggin)
            playerLogginData = encodedPlayerLoggin
        } catch {
            print("Error saving playerLoggin")
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
    func clearData() {
        players.players = []
        do {
            let encodedPlayers = try JSONEncoder().encode(players.players)
            playersData = encodedPlayers
        } catch {
            print("Error saving players: ")
        }
    }
    
    func checkForAccount(login: String, password: String) -> Bool{
        var hasAccount:Bool = false
        players.players.forEach { player in
            if (player.name == login && player.password == password) {
                hasAccount = true
                playerLoggin = player
                savePlayerLoggin()
            }
        }
        return hasAccount
    }
    func addAccount(loginValue: String, passwordValue: String) {
        var newPlayer = Player(id: players.players.count + 1, name: loginValue, password: passwordValue, scoreEasy: 50000, scoreIntermediate: 50000, scoreHard: 50000, maxWinStreak: 0, winStreak: 0, gameTotal: 0, winners: 0, losers: 0, achievements: [])
        players.players.append(newPlayer)
        savePlayers()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(players: PlayerModel(), hasPlayerContinue: .constant(false), playerLoggin: .constant(testPlayer), language: .constant("en"))
    }
}
