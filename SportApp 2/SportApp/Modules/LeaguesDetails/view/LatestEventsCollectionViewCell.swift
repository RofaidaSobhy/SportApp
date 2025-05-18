//
//  LatestEventsCollectionViewCell.swift
//  SportsApp
//
//  Created by Macos on 15/05/2025.
//

import UIKit

class LatestEventsCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var backGround: UIImageView!
    
    @IBOutlet weak var logoTeam1: UIImageView!
    
    @IBOutlet weak var nameTeam1: UILabel!
    
    @IBOutlet weak var logoTeam2: UIImageView!
    
    @IBOutlet weak var nameTeam2: UILabel!
    
    @IBOutlet weak var score: UILabel!
    
    @IBOutlet weak var matchDate: UILabel!
    
    @IBOutlet weak var matchTime: UILabel!
     var identifier = "LatestEventsCell"

    
    
    override func awakeFromNib() {
           super.awakeFromNib()
        setupBackgourndBorder()
           
       }
       
       private func setupBackgourndBorder() {
           backGround.layer.borderColor = (UIColor(named: "gray") ?? UIColor.gray).cgColor

           backGround.layer.borderWidth = 3.0
           backGround.layer.cornerRadius = 20.0
           backGround.clipsToBounds = true
       }
    
  

}
