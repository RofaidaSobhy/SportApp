//
//  TeamCollectionViewCell.swift
//  SportsApp
//
//  Created by Macos on 15/05/2025.
//

import UIKit

class TeamCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backGround: UIImageView!
    
    @IBOutlet weak var teamImage: UIImageView!
    
    @IBOutlet weak var teamName: UILabel!
    
    
     let identifier = "TeamCell"

    override func awakeFromNib() {
           super.awakeFromNib()
           setupBackgroundBorder()
           setupNameCorners()
       }
       
       private func setupBackgroundBorder() {
           backGround.layer.borderColor = (UIColor(named: "gray") ?? UIColor.gray).cgColor

           backGround.layer.borderWidth = 3.0
           backGround.layer.cornerRadius = 20.0
           backGround.clipsToBounds = true
       }
    
    private func setupNameCorners() {
        teamName.layer.cornerRadius = 20.0
        teamName.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        teamName.clipsToBounds = true
    }

}
