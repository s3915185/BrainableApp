//
//  WelcomeView.swift
//  BrainableApp
//
//  Created by Vu Tran Hoang on 11/08/2023.
//

import Foundation
import SwiftUI

struct WelcomeView: View {
    @AppStorage("hasPlayerContinue") private var hasPlayerContinueData: Data = Data()
    @Binding var toMain: Bool
    @Binding var hasPlayerContinue:Bool
    @Binding var language:String
    @State private var offset: Int = 0
    @State private var swipeAnimating = false
    @State private var swipeOffset:Int  = 0

    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
            VStack{
                HStack{
                    Image("icon")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .cornerRadius(20)
                        .offset(x: 0.0, y: CGFloat(offset))
                                    .onAppear {
                                        withAnimation(.easeOut(duration: 10).repeatForever()) { self.offset = 300 }
                                    }
                }
                Spacer()
                HStack {
                    Text("Welcome to MasterMind")
                        .font(.title.bold())
                        .foregroundColor(.white)
                        .shadow(color: Color.black.opacity(0.5) , radius: 3, x: 0, y: 10)
                }
                HStack{
                    Text("swipe-left")
                        .foregroundColor(.white)
                    Image(systemName: "arrow.left.to.line")
                        .foregroundColor(.white)
                } .offset(x: CGFloat(swipeOffset), y: 0)
                    .onAppear {
                        withAnimation(.easeOut(duration: 1).repeatForever()) { self.swipeOffset = 150 }
                    }
            }
        }
        .environment(\.locale, Locale.init(identifier: language))
        .gesture(DragGesture(minimumDistance: 20, coordinateSpace: .local)
            .onEnded({ value in
                if value.translation.width < 0 {
                    withAnimation(.easeIn(duration: 1)){
                        toMain = true
                    }
                }
            }))
        .onAppear {
            playMainbackgroundSound()
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
        } catch {
            print("Error loading HasPlayerContinue")
        }
    }

}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(toMain: .constant(false), hasPlayerContinue: .constant(false), language: .constant("en"))
    }
}
