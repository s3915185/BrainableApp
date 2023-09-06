
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

/// Defines Player struct
struct Player:Codable, Hashable, Identifiable, Equatable{
    var id: Int
    var name: String
    var password: String
    var scoreEasy: Int
    var scoreIntermediate: Int
    var scoreHard: Int
    var maxWinStreak: Int
    var winStreak: Int
    var gameTotal: Int
    var winners: Int
    var losers: Int
    
    var achievements: [Achievement]
    
    mutating func addOne(number: inout Int) {
        number += 1
    }
    mutating func compareLargeMaxWS() {
        maxWinStreak = winStreak > maxWinStreak ? winStreak : maxWinStreak
    }
    mutating func compareLargeLowerScore(time: Int, level: Int) {
        if (level == 0) {
            scoreEasy = time < scoreEasy ? time : scoreEasy

        }
        else if (level == 1) {
            scoreIntermediate = time < scoreIntermediate ? time : scoreIntermediate

        }
        else {
            scoreHard = time < scoreHard ? time : scoreHard

        }
    }
    mutating func setZero(number: inout Int) {
        number = 0
    }
}

let testPlayer = Player(id: -1, name: "Test Name", password: "Test Password", scoreEasy: 666, scoreIntermediate: 777, scoreHard: 888, maxWinStreak: 2, winStreak: 1, gameTotal: 3, winners: 3, losers: 0, achievements: [])
