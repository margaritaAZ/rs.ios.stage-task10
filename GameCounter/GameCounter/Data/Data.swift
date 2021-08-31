//
//  Player.swift
//  GameCounter
//
//  Created by Маргарита Жучик on 27.08.21.
//

import Foundation
import UIKit

struct Player: Codable {
    var name: String
    var score: Int = 0
    var turns: [Int]?

    mutating func updateScore() {
        score = 0
        guard let turnsArray = turns else {
            return
        }
        for turn in turnsArray {
            score += turn
        }
    }
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

struct CollectionViewConstants {
    static let leftDistanceToView: CGFloat = 40
    static let rightDistanceToView: CGFloat = 40
    static let minimumLineSpacing: CGFloat = 20
    static let itemWidth = (UIScreen.main.bounds.width - CollectionViewConstants.leftDistanceToView - CollectionViewConstants.rightDistanceToView - CollectionViewConstants.minimumLineSpacing)
}

struct GameProcessConstants {
    static let timerToTitle: CGFloat = {
        return UIScreen.main.bounds.height < 700 ? 20 : 40
    }()
    static let playersToTimer: CGFloat = {
        return UIScreen.main.bounds.height < 700 ? 20 : 30
    }()
    static let bigScoreButtonToPlayers: CGFloat = {
        return UIScreen.main.bounds.height < 700 ? 20 : 30
    }()
    static let smallButtonsToBigButton: CGFloat = 20
    static let playersLettersToSmallButtons: CGFloat = 20
    static let playersLettersToBottom: CGFloat = 30
    static let plusOneButtonSize: CGFloat = {
        switch UIScreen.main.bounds.height {
        case (0..<600):
            return 60
        case (600..<700):
            return 70
        default:
            return 90
        }
    }()
    static let scoreButtonsSize: CGFloat = {
        return UIScreen.main.bounds.height < 600 ? 47 : 55
    }()
    static let scoreLabelFontSize: CGFloat = {
        return UIScreen.main.bounds.height < 700 ? 70 : 100
    }()
}
