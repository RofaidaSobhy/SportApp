//
//  Network.swift
//  SportApp
//
//  Created by Ayatullah Salah on 15/05/2025.
//

import Foundation
import Alamofire

protocol NetworkProtocol {
    static func fetchLeagues(for sport: String, completion: @escaping ([League]) -> Void)
}

class NetworkService: NetworkProtocol {
    static let APIKey = "0e577c9dd1e799ad376e436f569ed8f787aa178035c782cc6921d2f58af172ab"

    static func fetchLeagues(for sport: String, completion: @escaping ([League]) -> Void) {
        let urlString = "https://apiv2.allsportsapi.com/\(sport)/?met=Leagues&APIkey=\(APIKey)"

        AF.request(urlString).validate().responseDecodable(of: LeaguesResponse.self) { response in
            switch response.result {
            case .success(let data):
                completion(data.data)
            case .failure(let error):
                print("Error fetching leagues:", error)
                completion([])
            }
        }
    }
}

