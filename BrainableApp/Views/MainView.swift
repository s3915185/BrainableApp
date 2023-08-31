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
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack {
                    HStack{
                        Text("Master Mind")
                            .padding(.leading)
                        Spacer()
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
                                    // ADD FUNCTIONS
                                    nameLogin = name
                                    passwordLogin = password
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
                                    // ADD FUNCTIONS
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
                            NavigationLink (destination: Game1View(level: $levelIndex)){
                                ZStack {
                                    Text("Play!")
                                }
                            }
                            NavigationLink (destination: Game1View(level: $levelIndex)){
                                ZStack {
                                    Text("Leaderboard")
                                }
                            }
                            NavigationLink (destination: Game1View(level: $levelIndex)){
                                ZStack {
                                    Text("How To Play")
                                }
                            }
                        }
                    }
                    
                }
            }
        }
        .environment(\.colorScheme, isOn ? .dark : .light)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
