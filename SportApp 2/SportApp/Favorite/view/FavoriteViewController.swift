import UIKit
import SDWebImage

class FavoriteViewController: UIViewController {

    @IBOutlet weak var favTableView: UITableView!
    
    var presenter: FavoritePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favTableView.delegate = self
        favTableView.dataSource = self
        presenter = FavoritePresenter(view: self)
        presenter.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadFavorites), name: Notification.Name("FavoritesUpdated"), object: nil)
    }

    @objc func reloadFavorites() {
        presenter.viewDidLoad()
    }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfFavorites()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FavoriteViewCell else {
            return UITableViewCell()
        }

        let favorite = presenter.favorite(at: indexPath.row)
        cell.myLabel.text = favorite.name
        
        if let logoURL = favorite.logo, let url = URL(string: logoURL) {
            cell.myImage.sd_setImage(with: url, placeholderImage: UIImage(named: "photo"))
        } else {
            cell.myImage.image = UIImage(named: "photo")
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Confirm Deletion", message: "Are you sure you want to delete this item from favorites?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                self.presenter.deleteFavorite(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }))
            present(alert, animated: true, completion: nil)
        }
    }
}

extension FavoriteViewController: FavoriteViewProtocol {
    func reloadData() {
        favTableView.reloadData()
    }
}

