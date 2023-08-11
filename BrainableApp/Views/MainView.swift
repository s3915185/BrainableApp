//
//  MainView.swift
//  BrainableApp
//
//  Created by Vu Tran Hoang on 11/08/2023.
//

import Foundation
import SwiftUI

struct MainView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                List {
                    Section{
                        HStack{
                            Spacer()
                            Image(systemName: "gearshape.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.black)
                        }
                    }.listRowSeparator(.hidden)
                    Section {
                        HStack{
                            Text("Computing Capability")
                        }
                        HStack{
                            Text("Time Responses")
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
                        HStack(spacing: 0) {
                            Rectangle().fill(Color.red)
                                .aspectRatio(1.0, contentMode: .fit)
                                .frame(width: geometry.size.width * 0.45)
                            
                            Spacer()
                            Rectangle().fill(Color.green)
                                .aspectRatio(1.0, contentMode: .fit)
                                .frame(width: geometry.size.width * 0.45)

                        }
                        
                        HStack(spacing: 0) {
                            Rectangle().fill(Color.blue)
                                .aspectRatio(1.0, contentMode: .fit)
                                .frame(width: geometry.size.width * 0.45)
                            Spacer()
                            Rectangle().fill(Color.yellow)
                                .aspectRatio(1.0, contentMode: .fit)
                                .frame(width: geometry.size.width * 0.45)
                        }
                        
                        HStack{
                            Button(action: {}, label: {Text("Computing Capability")})
                            Button(action: {}, label: {Text("Time Responses")})
                        }
                        HStack{
                            Button(action: {}, label: {Text("Color Accurate")})
                            Button(action: {}, label: {Text("Attentions")})
                        }
                    } header: {
                        Text("Category")
                    }
                }.listStyle(.inset)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
