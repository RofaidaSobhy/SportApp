//
//  BasketballMatch.swift
//  SportsApp
//
//  Created by Macos on 18/05/2025.
//

import Foundation

struct BasketballMatch: Codable {
    
    var eventDate       : String?
    var eventTime            : String?
    var eventHomeTeam        : String?
    var eventAwayTeam        : String?
    var eventFinalResult : String?
    
    var eventHomeTeamLogo    : String?
    var eventAwayTeamLogo    : String?
    
    enum CodingKeys: String, CodingKey {
        
        case eventDate       = "event_date"
        case eventTime            = "event_time"
        case eventHomeTeam        = "event_home_team"
        case eventAwayTeam        = "event_away_team"
        
        case eventFinalResult = "event_final_result"
        
        case eventHomeTeamLogo    = "event_home_team_logo"
        case eventAwayTeamLogo    = "event_away_team_logo"
        
        
    }
}
