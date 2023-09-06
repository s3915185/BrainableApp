
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
import AVFoundation

var audio: AVAudioPlayer! // this variable is for real time sound
var background: AVAudioPlayer! //default this variable for background sound

func playClickSound() {
    let url = Bundle.main.url(forResource: "click", withExtension: "mp3") // this is the click sound whenever user click anything
    
    guard url != nil else {
        return
    }
    
    do {
        audio = try AVAudioPlayer(contentsOf: url!)
        audio?.play()
    }
    catch {
        print(error)
    }
}

func playWinnerSound() {
    let url = Bundle.main.url(forResource: "winner", withExtension: "mp3") // this sound will be played when user wins
    
    guard url != nil else {
        return
    }
    
    do {
        background = try AVAudioPlayer(contentsOf: url!)
        background?.play()
    }
    catch {
        print(error)
    }
}

func playBackgroundSound() {
    let url = Bundle.main.url(forResource: "background", withExtension: "mp3") // this is the background sound while playing the game
    
    guard url != nil else {
        return
    }
    
    do {
        background = try AVAudioPlayer(contentsOf: url!)
        background.numberOfLoops = 100
        background?.play()
    }
    catch {
        print(error)
    }
}

func playMainbackgroundSound() {
    let url = Bundle.main.url(forResource: "mainbackground", withExtension: "mp3")// this is the background sound in the menu app
    
    guard url != nil else {
        return
    }
    
    do {
        background = try AVAudioPlayer(contentsOf: url!)
        background.numberOfLoops = 100
        background?.play()
    }
    catch {
        print(error)
    }
}

func playLoserSound() {
    let url = Bundle.main.url(forResource: "loser", withExtension: "mp3") // this sound will be played when user loses

    
    guard url != nil else {
        return
    }
    
    do {
        background = try AVAudioPlayer(contentsOf: url!)
        background?.play()
    }
    catch {
        print(error)
    }
}
func playOuchSound() {
    let url = Bundle.main.url(forResource: "ouch", withExtension: "mp3") // this sound will be played when user loses a life

    
    guard url != nil else {
        return
    }
    
    do {
        audio = try AVAudioPlayer(contentsOf: url!)
        audio?.play()
    }
    catch {
        print(error)
    }
}
