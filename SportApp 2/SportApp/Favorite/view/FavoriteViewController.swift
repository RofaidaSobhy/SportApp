import UIKit
import SDWebImage

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var favTableView: UITableView!
    var favorites: [FavoriteLeague] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        favTableView.delegate = self
        favTableView.dataSource = self
        
        favorites = CoreDataManager.shared.fetchFavorites()
        favTableView.reloadData()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadFavorites), name: Notification.Name("FavoritesUpdated"), object: nil)

    }
    @objc func reloadFavorites() {
        favorites = CoreDataManager.shared.fetchFavorites()
        favTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FavoriteViewCell else {
            return UITableViewCell()
        }
        let fav = favorites[indexPath.row]

        cell.myLabel.text = fav.name
        

        if let logoURL = fav.logo, let url = URL(string: logoURL) {
            cell.myImage.sd_setImage(with: url, placeholderImage: UIImage(named: "photo"))
        } else {
            cell.myImage.image = UIImage(named: "photo")
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100  // This will increase the row height to 100
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Confirm Deletion", message: "Are you sure you want to delete this item from favorites?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                let id = self.favorites[indexPath.row].id

                CoreDataManager.shared.deleteFavorite(id)

                UserDefaults.standard.set(false, forKey: "fav_\(id)")

                self.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }))
            
            present(alert, animated: true, completion: nil)
        }
    }

}


