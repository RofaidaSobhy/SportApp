//
//  CricketMatch.swift
//  SportsApp
//
//  Created by Macos on 18/05/2025.
//

import Foundation

struct CricketMatch: Codable {

  var eventDateStart       : String?    
  var eventTime            : String?
  var eventHomeTeam        : String?
  var eventAwayTeam        : String?
  var eventHomeFinalResult : String?
  var eventAwayFinalResult : String?
    
  var eventHomeTeamLogo    : String?
  var eventAwayTeamLogo    : String?
 
  enum CodingKeys: String, CodingKey {

    case eventDateStart       = "event_date_start"
    case eventTime            = "event_time"
    case eventHomeTeam        = "event_home_team"
    case eventAwayTeam        = "event_away_team"
   
    case eventHomeFinalResult = "event_home_final_result"
    case eventAwayFinalResult = "event_away_final_result"
   
    case eventHomeTeamLogo    = "event_home_team_logo"
    case eventAwayTeamLogo    = "event_away_team_logo"
    
  
  }

 

}
