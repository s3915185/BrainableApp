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
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack {
                    HStack{
                        Text("Master Mind")
                            .padding(.leading)
                        Spacer()
                        NavigationLink (destination:SettingView(isOn: $isOn, levelIndex: $levelIndex, languageIndex: $languageIndex)) {
                            Image(systemName: "gearshape.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(isOn ? .white : .black)
                                .padding(.trailing)
                        }
                    }
                    List {
                        Section{
                            HStack{
                                Spacer()
                            }
                        }.listRowSeparator(.hidden)
                        Section {
                            HStack{
                                Text("Computing Capability")
                            }
                            HStack{
                                Text("Logical Reasoning")
                            }
                            HStack{
                                Text("Color Accurate")
                            }
                            HStack {
                                Text("Attentions")
                            }
                        } header: {
                            Text("Abilities")
                        }.listRowSeparator(.hidden)
                        
                        Section {
                            NavigationLink (destination: Game1View(level: $levelIndex)){
                                ZStack {
                                    Rectangle().fill(Color.red)
                                        .aspectRatio(1.0, contentMode: .fit)
                                        .frame(width: geometry.size.width * 0.6)
                                    Text("Computational Capabilities")
                                }
                            }                        } header: {
                            Text("Category")
                        }
                    }.listStyle(.inset)
                    
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
