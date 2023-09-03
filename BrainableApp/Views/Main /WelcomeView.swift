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

    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
            VStack{
                Button(action: {
                    hasPlayerContinue = false
                    saveHasPlayerContinue()
                    loadHasPlayerContinue()
                    print(hasPlayerContinue)
                }, label: {
                    Text("Change hasPlayerContinue to false")
                        .foregroundColor(.white)
                })
                Spacer()
                HStack{
                    Text("Swift Left")
                        .foregroundColor(.white)
                    Image(systemName: "arrow.left.to.line")
                        .foregroundColor(.white)
                }
            }
        }
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
        WelcomeView(toMain: .constant(false), hasPlayerContinue: .constant(false))
    }
}
