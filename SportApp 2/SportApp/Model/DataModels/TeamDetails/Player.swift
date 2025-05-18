//
//  Player.swift
//  SportsApp
//
//  Created by Macos on 17/05/2025.
//

import Foundation

struct Player: Codable {
    
    var playerImage              : String?
    var playerName               : String?
    var playerType               : String?
    
    enum CodingKeys: String, CodingKey {
        
        case playerImage              = "player_image"
        case playerName               = "player_name"
        case playerType               = "player_type"
    }

}
