//
//  Achievement.swift
//  BrainableApp
//
//  Created by Lê Ngọc Trâm on 01/09/2023.
//

import Foundation

struct Achievement:Codable, Hashable, Identifiable, Equatable {
    let id: Int
    let achieveName: String
    let timeCount: Int
    let mode: String
    let image: String
}
