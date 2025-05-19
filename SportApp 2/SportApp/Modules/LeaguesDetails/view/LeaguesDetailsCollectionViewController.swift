//
//  LeaguesDetailsCollectionViewController.swift
//  SportsApp
//
//  Created by Macos on 14/05/2025.
//

import UIKit
import Kingfisher
import Lottie

class LeaguesDetailsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var loadingAnimationView: LottieAnimationView?

    let sectionTitles = ["Upcoming Events", "Latest Events", "Teams"]
    
    var upComingFootballMatches : [FootballMatch]?
    var latestFootballMatches : [FootballMatch]?
    
    var upComingCricketMatches : [CricketMatch]?
    var latestCricketMatches : [CricketMatch]?
    
    var upComingBasketballMatches : [BasketballMatch]?
    var latestBasketballMatches : [BasketballMatch]?
    
    var upComingTennisMatches : [TennisMatch]?
    var latestTennisMatches : [TennisMatch]?
    
    var isFavorite: Bool = false

    
    
    
    var numUpComingMatches : Int?
    var numLatestMatches : Int?
    var numTeams : Int?
    
    var allTeams : [TeamData]?
    
    let leaguesDetailsPresenter = LeaguesDetailsPresenter()

    var leagueId : String?
    var leagueName : String?
    var sport : SportType?
    override func viewDidLoad() {
        super.viewDidLoad()
//        
//        leagueId = "5"
//        leagueName = "leagueName"
//        sport = .football
        if let id = Int64(leagueId ?? "0") {
            let favorites = CoreDataManager.shared.fetchFavorites()
            isFavorite = favorites.contains(where: { $0.id == id })
            updateFavoriteButton()
        }
        
        showLoadingAnimation()
        leaguesDetailsPresenter.attachView(myViewController: self)
        
        switch sport {
        case .football :
            
            leaguesDetailsPresenter.getFootballDataFromModel(
                sport: sport ?? .football,
                method: .fixtures,
                leagueId: leagueId ?? "0",
                fromDate: DateUtils.getFromDateOneYearAgo(),
                toDate: DateUtils.getToDateOneYearAhead()
            )
            
            leaguesDetailsPresenter.getTeamDataFromModel(
                sport: sport ?? .football,
                method: .teams,
                leagueId: leagueId ?? "0"
                
            )
            
            
        case .cricket :
            
            leaguesDetailsPresenter.getCricketDataFromModel(
                sport: sport ?? .cricket,
                method: .fixtures,
                leagueId: leagueId ?? "0",
                fromDate: "2022-03-13",
                toDate: "2026-03-13"
            )
            
            leaguesDetailsPresenter.getTeamDataFromModel(
                sport: sport ?? .cricket,
                method: .teams,
                leagueId: leagueId ?? "0"
                
            )
            
    
        case .basketball:
            
            leaguesDetailsPresenter.getBasketballDataFromModel(
                sport: sport ?? .cricket,
                method: .fixtures,
                leagueId: leagueId ?? "0",
                fromDate: "2024-05-23",
                toDate: "2026-03-13"
            )
            
            leaguesDetailsPresenter.getTeamDataFromModel(
                sport: sport ?? .basketball,
                method: .teams,
                leagueId: leagueId ?? "0"
                
            )
        default :
           
            leaguesDetailsPresenter.getTennisDataFromModel(
                sport: sport ?? .tennis,
                method: .fixtures,
                leagueId: leagueId ?? "0",
                fromDate: "2022-03-13",
                toDate: "2026-03-13"
            )
            
            leaguesDetailsPresenter.getTeamDataFromModel(
                sport: sport ?? .tennis,
                method: .teams,
                leagueId: leagueId ?? "0"
                
            )

        }
        
        
        
        setupNavigationBar()
        registerCellsAndHeaders()
        collectionView.setCollectionViewLayout(configureCompositionalLayout(), animated: true)
    }
    func showLoadingAnimation() {
        loadingAnimationView = LottieAnimationView(name: "loading")
        loadingAnimationView?.frame = view.bounds
        loadingAnimationView?.contentMode = .scaleAspectFit
        loadingAnimationView?.loopMode = .loop
        loadingAnimationView?.play()
        
        if let animationView = loadingAnimationView {
            view.addSubview(animationView)
            view.bringSubviewToFront(animationView)
        }
    }
    func hideLoadingAnimation() {
        loadingAnimationView?.stop()
        loadingAnimationView?.removeFromSuperview()
        loadingAnimationView = nil
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionTitles.count
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        calcNumOfCells()
        switch section{
        case 0 :
            return numUpComingMatches ?? 0

        case 1 :
            return numLatestMatches ?? 0

           
        default:
            return numTeams ?? 0
        }
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
       
            let cell = dequeueCell(ofType: UpComingEvensCollectionViewCell.self, for: indexPath)
            
            
            
            
            switch sport {
            
            case .football :
                
                
                cell.nameTeam1.text = upComingFootballMatches?[indexPath.row].eventHomeTeam
                cell.nameTeam2.text = upComingFootballMatches?[indexPath.row].eventAwayTeam
                
                cell.matchDate.text = upComingFootballMatches?[indexPath.row].eventDate
                
                cell.matchTime.text = upComingFootballMatches?[indexPath.row].eventTime
                
                if let urlHomeTeamLogo = URL(string: upComingFootballMatches?[indexPath.row].homeTeamLogo ?? ""){
                    cell.logoTeam1.kf.setImage(with: urlHomeTeamLogo ,placeholder: UIImage(named: "1"))
                }
                if let urlAwayTeamLogo = URL(string: upComingFootballMatches?[indexPath.row].awayTeamLogo ?? ""){
                    cell.logoTeam2.kf.setImage(with: urlAwayTeamLogo ,placeholder: UIImage(named: "1"))
                }
                
            case .cricket :
                cell.nameTeam1.text = upComingCricketMatches?[indexPath.row].eventHomeTeam
                cell.nameTeam2.text = upComingCricketMatches?[indexPath.row].eventAwayTeam
                
                cell.matchDate.text = upComingCricketMatches?[indexPath.row].eventDateStart
                
                cell.matchTime.text = upComingCricketMatches?[indexPath.row].eventTime
                
                if let urlHomeTeamLogo = URL(string: upComingCricketMatches?[indexPath.row].eventHomeTeamLogo ?? ""){
                    cell.logoTeam1.kf.setImage(with: urlHomeTeamLogo ,placeholder: UIImage(named: "1"))
                }
                if let urlAwayTeamLogo = URL(string: upComingCricketMatches?[indexPath.row].eventAwayTeamLogo ?? ""){
                    cell.logoTeam2.kf.setImage(with: urlAwayTeamLogo ,placeholder: UIImage(named: "1"))
                }
            case .basketball :
                cell.nameTeam1.text = upComingBasketballMatches?[indexPath.row].eventHomeTeam
                cell.nameTeam2.text = upComingBasketballMatches?[indexPath.row].eventAwayTeam
                
                cell.matchDate.text = upComingBasketballMatches?[indexPath.row].eventDate
                
                cell.matchTime.text = upComingBasketballMatches?[indexPath.row].eventTime
                
                if let urlHomeTeamLogo = URL(string: upComingBasketballMatches?[indexPath.row].eventHomeTeamLogo ?? ""){
                    cell.logoTeam1.kf.setImage(with: urlHomeTeamLogo ,placeholder: UIImage(named: "dummyPlayer"))
                }
                if let urlAwayTeamLogo = URL(string: upComingBasketballMatches?[indexPath.row].eventAwayTeamLogo ?? ""){
                    cell.logoTeam2.kf.setImage(with: urlAwayTeamLogo ,placeholder: UIImage(named: "dummyPlayer"))
                }
            default :
                cell.nameTeam1.text = upComingTennisMatches?[indexPath.row].eventFirstPlayer
                cell.nameTeam2.text = upComingTennisMatches?[indexPath.row].eventSecondPlayer
                
                cell.matchDate.text = upComingTennisMatches?[indexPath.row].eventDate
                
                cell.matchTime.text = upComingTennisMatches?[indexPath.row].eventTime
                
                if let urlHomeTeamLogo = URL(string: upComingTennisMatches?[indexPath.row].eventFirstPlayerLogo ?? ""){
                    cell.logoTeam1.kf.setImage(with: urlHomeTeamLogo ,placeholder: UIImage(named: "dummyPlayer"))
                }
                if let urlAwayTeamLogo = URL(string: upComingTennisMatches?[indexPath.row].eventSecondPlayerLogo ?? ""){
                    cell.logoTeam2.kf.setImage(with: urlAwayTeamLogo ,placeholder: UIImage(named: "dummyPlayer"))
                }
            }
            
            
            return cell
        case 1:
            
            let cell = dequeueCell(ofType: LatestEventsCollectionViewCell.self, for: indexPath)
            
            
            switch sport {
            case .football :
                
                cell.nameTeam1.text = latestFootballMatches?[indexPath.row].eventHomeTeam
                cell.nameTeam2.text = latestFootballMatches?[indexPath.row].eventAwayTeam
                
                cell.matchDate.text = latestFootballMatches?[indexPath.row].eventDate
                
                cell.matchTime.text = latestFootballMatches?[indexPath.row].eventTime
                
                cell.score.text = latestFootballMatches?[indexPath.row].eventFinalResult
                
                if let urlHomeTeamLogo = URL(string: latestFootballMatches?[indexPath.row].homeTeamLogo ?? ""){
                    cell.logoTeam1.kf.setImage(with: urlHomeTeamLogo ,placeholder: UIImage(named: "1"))
                }
                if let urlAwayTeamLogo = URL(string: latestFootballMatches?[indexPath.row].awayTeamLogo ?? ""){
                    cell.logoTeam2.kf.setImage(with: urlAwayTeamLogo ,placeholder: UIImage(named: "1"))
                }
                
            case .cricket :
                cell.nameTeam1.text = latestCricketMatches?[indexPath.row].eventHomeTeam
                cell.nameTeam2.text = latestCricketMatches?[indexPath.row].eventAwayTeam
                
                cell.matchDate.text = latestCricketMatches?[indexPath.row].eventDateStart
                
                cell.matchTime.text = latestCricketMatches?[indexPath.row].eventTime
                
                cell.score.text = (latestCricketMatches?[indexPath.row].eventHomeFinalResult ?? "")
                + " - " + (latestCricketMatches?[indexPath.row].eventAwayFinalResult ?? "")
                
                if let urlHomeTeamLogo = URL(string: latestCricketMatches?[indexPath.row].eventHomeTeamLogo ?? ""){
                    cell.logoTeam1.kf.setImage(with: urlHomeTeamLogo ,placeholder: UIImage(named: "1"))
                }
                if let urlAwayTeamLogo = URL(string: latestCricketMatches?[indexPath.row].eventAwayTeamLogo ?? ""){
                    cell.logoTeam2.kf.setImage(with: urlAwayTeamLogo ,placeholder: UIImage(named: "1"))
                }
            case .basketball :
                cell.nameTeam1.text = latestBasketballMatches?[indexPath.row].eventHomeTeam
                cell.nameTeam2.text = latestBasketballMatches?[indexPath.row].eventAwayTeam
                
                cell.matchDate.text = latestBasketballMatches?[indexPath.row].eventDate
                
                cell.matchTime.text = latestBasketballMatches?[indexPath.row].eventTime
                
                cell.score.text = latestBasketballMatches?[indexPath.row].eventFinalResult
                
                if let urlHomeTeamLogo = URL(string: latestBasketballMatches?[indexPath.row].eventHomeTeamLogo ?? ""){
                    cell.logoTeam1.kf.setImage(with: urlHomeTeamLogo ,placeholder: UIImage(named: "dummyPlayer"))
                }
                if let urlAwayTeamLogo = URL(string: latestBasketballMatches?[indexPath.row].eventAwayTeamLogo ?? ""){
                    cell.logoTeam2.kf.setImage(with: urlAwayTeamLogo ,placeholder: UIImage(named: "dummyPlayer"))
                }

            default :
                cell.nameTeam1.text = latestTennisMatches?[indexPath.row].eventFirstPlayer
                cell.nameTeam2.text = latestTennisMatches?[indexPath.row].eventSecondPlayer
                
                cell.matchDate.text = latestTennisMatches?[indexPath.row].eventDate
                
                cell.matchTime.text = latestTennisMatches?[indexPath.row].eventTime
                
                cell.score.text = latestTennisMatches?[indexPath.row].eventFinalResult
                
                if let urlHomeTeamLogo = URL(string: latestTennisMatches?[indexPath.row].eventFirstPlayerLogo ?? ""){
                    cell.logoTeam1.kf.setImage(with: urlHomeTeamLogo ,placeholder: UIImage(named: "dummyPlayer"))
                }
                if let urlAwayTeamLogo = URL(string: latestTennisMatches?[indexPath.row].eventSecondPlayer ?? ""){
                    cell.logoTeam2.kf.setImage(with: urlAwayTeamLogo ,placeholder: UIImage(named: "dummyPlayer"))
                }
                
            }
          
            return cell
        default:
            let cell =  dequeueCell(ofType: TeamCollectionViewCell.self, for: indexPath)
            cell.teamName.text = allTeams?[indexPath.row].teamName
            
            if let urlTeamLogo = URL(string: allTeams?[indexPath.row].teamLogo ?? ""){
                cell.teamImage.kf.setImage(with: urlTeamLogo ,placeholder: UIImage(named: "1"))
            }
            return cell
        }
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }

        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SimpleHeaderView.reuseIdentifier, for: indexPath) as! SimpleHeaderView
        header.configure(text: sectionTitles[indexPath.section])
        return header
    }
    func setupNavigationBar() {
        updateFavoriteButton()
    }
    func updateFavoriteButton() {
        let imageName = isFavorite ? "heart.fill" : "heart"
        let favoriteButton = UIBarButtonItem(
            image: UIImage(systemName: imageName),
            style: .plain,
            target: self,
            action: #selector(favoriteButtonTapped)
        )
        favoriteButton.tintColor = UIColor.orange

        navigationItem.rightBarButtonItem = favoriteButton
    }
    @objc func favoriteButtonTapped() {
        guard let leagueId = leagueId, let id = Int64(leagueId), let leagueName = leagueName, let sport = sport else { return }

        if isFavorite {
            CoreDataManager.shared.deleteFavorite(id)
            isFavorite = false
            print("Removed from favorites")
        } else {
            let league = League(id: Int(id), name: leagueName, logo: "") //قي حطه هنا
            CoreDataManager.shared.saveLeague(league, sportType: sport.rawValue)
            isFavorite = true
            print("Added to favorites")
        }

        NotificationCenter.default.post(name: Notification.Name("FavoritesUpdated"), object: nil)

        updateFavoriteButton()
    }


}

// MARK: - Layout Configuration

extension LeaguesDetailsCollectionViewController {

    private func configureCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { index, _ in
            switch index {
            case 0: return self.drawSection(itemWidth: .fractionalWidth(1), groupHeight: 185, groupWidth: .fractionalWidth(1), isHorizontal: true)
            case 1: return self.drawSection(itemWidth: .fractionalWidth(1), groupHeight: 185, groupWidth: .fractionalWidth(1), isHorizontal: false)
            case 2: return self.drawSection(itemWidth: .fractionalWidth(1), groupHeight: 185, groupWidth: .absolute(250), isHorizontal: true)
            default: return self.drawSection(itemWidth: .fractionalWidth(1), groupHeight: 185, groupWidth: .fractionalWidth(1), isHorizontal: true)
            }
        }
    }

    private func drawSection(itemWidth: NSCollectionLayoutDimension, groupHeight: CGFloat, groupWidth: NSCollectionLayoutDimension, isHorizontal: Bool) -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(widthDimension: itemWidth, heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: groupWidth, heightDimension: .absolute(groupHeight))
        let group = isHorizontal
            ? NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            : NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        group.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 10, bottom: 0, trailing: 10)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = isHorizontal ? .continuous : .none
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]

        section.visibleItemsInvalidationHandler = { items, offset, environment in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.8
                let maxScale: CGFloat = 1.0
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }

        return section
    }
}

// MARK: - Setup & Utilities

extension LeaguesDetailsCollectionViewController {

   

    private func registerCellsAndHeaders() {
        collectionView.register(SimpleHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SimpleHeaderView.reuseIdentifier)

        collectionView.register(UINib(nibName: "UpComingEvensCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: UpComingEvensCollectionViewCell.identifier)
        collectionView.register(UINib(nibName: "LatestEventsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: LatestEventsCollectionViewCell.identifier)
        collectionView.register(UINib(nibName: "TeamCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: TeamCollectionViewCell.identifier)
    }

    private func dequeueCell<T: UICollectionViewCell>(ofType type: T.Type, for indexPath: IndexPath) -> T {
        return collectionView.dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
}

// MARK: - Reuse Identifiers

extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}


// MARK: - UICollectionViewDelegate
extension LeaguesDetailsCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 2 {
            let teamDetailsViewController :  TeamDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "teamDetails") as! TeamDetailsViewController
            
            teamDetailsViewController.teamData = allTeams?[indexPath.row];
            
            let backItem = UIBarButtonItem()
            backItem.title = leagueName
            navigationItem.backBarButtonItem = backItem
            self.navigationController?.pushViewController(teamDetailsViewController, animated: true)
        }
       
    }
}

// MARK: - Dealing With Presenter "Fetching Data"
extension LeaguesDetailsCollectionViewController {
    
    // MARK: - Football
    func renderLeaguesDetailsFootballToView(result : LeaguesDetailsFootballResponse){
        
        self.hideLoadingAnimation()
        let allFootballMatches = result.result ?? []

        // Parse and filter
        upComingFootballMatches = allFootballMatches.filter {
            guard let dateString = $0.eventDate,
                  let matchDate = DateUtils.toDate(from: dateString) else { return false }
            return matchDate >= Date()
        }

        latestFootballMatches = allFootballMatches.filter {
            guard let dateString = $0.eventDate,
                  let matchDate = DateUtils.toDate(from: dateString) else { return false }
            return matchDate < Date()
        }

        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }

    // MARK: - Cricket
    
    func renderLeaguesDetailsCricketToView(result : LeaguesDetailsCricketResponse){
        self.hideLoadingAnimation()
        let allCricketMatches = result.result ?? []

        upComingCricketMatches = allCricketMatches.filter {
            guard let dateString = $0.eventDateStart,
                  let matchDate = DateUtils.toDate(from: dateString) else { return false }
            return matchDate >= Date()
        }

        latestCricketMatches = allCricketMatches.filter {
            guard let dateString = $0.eventDateStart,
                  let matchDate = DateUtils.toDate(from: dateString) else { return false }
            return matchDate < Date()
        }

        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    
    // MARK: - Basketball
    
    func renderLeaguesDetailsBasketballToView(result : LeaguesDetailsBasketballResponse){
        self.hideLoadingAnimation()
        let allBasketballMatches = result.result ?? []

        upComingBasketballMatches = allBasketballMatches.filter {
            guard let dateString = $0.eventDate,
                  let matchDate = DateUtils.toDate(from: dateString) else { return false }
            return matchDate >= Date()
        }

        latestBasketballMatches = allBasketballMatches.filter {
            guard let dateString = $0.eventDate,
                  let matchDate = DateUtils.toDate(from: dateString) else { return false }
            return matchDate < Date()
        }

        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    
    // MARK: - Tennis
    
    func renderLeaguesDetailsTennisToView(result : LeaguesDetailsTennisResponse){
        self.hideLoadingAnimation()
        let allTennisMatches = result.result ?? []

        upComingTennisMatches = allTennisMatches.filter {
            guard let dateString = $0.eventDate,
                  let matchDate = DateUtils.toDate(from: dateString) else { return false }
            return matchDate >= Date()
        }

        latestTennisMatches = allTennisMatches.filter {
            guard let dateString = $0.eventDate,
                  let matchDate = DateUtils.toDate(from: dateString) else { return false }
            return matchDate < Date()
        }

        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }

    
    func renderTeamDetailsToView(result : TeamDetailsResponse){
         allTeams = result.result ?? []

           DispatchQueue.main.async {
               self.collectionView?.reloadData()
           }
    }
}


// MARK: - Number Of Cells
extension LeaguesDetailsCollectionViewController {
    
    func calcNumOfCells() {
        switch sport {
        
        case .football :
            numUpComingMatches = upComingFootballMatches?.count ?? 0
            numLatestMatches = latestFootballMatches?.count ?? 0
            numTeams = allTeams?.count ?? 0
    
        case .basketball:
            numUpComingMatches = upComingBasketballMatches?.count ?? 0
            numLatestMatches = latestBasketballMatches?.count ?? 0
            numTeams = allTeams?.count ?? 0

        case .cricket :
            numUpComingMatches = upComingCricketMatches?.count ?? 0
            numLatestMatches = latestCricketMatches?.count ?? 0
            numTeams = allTeams?.count ?? 0
        
        default :
            numUpComingMatches = upComingTennisMatches?.count ?? 0
            numLatestMatches = latestTennisMatches?.count ?? 0
            numTeams = allTeams?.count ?? 0        }
    }
}
