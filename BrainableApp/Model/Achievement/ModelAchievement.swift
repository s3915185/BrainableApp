//
//  ModelAchievement.swift
//  BrainableApp
//
//  Created by Lê Ngọc Trâm on 01/09/2023.
//

import Foundation
import CoreLocation

var achievementsList = decodeJsonFromAchievementsJsonFile(jsonFileName: "achievements.json")

// How to decode a json file into a struct
func decodeJsonFromAchievementsJsonFile(jsonFileName: String) -> [Achievement] {
    if let file = Bundle.main.url(forResource: jsonFileName, withExtension: nil){
        if let data = try? Data(contentsOf: file) {
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode([Achievement].self, from: data)
                return decoded
            } catch let error {
                fatalError("Failed to decode JSON: \(error)")
            }
        }
    } else {
        fatalError("Couldn't load \(jsonFileName) file")
    }
    return [ ] as [Achievement]
}


