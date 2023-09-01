//
//  MainView.swift
//  BrainableApp
//
//  Created by Vu Tran Hoang on 11/08/2023.
//

import Foundation
import SwiftUI

struct MainView: View {
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
                        }
                        NavigationLink (destination:SettingView(isOn: $isOn, levelIndex: $levelIndex, languageIndex: $languageIndex, name: $nameLogin, password: $passwordLogin)) {
                            Image(systemName: "gearshape.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(isOn ? .white : .black)
                                .padding(.trailing)
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
                                    if (!checkForAccount(login: nameTemp, password: passwordTemp)) {
                                        addAccount(loginValue: nameTemp, passwordValue: nameTemp)
                                    }
                                    nameTemp = ""
                                    passwordTemp = ""
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
                                NavigationLink (destination: Game1View(level: $levelIndex)){
                                    ZStack {
                                        Text("Play!")
                                    }
                                }
                            }
                            NavigationLink (destination: Leaderboard(levelIndex: $levelIndex)){
                                ZStack {
                                    Text("Leaderboard")
                                }
                            }
                        }
                    }
                    
                }
            }
        }
        .environment(\.colorScheme, isOn ? .dark : .light)
    }
    func checkForAccount(login: String, password: String) -> Bool{
        var hasAccount:Bool = false
        playersCount = 0
        players.forEach { player in
            if (player.name == login && player.password == password) {
                hasAccount = true
            }
            playersCount += 1
        }
        print("Got here")
        return hasAccount
    }
    
    func saveJSON(_ d: Player) {
            do {
                let jsonData = try JSONEncoder().encode(d)
                let jsonString = String(data: jsonData, encoding: .utf8)!
                print("Got 1")
                if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                    let pathWithFilename = documentDirectory.appendingPathComponent("players.json")
                    print("Got 2")
                    do {
                        try jsonString.write(to: pathWithFilename,
                                             atomically: true,
                                             encoding: .utf8)
                        print("Got 3")
                    } catch {
                        print(error)
                    }
                    
                    print("Got 4")
                }
            } catch {
                print(error)
            }
        }

    
    func addAccount(loginValue: String, passwordValue: String) {
        var newPlayer = Player(id: playersCount + 1, name: loginValue, password: passwordValue, achievements: [])
        print("Got to add account")
        players.append(newPlayer)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
