//
//  CoreDataManager.swift
//  SportApp
//
//  Created by Ayatullah Salah on 13/05/2025.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func saveLeague(_ league: League , sportType: String) {
        let fav = FavoriteLeague(context: context)
        fav.id = Int64(league.id)
        fav.name = league.name
        fav.logo = league.logo
        fav.sportType = sportType
        

        do {
            try context.save()
            print("Saved to favorites")
        } catch {
            print("Failed saving: \(error)")
        }
    }

    func fetchFavorites() -> [FavoriteLeague] {
        let request: NSFetchRequest<FavoriteLeague> = FavoriteLeague.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Fetch failed")
            return []
        }
    }

    func deleteFavorite(_ id: Int64) {
        let request: NSFetchRequest<FavoriteLeague> = FavoriteLeague.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        do {
            let results = try context.fetch(request)
            for obj in results {
                context.delete(obj)
            }
            try context.save()
        } catch {
            print("Error deleting: \(error)")
        }
    }
}
