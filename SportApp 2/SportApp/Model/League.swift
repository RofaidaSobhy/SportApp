//
//  League.swift
//  SportApp
//
//  Created by Ayatullah Salah on 12/05/2025.
//

struct League: Codable {
    let name: String
    let logo: String?

    enum CodingKeys: String, CodingKey {
        case name = "league_name"
        case logo = "league_logo"
    }
}

struct LeaguesResponse: Codable {
    let data: [League]

    enum CodingKeys: String, CodingKey {
        case data = "result"
    }
}

