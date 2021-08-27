//
//  Player.swift
//  GameCounter
//
//  Created by Маргарита Жучик on 27.08.21.
//

import Foundation
struct Player: Codable {
    var name: String
    var score: Int = 0
}

struct Players {
    func getFromStorage() -> [Player]? {
        if let data = UserDefaults.standard.data(forKey: "players") {
            do {
                let decoder = JSONDecoder()
                let players = try decoder.decode([Player].self, from: data)
                return players
            } catch {
                print("Unable to Decode Players (\(error))")
            }
        }
        return nil
    }
    
    func saveToStorage(players: [Player]?){
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(players)
            UserDefaults.standard.set(data, forKey: "players")
        } catch {
            print("Unable to Encode Array of Players (\(error))")
        }
    }
}
