
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


/*
 PLAYER: This is datatype for player infomation
 */
struct Player:Codable, Hashable, Identifiable, Equatable{
    var id: Int //id
    var name: String  // username of player
    var password: String // password of player
    var scoreEasy: Int // best score for Easy mode
    var scoreIntermediate: Int // best score for Intermediate mode
    var scoreHard: Int // best score for Hard Mode
    var maxWinStreak: Int // max win streaks of user
    var winStreak: Int // current winstreak of user
    var gameTotal: Int // total game this user has played
    var winners: Int // how many games the user wins
    var losers: Int //how many games the user loses
    
    var achievements: [Achievement] // the achievements that user has founded
    
    // This function is to add one for each of the int value above
    mutating func addOne(number: inout Int) {
        number += 1
    }
    // this function is to compare if the current winstreak is bigger than the highest, then set highest
    mutating func compareLargeMaxWS() {
        maxWinStreak = winStreak > maxWinStreak ? winStreak : maxWinStreak
    }// this funciton is to comapare lowest value with the user's best score with the current score, then assign value
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
    // this function is to set 0 for any of the variable
    mutating func setZero(number: inout Int) {
        number = 0
    }
}

// this is sample to test in preview with predefined values
let testPlayer = Player(id: -1, name: "Test Name", password: "Test Password", scoreEasy: 666, scoreIntermediate: 777, scoreHard: 888, maxWinStreak: 2, winStreak: 1, gameTotal: 3, winners: 3, losers: 0, achievements: [])
