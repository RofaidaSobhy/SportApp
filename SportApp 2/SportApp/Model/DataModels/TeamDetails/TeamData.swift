//
//  TeamData.swift
//  SportsApp
//
//  Created by Macos on 17/05/2025.
//

import Foundation

struct TeamData: Codable {

    var teamName : String?
    var teamLogo : String?
    var players  : [Player]?
 
    enum CodingKeys: String, CodingKey {
        
        case teamName = "team_name"
        case teamLogo = "team_logo"
        case players  = "players"
      
      }
}
