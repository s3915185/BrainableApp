//
//  SoundController.swift
//  BrainableApp
//
//  Created by Lê Ngọc Trâm on 02/09/2023.
//

import Foundation
import AVFoundation

var audio: AVAudioPlayer!
var background: AVAudioPlayer!

func playClickSound() {
    let url = Bundle.main.url(forResource: "click", withExtension: "mp3")
    
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
    let url = Bundle.main.url(forResource: "winner", withExtension: "mp3")
    
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
    let url = Bundle.main.url(forResource: "background", withExtension: "mp3")
    
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
    let url = Bundle.main.url(forResource: "mainbackground", withExtension: "mp3")
    
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
    let url = Bundle.main.url(forResource: "loser", withExtension: "mp3")
    
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
    let url = Bundle.main.url(forResource: "ouch", withExtension: "mp3")
    
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
