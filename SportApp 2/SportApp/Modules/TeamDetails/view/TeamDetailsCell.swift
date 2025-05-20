//
//  TeamDetailsCell.swift
//  SportsApp
//
//  Created by Macos on 15/05/2025.
//

import UIKit

class TeamDetailsCell: UITableViewCell {

    @IBOutlet weak var backGround: UIView!
    
    @IBOutlet weak var positionTeamMember: UILabel!
    @IBOutlet weak var nameTeamMember: UILabel!
    @IBOutlet weak var backgroundImage: UIView!
    
    @IBOutlet weak var imageTeamMember: UIImageView!
    static let identifier = "PlayerCell"
    override func awakeFromNib() {
        
           super.awakeFromNib()
        
        setupBackgourndBorder()
        setupBackgourndImageCorner()
       }
       
       private func setupBackgourndBorder() {
           backgroundImage.layer.borderColor = UIColor.orange.cgColor

           backgroundImage.layer.borderWidth = 3.0
           backgroundImage.layer.cornerRadius = 5.0
           backgroundImage.clipsToBounds = true
       }
    
    private func setupBackgourndImageCorner() {
     

        backGround.layer.cornerRadius = backGround.layer.frame.width / 2
        backGround.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
