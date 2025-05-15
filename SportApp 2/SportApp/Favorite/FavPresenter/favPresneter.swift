//
//  favPresneter.swift
//  SportApp
//
//  Created by Ayatullah Salah on 15/05/2025.
//

import Foundation

protocol FavoriteViewProtocol: AnyObject {
    func reloadData()
}

protocol FavoritePresenterProtocol {
    func viewDidLoad()
    func numberOfFavorites() -> Int
    func favorite(at index: Int) -> FavoriteLeague
    func deleteFavorite(at index: Int)
}

class FavoritePresenter: FavoritePresenterProtocol {

    private weak var view: FavoriteViewProtocol?
    private var favorites: [FavoriteLeague] = []

    init(view: FavoriteViewProtocol) {
        self.view = view
    }

    func viewDidLoad() {
        favorites = CoreDataManager.shared.fetchFavorites()
        view?.reloadData()
    }

    func numberOfFavorites() -> Int {
        return favorites.count
    }

    func favorite(at index: Int) -> FavoriteLeague {
        return favorites[index]
    }

    func deleteFavorite(at index: Int) {
        let id = favorites[index].id
        CoreDataManager.shared.deleteFavorite(id)
        UserDefaults.standard.set(false, forKey: "fav_\(id)")
        favorites.remove(at: index)
    }
}
