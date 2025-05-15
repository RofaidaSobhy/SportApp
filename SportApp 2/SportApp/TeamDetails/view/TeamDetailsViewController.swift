//
//  TeamDetailsViewController.swift
//  SportsApp
//
//  Created by Macos on 15/05/2025.
//

import UIKit

class TeamDetailsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var teamMembers: UITableView!
    @IBOutlet weak var ImageTeam: UIImageView!
    @IBOutlet weak var nameTeam: UILabel!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }

    // MARK: - Setup
    private func setupTableView() {
        let nib = UINib(nibName: "TeamDetailsCell", bundle: nil)
        teamMembers.register(nib, forCellReuseIdentifier: TeamDetailsCell.identifier)
        teamMembers.dataSource = self
        teamMembers.delegate = self
        teamMembers.separatorStyle = .none
    }
}

// MARK: - UITableViewDataSource
extension TeamDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TeamDetailsCell.identifier, for: indexPath) as! TeamDetailsCell
        cell.backgroundColor = .clear
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
