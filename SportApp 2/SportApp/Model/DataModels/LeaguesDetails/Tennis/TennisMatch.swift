//
//  TennisMatch.swift
//  SportsApp
//
//  Created by Macos on 18/05/2025.
//

import Foundation
struct TennisMatch: Codable {
    
    var eventDate       : String?
    var eventTime            : String?
    var eventFirstPlayer        : String?
    var eventSecondPlayer        : String?
    var eventFinalResult : String?
    
    var eventFirstPlayerLogo    : String?
    var eventSecondPlayerLogo    : String?
    
    enum CodingKeys: String, CodingKey {
        
        case eventDate       = "event_date"
        case eventTime            = "event_time"
        case eventFirstPlayer        = "event_first_player"
        case eventSecondPlayer        = "event_second_player"
        
        case eventFinalResult = "event_final_result"
        
        case eventFirstPlayerLogo    = "event_first_player_logo"
        case eventSecondPlayerLogo    = "event_second_player_logo"
        
        
    }
}
