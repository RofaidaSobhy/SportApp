//
//  TeamDetailsViewController.swift
//  SportsApp
//
//  Created by Macos on 15/05/2025.
//

import UIKit
import Kingfisher

class TeamDetailsViewController: UIViewController {

    
    // MARK: - Outlets
    @IBOutlet weak var teamMembers: UITableView!
    @IBOutlet weak var ImageTeam: UIImageView!
    @IBOutlet weak var nameTeam: UILabel!

    // MARK: - Variables
    
    var teamData : TeamData?
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
        
        nameTeam.text = teamData?.teamName
        
        if let urlTeamLogo = URL(string: teamData?.teamLogo ?? ""){
            ImageTeam.kf.setImage(with: urlTeamLogo ,placeholder: UIImage(named: "1"))
        }
    }

    // MARK: - Setup
    private func setupTableView() {
        let nib = UINib(nibName: "TeamDetailsCell", bundle: nil)
        teamMembers.register(nib, forCellReuseIdentifier: TeamDetailsCell.identifier)
        teamMembers.dataSource = self
        teamMembers.delegate = self
        teamMembers.separatorStyle = .none
    }
    

        private func setupNavigationBar() {
            let customFont = UIFont.systemFont(ofSize: 24, weight: .bold)
            let customColor = UIColor(named: "orange") ?? .orange
            navigationController?.navigationBar.titleTextAttributes = [
                .foregroundColor: customColor,
                .font: customFont
            ]
            navigationItem.title = teamData?.teamName ?? "TeamName"
            
            navigationController?.navigationBar.tintColor = UIColor(named: "orange") ?? .orange
        }

}

// MARK: - UITableViewDataSource
extension TeamDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return teamData?.players?.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TeamDetailsCell.identifier, for: indexPath) as! TeamDetailsCell
        cell.backgroundColor = .clear
        
        cell.nameTeamMember.text = teamData?.players?[indexPath.section].playerName
       
        cell.positionTeamMember.text = teamData?.players?[indexPath.section].playerType
        
        if let urlPlayerImage = URL(string: teamData?.players?[indexPath.section].playerImage ?? ""){
            cell.imageTeamMember.kf.setImage(with: urlPlayerImage ,placeholder: UIImage(named: "dummyPlayer"))
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TeamDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
}
