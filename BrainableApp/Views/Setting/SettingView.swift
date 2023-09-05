//
//  SettingView.swift
//  BrainableApp
//
//  Created by Vu Tran Hoang on 19/08/2023.
//

import Foundation
import SwiftUI

struct SettingView: View {
    @AppStorage("hasPlayerContinue") private var hasPlayerContinueData: Data = Data()
    @Binding var isOn: Bool
    @Binding var levelIndex:Int
    @Binding var languageIndex: Int
    @Binding var name:String
    @Binding var password:String
    @Binding var hasPlayerContinue:Bool
    @Binding var language:String
    @Environment(\.dismiss) var dismiss
    

    var level = ["Easy", "Intermediate", "Hard"]
    var languages = ["English", "Tiếng Việt"]
    var languageIndexW = ["en", "vi"]
    var body: some View {
            List {
                if (name != "" && password != "") {
                    Section {
                        HStack {
                            Text("username")
                            Spacer()
                            Text(name)
                        }
                        HStack {
                            Text("password")
                            Spacer()
                            Text(password);
                        }
                    } header: {
                        Text("account-information")
                    }
                }
                Section {
                    HStack{
                        Text("dark-mode")
                        Spacer()
                        Toggle(isOn: $isOn) {
                        }.accentColor(Color.red)
                    }
                    Picker(selection: $levelIndex, label:
                            Text("level")) {
                        ForEach(0 ..< level.count) {
                            Text(LocalizedStringKey(self.level[$0])).tag($0)
                        }
                    }
                    Picker(selection: $language, label:
                            Text("language")) {
                        ForEach(0 ..< languages.count) {
                            Text(self.languages[$0]).tag(languageIndexW[$0])
                        }
                    }
                } header: {
                    Text("app-settings")
                }
                if (name != "" && password != "") {
                    Section {
                        HStack {
                            Spacer()
                            Button(action: {
                                name = ""
                                password = ""
                                dismiss()
                                hasPlayerContinue = false
                                saveHasPlayerContinue()
                                
                                loadHasPlayerContinue()
                                print("Has Player Continute: \(false)")
                            }, label: {
                                Text("log-out")
                                    .foregroundColor(.red)
                            })
                            Spacer()
                            
                        }
                    }
                }
            }
            .onAppear {
                playClickSound()
            }
            .environment(\.colorScheme, isOn ? .dark : .light)
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
        } catch {
            print("Error loading HasPlayerContinue")
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(isOn: .constant(false), levelIndex: .constant(0), languageIndex: .constant(0), name: .constant("Hoang vu"), password: .constant("asdjhks"), hasPlayerContinue: .constant(false), language: .constant("en"))
    }
}
