//
//  ModelPlayer.swift
//  BrainableApp
//
//  Created by Lê Ngọc Trâm on 01/09/2023.
//

import Foundation
import CoreLocation

var players = decodeJsonFromPlayerJsonFile(jsonFileName: "players.json")

// How to decode a json file into a struct
func decodeJsonFromPlayerJsonFile(jsonFileName: String) -> [Player] {
    if let file = Bundle.main.url(forResource: jsonFileName, withExtension: nil){
        if let data = try? Data(contentsOf: file) {
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode([Player].self, from: data)
                return decoded
            } catch let error {
                fatalError("Failed to decode JSON: \(error)")
            }
        }
    } else {
        fatalError("Couldn't load \(jsonFileName) file")
    }
    return [ ] as [Player]
}
