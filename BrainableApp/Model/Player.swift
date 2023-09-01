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
    var scoreEasy: Double
    var scoreIntermediate: Double
    var scoreHard: Double
}
