//
//  LeaguesDetailsPresenter.swift
//  SportsApp
//
//  Created by Macos on 16/05/2025.
//

import Foundation

class LeaguesDetailsPresenter {
    weak var vc: LeaguesDetailsCollectionViewController?
    
    func attachView(myViewController: LeaguesDetailsCollectionViewController) {
        vc = myViewController
    }
    // MARK: - Football
    func getFootballDataFromModel(
        sport: SportType,
        method: APIMethod,
        leagueId: String,
        fromDate: String,
        toDate: String
    ) {
        NetworkService.fetchLeaguesDetailsFootballData(
            sport: sport,
            method: method,
            leagueId: leagueId,
            fromDate: fromDate,
            toDate: toDate
        ) { [weak self] res in
            guard let result = res else { return }
            DispatchQueue.main.async {
                self?.vc?.renderLeaguesDetailsFootballToView(result: result)
            }
        }
    }
    
    // MARK: - Cricket
    func getCricketDataFromModel(
        sport: SportType,
        method: APIMethod,
        leagueId: String,
        fromDate: String,
        toDate: String
    ) {
        NetworkService.fetchLeaguesDetailsCricketData(
            sport: sport,
            method: method,
            leagueId: leagueId,
            fromDate: fromDate,
            toDate: toDate
        ) { [weak self] res in
            guard let result = res else { return }
            DispatchQueue.main.async {
                self?.vc?.renderLeaguesDetailsCricketToView(result: result)
            }
        }
    }
    
    // MARK: - Basketball
    func getBasketballDataFromModel(
        sport: SportType,
        method: APIMethod,
        leagueId: String,
        fromDate: String,
        toDate: String
    ) {
        NetworkService.fetchLeaguesDetailsBasketballData(
            sport: sport,
            method: method,
            leagueId: leagueId,
            fromDate: fromDate,
            toDate: toDate
        ) { [weak self] res in
            guard let result = res else { return }
            DispatchQueue.main.async {
                self?.vc?.hideLoadingAnimation()
                self?.vc?.renderLeaguesDetailsBasketballToView(result: result)
            }
        }
    }
    
    // MARK: - Tennis
    func getTennisDataFromModel(
        sport: SportType,
        method: APIMethod,
        leagueId: String,
        fromDate: String,
        toDate: String
    ) {
        NetworkService.fetchLeaguesDetailsTennisData(
            sport: sport,
            method: method,
            leagueId: leagueId,
            fromDate: fromDate,
            toDate: toDate
        ) { [weak self] res in
            guard let result = res else { return }
            DispatchQueue.main.async {
                self?.vc?.renderLeaguesDetailsTennisToView(result: result)
            }
        }
    }
    
    // MARK: - TeamData
    func getTeamDataFromModel(
        sport: SportType,
        method: APIMethod,
        leagueId: String
    ) {
        NetworkService.fetchTeamDetailsData(
            sport: sport,
            method: method,
            leagueId: leagueId
        ) { [weak self] res in
            guard let result = res else { return }
            DispatchQueue.main.async {
                self?.vc?.renderTeamDetailsToView(result: result)
            }
        }
    }
}
