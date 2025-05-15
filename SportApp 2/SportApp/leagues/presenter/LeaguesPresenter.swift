//
//  FavPresenter.swift
//  SportApp
//
//  Created by Ayatullah Salah on 15/05/2025.
//
import Foundation
protocol LeaguesViewProtocol: AnyObject {
    func showLeagues(_ leagues: [League])
    func showError(_ message: String)
    func reloadRow(at index: Int)
    func showSuccessMessage(_ message: String)
}

class LeaguesPresenter {
    weak var view: LeaguesViewProtocol?
    private var allLeagues = [League]()
    
    func attachView(_ view: LeaguesViewProtocol) {
        self.view = view
    }
    
    func getLeagues(for sport: String) {
        NetworkService.fetchLeagues(for: sport) { [weak self] leagues in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if leagues.isEmpty {
                    self.view?.showError("Please check your internet connection or try again later.")
                } else {
                    self.allLeagues = leagues
                    self.view?.showLeagues(leagues)
                }
            }
        }
    }
    
    func filterLeagues(with query: String) {
        if query.isEmpty {
            view?.showLeagues(allLeagues)
        } else {
            let filtered = allLeagues.filter { $0.name.lowercased().contains(query.lowercased()) }
            view?.showLeagues(filtered)
        }
    }

    func toggleFavorite(at index: Int) {
        guard index < allLeagues.count else { return }
        let league = allLeagues[index]
        let key = "fav_\(league.id)"
        let current = UserDefaults.standard.bool(forKey: key)

        if !current {
            CoreDataManager.shared.saveLeague(league)
        } else {
            CoreDataManager.shared.deleteFavorite(Int64(league.id))
        }
        UserDefaults.standard.set(!current, forKey: key)

        view?.reloadRow(at: index)
        NotificationCenter.default.post(name: Notification.Name("FavoritesUpdated"), object: nil)
    }

    func didSelectLeague(at index: Int) {
        guard index < allLeagues.count else { return }
        let league = allLeagues[index]
        CoreDataManager.shared.saveLeague(league)
        view?.showSuccessMessage("\(league.name) was added.")
    }

    func isFavorite(_ league: League) -> Bool {
        return UserDefaults.standard.bool(forKey: "fav_\(league.id)")
    }

    func getLeague(at index: Int) -> League? {
        guard index < allLeagues.count else { return nil }
        return allLeagues[index]
    }

    func numberOfLeagues() -> Int {
        return allLeagues.count
    }
}
