
import UIKit
import SDWebImage

import Lottie

class LeaguesViewController: UIViewController {
    var animationView: LottieAnimationView?

    @IBOutlet weak var mySearchBar: UISearchBar!
    @IBOutlet weak var myTable: UITableView!

    var selectedSport: String?
    var presenter = LeaguesPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView = LottieAnimationView(name: "loading")
        animationView?.frame = view.bounds
        animationView?.contentMode = .scaleAspectFit
        animationView?.loopMode = .loop
        animationView?.animationSpeed = 1.0
        
        if let animation = animationView {
            view.addSubview(animation)
            animation.play()
        }

        myTable.delegate = self
        myTable.dataSource = self
        mySearchBar.delegate = self

        presenter.attachView(self)

        if let sport = selectedSport {
            presenter.getLeagues(for: sport.lowercased())
        }
    }


    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
}

extension LeaguesViewController: LeaguesViewProtocol {
    func showLeagues(_ leagues: [League]) {
        animationView?.stop()
        animationView?.removeFromSuperview()
        myTable.reloadData()
    }

    func showError(_ message: String) {
        animationView?.stop()
        animationView?.removeFromSuperview()
        showAlert(title: "Connection Error", message: message)
    }

    func reloadRow(at index: Int) {
        myTable.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }

    func showSuccessMessage(_ message: String) {
        showAlert(title: "Added to Favorites", message: message)
    }
}

extension LeaguesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfLeagues()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? LeaguesTableViewCell else {
            return UITableViewCell()
        }

        if let league = presenter.getLeague(at: indexPath.row) {
            cell.myLabel.text = league.name

            if let logoURL = league.logo, let url = URL(string: logoURL) {
                cell.myImage.sd_setImage(with: url, placeholderImage: UIImage(named: "photo"))
            } else {
                cell.myImage.image = UIImage(named: "photo")
            }

            let favImage = presenter.isFavorite(league) ? "heart.fill" : "heart"
            cell.favButton.setImage(UIImage(systemName: favImage), for: .normal)
            cell.favButton.tintColor = .orange
            cell.favButton.tag = indexPath.row
            cell.favButton.addTarget(self, action: #selector(toggleFavorite(_:)), for: .touchUpInside)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectLeague(at: indexPath.row)
    }

    @objc func toggleFavorite(_ sender: UIButton) {
        presenter.toggleFavorite(at: sender.tag)
    }
    
}

extension LeaguesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.filterLeagues(with: searchText)
    }
}
