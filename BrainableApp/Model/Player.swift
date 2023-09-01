//
//  Player.swift
//  monopoly
//
//  Created by Lê Ngọc Trâm on 18/08/2023.
//

import Foundation

/// Defines Player struct
struct Player:Codable, Hashable, Identifiable, Equatable{
    var id: Int
    var name: String
    var password: String
    var scoreEasy: Double = 50000
    var scoreIntermediate: Double = 50000
    var scoreHard: Double = 50000
    
    let achievements: [String]
}
