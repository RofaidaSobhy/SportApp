//
//  Result.swift
//  SportsApp
//
//  Created by Macos on 16/05/2025.
//

import Foundation

struct FootballMatch: Codable {


  var eventDate           : String?
  var eventTime           : String?
  var eventHomeTeam       : String?
  var homeTeamKey         : Int?
  var eventAwayTeam       : String?
  var awayTeamKey         : Int?
  var eventFinalResult    : String?

  var homeTeamLogo        : String?
  var awayTeamLogo        : String?


    enum CodingKeys: String, CodingKey {

      
       case eventDate           = "event_date"
       case eventTime           = "event_time"
       case eventHomeTeam       = "event_home_team"
       case homeTeamKey         = "home_team_key"
       case eventAwayTeam       = "event_away_team"
       case awayTeamKey         = "away_team_key"
       case eventFinalResult    = "event_final_result"
      
       case homeTeamLogo        = "home_team_logo"
       case awayTeamLogo        = "away_team_logo"
      
     
     }
  
}
