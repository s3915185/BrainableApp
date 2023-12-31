
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
import SwiftUI

struct ContentView: View {
    @AppStorage("players")private var playersData: Data = Data()
    @StateObject private var players:PlayerModel = PlayerModel()
    @AppStorage("hasPlayerContinue") private var hasPlayerContinueData: Data = Data()
    @AppStorage("playerLoggin") private var playerLogginData: Data = Data()
    @AppStorage("toMain") private var toMainData: Data = Data()
    @State private var hasPlayerContinue:Bool = false
    @State private var playerLoggin:Player = testPlayer
    @State var toMain:Bool = false
    @State var language:String  = "en"
    var body: some View {
        if (!toMain) {
            WelcomeView(toMain: $toMain, hasPlayerContinue: $hasPlayerContinue, language: $language)
                .onAppear {
                    loadToMain()
                    loadHasPlayerContinue()
                    loadPlayerLoggin()
                    if (hasPlayerContinue) {
                        toMain = true
                        
                    }
                    print("Has player continue: \(hasPlayerContinue)")
                    print("The player is: \(playerLoggin)")
                }
        }
        else {
            MainView(players: players, hasPlayerContinue: $hasPlayerContinue, playerLoggin: $playerLoggin, language: $language)
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
    func loadHasPlayerContinue() {
        do {
            let decodedHasPlayerContinue = try JSONDecoder().decode(Bool.self, from: hasPlayerContinueData)
            self.hasPlayerContinue = decodedHasPlayerContinue
            print("This value is : \(hasPlayerContinue)")
        } catch {
            print("Error loading HasPlayerContinue")
        }
    }
    func loadToMain() {
        do {
            let decodedToMain = try JSONDecoder().decode(Bool.self, from: toMainData)
            self.toMain = decodedToMain
        } catch {
            print("Error loading ToMain")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
