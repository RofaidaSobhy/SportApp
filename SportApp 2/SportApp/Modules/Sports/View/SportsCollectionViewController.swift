//
//  SportsCollectionViewController.swift
//  SportsApp
//
//  Created by Macos on 13/05/2025.
//

import UIKit

private let reuseIdentifier = "cell"

class SportsCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
    }
    
}
    extension SportsCollectionViewController {
        func setupNavigationBar() {
            let customFont = UIFont.systemFont(ofSize: 24, weight: .bold)
            let customColor = UIColor(named: "orange") ?? UIColor.orange

            navigationController?.navigationBar.titleTextAttributes = [
                .foregroundColor: customColor,
                .font: customFont
            ]
            navigationItem.title = "Sports"
        }
    }


// MARK: UICollectionViewDataSource


extension SportsCollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SportsCollectionViewCell
        
        switch indexPath.row {
        case 0:
            cell.sportName.text = "Basketball"
            cell.sportImage.image = UIImage(named: "sportsBasketball")
        case 1:
            cell.sportName.text = "Cricket"
            cell.sportImage.image = UIImage(named: "sportsCricket")
        case 2:
            cell.sportName.text = "Football"
            cell.sportImage.image = UIImage(named: "sportsFootball")
        default:
            cell.sportName.text = "Tennis"
            cell.sportImage.image = UIImage(named: "sportsTennis")
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var selectedSport:SportType?
        
        switch indexPath.row {
        case 0:
            selectedSport = .basketball
        case 1:
            selectedSport = .cricket
        case 2:
            selectedSport = .football
        default:
            selectedSport = .tennis
        }
        
        if let leaguesVC = storyboard?.instantiateViewController(withIdentifier: "LeaguesViewController") as? LeaguesViewController {
            leaguesVC.selectedSport = selectedSport
            navigationController?.pushViewController(leaguesVC, animated: true)
        }
    }}
// MARK: UICollectionViewDelegateFlowLayout

extension SportsCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 175, height: 280)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 70, left: 10, bottom: 10, right: 10)
    }
}



