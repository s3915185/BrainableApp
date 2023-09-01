//
//  SettingView.swift
//  BrainableApp
//
//  Created by Vu Tran Hoang on 19/08/2023.
//

import Foundation
import SwiftUI

struct SettingView: View {
    @Binding var isOn: Bool
    @Binding var levelIndex:Int
    @Binding var languageIndex: Int
    @Binding var name:String
    @Binding var password:String
    @Environment(\.dismiss) var dismiss

    var level = ["Easy", "Intermediate", "Hard"]
    var languages = ["Vietnamese", "English"]
    var body: some View {
            List {
                Section {
                    HStack {
                        Text("Username: ")
                        Spacer()
                        Text(name)
                    }
                    HStack {
                        Text("Password: ")
                        Spacer()
                        Text(password);
                    }
                } header: {
                    Text("Account Information")
                }
                
                Section {
                    HStack{
                        Text("Dark Mode")
                        Spacer()
                        Toggle(isOn: $isOn) {
                        }.accentColor(Color.red)
                    }
                    Picker(selection: $levelIndex, label:
                            Text("Level")) {
                        ForEach(0 ..< level.count) {
                            Text(self.level[$0]).tag($0)
                        }
                    }
                    Picker(selection: $languageIndex, label:
                            Text("Language")) {
                        ForEach(0 ..< languages.count) {
                            Text(self.languages[$0]).tag($0)
                        }
                    }
                } header: {
                    Text("App Settings")
                }
                Section {
                    HStack {
                        Spacer()
                        Button(action: {
                            name = ""
                            password = ""
                            dismiss()
                        }, label: {
                            Text("Log Out")
                                .foregroundColor(.red)
                        })
                        Spacer()

                    }
                }
            }
            .environment(\.colorScheme, isOn ? .dark : .light)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(isOn: .constant(false), levelIndex: .constant(0), languageIndex: .constant(0), name: .constant("Hoang vu"), password: .constant("asdjhks"))
    }
}
