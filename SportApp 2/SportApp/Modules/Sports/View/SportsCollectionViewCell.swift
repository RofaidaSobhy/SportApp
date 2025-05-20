//
//  SportsCollectionViewCell.swift
//  SportsApp
//
//  Created by Macos on 13/05/2025.
//

import UIKit

class SportsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sportName: UILabel!
    @IBOutlet weak var sportImage: UIImageView!
    
    override func awakeFromNib() {
           super.awakeFromNib()
           setupImageBorder()
           setupNameCorners()
       }
       
       private func setupImageBorder() {
           sportImage.layer.borderColor = UIColor.orange.cgColor

           sportImage.layer.borderWidth = 3.0
           sportImage.layer.cornerRadius = 20.0
           sportImage.clipsToBounds = true
       }
    
    private func setupNameCorners() {
        sportName.layer.cornerRadius = 20.0
        sportName.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        sportName.clipsToBounds = true
    }
}
