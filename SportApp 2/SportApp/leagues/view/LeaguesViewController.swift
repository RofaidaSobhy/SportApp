import UIKit
import SDWebImage
import Alamofire
import SystemConfiguration
import UIKit
import Alamofire
import SDWebImage

class LeaguesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var mySearchBar: UISearchBar!
    @IBOutlet weak var myTable: UITableView!

    let APIKey = "0e577c9dd1e799ad376e436f569ed8f787aa178035c782cc6921d2f58af172ab"
    
    var leagues = [League]()
    var filteredLeagues = [League]()

    override func viewDidLoad() {
        super.viewDidLoad()

        myTable.delegate = self
        myTable.dataSource = self
        mySearchBar.delegate = self
        
        fetchLeagues(for: "football")
    }

    func fetchLeagues(for sport: String) {
        let urlString = "https://apiv2.allsportsapi.com/\(sport)/?met=Leagues&APIkey=\(APIKey)"

        AF.request(urlString).validate().responseDecodable(of: LeaguesResponse.self) { response in
            switch response.result {
            case .success(let data):
                self.leagues = data.data
                self.filteredLeagues = data.data
                DispatchQueue.main.async {
                    self.myTable.reloadData()
                }

            case .failure(let error):
                print("Error:", error)
                DispatchQueue.main.async {
                    self.showAlert(title: "Connection Error", message: "Please check your internet connection or try again later.")
                }
            }
        }
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredLeagues.count
    }
    @objc func toggleFavorite(_ sender: UIButton) {
        let league = filteredLeagues[sender.tag]
        let key = "fav_\(league.id)"
        
        let current = UserDefaults.standard.bool(forKey: key)
        
        // Save or delete from Core Data based on the current status
        if !current {
            CoreDataManager.shared.saveLeague(league)  // Add to Core Data
        } else {
            CoreDataManager.shared.deleteFavorite(Int64(league.id))  // Remove from Core Data
        }
               UserDefaults.standard.set(!current, forKey: key)
        
      myTable.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
        
        if !current {
            if let navigationController = self.navigationController {
                if let favoriteVC = storyboard?.instantiateViewController(withIdentifier: "FavoriteViewController") as? FavoriteViewController {
                    navigationController.pushViewController(favoriteVC, animated: true)
                }
            }
        }
    }



    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? LeaguesTableViewCell else {
            return UITableViewCell()
        }

        let league = filteredLeagues[indexPath.row]
        cell.myLabel.text = league.name

        if let logoURL = league.logo, let url = URL(string: logoURL) {
            cell.myImage.sd_setImage(with: url, placeholderImage: UIImage(named: "photo"))
        } else {
            cell.myImage.image = UIImage(named: "photo")
        }

        let isFavorite = UserDefaults.standard.bool(forKey: "fav_\(league.id)")
        let favImage = isFavorite ? "heart.fill" : "heart"
        cell.favButton.setImage(UIImage(systemName: favImage), for: .normal)
        cell.favButton.tintColor = .orange
        cell.favButton.tag = indexPath.row
        cell.favButton.addTarget(self, action: #selector(toggleFavorite(_:)), for: .touchUpInside)
        return cell
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myTable.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredLeagues = leagues
        } else {
            filteredLeagues = leagues.filter {
                $0.name.lowercased().contains(searchText.lowercased())
            }
        }
        myTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedLeague = filteredLeagues[indexPath.row]

        CoreDataManager.shared.saveLeague(selectedLeague)
        showAlert(title: "Added to Favorites", message: "\(selectedLeague.name) was added.")
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}


//class LeaguesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
//
//    @IBOutlet weak var mySearchBar: UISearchBar!
//    @IBOutlet weak var myTable: UITableView!
//
//    var leagues = [League]()
//    var filteredLeagues = [League]()
//    var isSearching = false
//
//    let APIKey = "0e577c9dd1e799ad376e436f569ed8f787aa178035c782cc6921d2f58af172ab"
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        myTable.delegate = self
//        myTable.dataSource = self
//        mySearchBar.delegate = self
//
//        if isConnectedToInternet() {
//            fetchLeagues(for: "football")
//        } else {
//            showAlert(title: "No Internet", message: "Please check your connection.")
//        }
//    }
//
//    func fetchLeagues(for sport: String) {
//        var urlString = ""
//
//        switch sport.lowercased() {
//        case "football":
//            urlString = "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=\(APIKey)"
//        case "basketball":
//            urlString = "https://apiv2.allsportsapi.com/basketball/?met=Leagues&APIkey=\(APIKey)"
//        case "cricket":
//            urlString = "https://apiv2.allsportsapi.com/cricket/?met=Leagues&APIkey=\(APIKey)"
//        case "tennis":
//            urlString = "https://apiv2.allsportsapi.com/tennis/?met=Leagues&APIkey=\(APIKey)"
//        default:
//            return
//        }
//
//        guard let url = URL(string: urlString) else {
//            print("Invalid URL")
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data, error == nil else {
//                print("Error fetching leagues:", error ?? "Unknown error")
//                return
//            }
//
//            do {
//                
//                let decoder = JSONDecoder()
//                let response = try decoder.decode(LeaguesResponse.self, from: data)
//                self.leagues = response.data
//                self.filteredLeagues = response.data
//
//                DispatchQueue.main.async {
//                    self.myTable.reloadData()
//                }
//            } catch {
//                print("Error decoding:", error)
//            }
//        }.resume()
//    }
//
//    // MARK: - TableView
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return isSearching ? filteredLeagues.count : leagues.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? LeaguesTableViewCell else {
//            return UITableViewCell()
//        }
//
//        let league = isSearching ? filteredLeagues[indexPath.row] : leagues[indexPath.row]
//        cell.myLabel.text = league.name
//
//        if let logoURL = league.logo, let url = URL(string: logoURL) {
//            cell.myImage.sd_setImage(with: url,
//                                     placeholderImage: UIImage(systemName: "photo"),
//                                     options: .continueInBackground,
//                                     completed: nil)
//        } else {
//            cell.myImage.image = UIImage(systemName: "photo")
//        }
//
//        return cell
//    }
//
//    // MARK: - Search
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchText.isEmpty {
//            isSearching = false
//        } else {
//            isSearching = true
//            filteredLeagues = leagues.filter { $0.name.lowercased().contains(searchText.lowercased()) }
//        }
//        myTable.reloadData()
//    }
//
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        isSearching = false
//        searchBar.text = ""
//        myTable.reloadData()
//        searchBar.resignFirstResponder()
//    }
//
//    // MARK: - Internet Check
//
//    func isConnectedToInternet() -> Bool {
//        var zeroAddress = sockaddr_in()
//        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
//        zeroAddress.sin_family = sa_family_t(AF_INET)
//
//        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
//            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
//                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
//            }
//        }) else {
//            return false
//        }
//
//        var flags: SCNetworkReachabilityFlags = []
//        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
//            return false
//        }
//
//        return flags.contains(.reachable) && !flags.contains(.connectionRequired)
//    }
//
//    // MARK: - Alert
//
//    func showAlert(title: String, message: String) {
//        let alert = UIAlertController(title: title,
//                                      message: message,
//                                      preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK",
//                                      style: .default,
//                                      handler: nil))
//        present(alert, animated: true, completion: nil)
//    }
//}

//class LeaguesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//
//    @IBOutlet weak var mySearchBar: UISearchBar!
//    @IBOutlet weak var myTable: UITableView!
//
//    var leagues = [League]()
//    let APIKey = "0e577c9dd1e799ad376e436f569ed8f787aa178035c782cc6921d2f58af172ab"
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        myTable.delegate = self
//        myTable.dataSource = self
//
//        fetchFootballLeagues()
//    }
//
//    func fetchFootballLeagues() {
//        guard let url = URL(string: "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=\(APIKey)") else {
//            print("❌ Invalid URL")
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data, error == nil else {
//                print("❌ Error fetching leagues:", error ?? "Unknown error")
//                return
//            }
//
//            // Debug raw JSON
//            if let jsonString = String(data: data, encoding: .utf8) {
//                print("✅ Received JSON:\n\(jsonString)")
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                let response = try decoder.decode(LeaguesResponse.self, from: data)
//                self.leagues = response.data
//
//                print("✅ Fetched leagues count: \(self.leagues.count)")
//                DispatchQueue.main.async {
//                    self.myTable.reloadData()
//                }
//            } catch {
//                print("❌ Error decoding JSON:", error)
//            }
//        }.resume()
//    }
//
//    // MARK: - TableView Methods
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("📌 Number of rows: \(leagues.count)")
//        return leagues.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? LeaguesTableViewCell else {
//            return UITableViewCell()
//        }
//
//        let league = leagues[indexPath.row]
//        cell.myLabel.text = league.name
//
//        print("🖼️ Loading image for league: \(league.name)")
//        if let logoURL = league.logo, let url = URL(string: logoURL) {
//            cell.myImage.sd_setImage(with: url,
//                                     placeholderImage: UIImage(systemName: "photo"),
//                                     options: .continueInBackground,
//                                     completed: nil)
//        } else {
//            cell.myImage.image = UIImage(systemName: "photo")
//        }
//
//
//        return cell
//    }
//}
//

//class LeaguesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//
//    @IBOutlet weak var mySearchBar: UISearchBar!
//    @IBOutlet weak var myTable: UITableView!
//
//    var selectedSport: String?
//    var leagues = [League]()
//    let APIKey = "0e577c9dd1e799ad376e436f569ed8f787aa178035c782cc6921d2f58af172ab"
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        myTable.delegate = self
//        myTable.dataSource = self
//
//        if let sport = selectedSport {
//            fetchLeagues(for: sport)
//        }
//    }
//
//    func fetchLeagues(for sport: String) {
//        // var urlString = "football"
//        //
//        // switch sport.lowercased() {
//        // case "football":
//        //     urlString = "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=\(APIKey)"
//        // case "basketball":
//        //     urlString = "https://apiv2.allsportsapi.com/basketball/?met=Leagues&APIkey=\(APIKey)"
//        // case "cricket":
//        //     urlString = "https://apiv2.allsportsapi.com/cricket/?met=Leagues&APIkey=\(APIKey)"
//        // case "tennis":
//        //     urlString = "https://apiv2.allsportsapi.com/tennis/?met=Leagues&APIkey=\(APIKey)"
//        // default:
//        //     return
//        // }
//
//        guard let url = URL(string:"https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=\(APIKey)") else {
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data, error == nil else {
//                print("Error fetching leagues:", error ?? "Unknown error")
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                let response = try decoder.decode(LeaguesResponse.self, from: data)
//                self.leagues = response.data
//                print("Fetched leagues: \(self.leagues.count)")
//                DispatchQueue.main.async {
//                    self.myTable.reloadData()
//                }
//            } catch {
//                print("Error decoding:", error)
//            }
//        }.resume()
//    }
//
//    // MARK: - Table View
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return leagues.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? LeaguesTableViewCell else {
//            return UITableViewCell()
//        }
//
//        let league = leagues[indexPath.row]
//        cell.myLabel.text = league.name
//
//        cell.myImage.sd_setImage(with: URL(string: league.logo),
//                                 placeholderImage: UIImage(systemName: "photo"),
//                                 options: .continueInBackground,
//                                 completed: nil)
//
//        return cell
//    }
//
//    //
//    //    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//    //        if searchText.isEmpty {
//    //            filteredLeagues = leagues
//    //        } else {
//    //            filteredLeagues = leagues.filter {
//    //                $0.name.lowercased().contains(searchText.lowercased())
//    //            }
//    //        }
//    //        myTable.reloadData()
//    //    }
//}
//
