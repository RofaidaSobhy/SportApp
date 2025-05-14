import UIKit
import SDWebImage

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var favTableView: UITableView!
    var favorites: [FavoriteLeague] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        favTableView.delegate = self
        favTableView.dataSource = self
        
        // Fetch favorites from Core Data
        favorites = CoreDataManager.shared.fetchFavorites()
        favTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let fav = favorites[indexPath.row]
        cell.textLabel?.text = fav.name
        
        // Set image to circular and increase its size
        let imageView = cell.imageView
        if let logo = fav.logo, let url = URL(string: logo) {
            imageView?.sd_setImage(with: url, placeholderImage: UIImage(systemName: "photo"))
        } else {
            imageView?.image = UIImage(systemName: "photo")
        }
        
        // Make the image circular and increase size
        imageView?.layer.cornerRadius = 30 // Adjust this value for the desired circular image size
        imageView?.clipsToBounds = true
        imageView?.contentMode = .scaleAspectFill
        
        // Set the background of the cell with rounded corners and orange color
        cell.contentView.backgroundColor = UIColor.orange.withAlphaComponent(0.3)
        cell.contentView.layer.cornerRadius = 12
        cell.contentView.layer.masksToBounds = true
        
        return cell
    }

    // Set height for rows (to increase spacing between cells)
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100  // This will increase the row height to 100
    }

    // Swipe to delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let id = favorites[indexPath.row].id
            CoreDataManager.shared.deleteFavorite(id)
            favorites.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}


