//
//  PlayerModel.swift
//  BrainableApp
//
//  Created by Lê Ngọc Trâm on 02/09/2023.
//
import Foundation

class PlayerModel: ObservableObject {
    @Published var players: [Player] = []
}

