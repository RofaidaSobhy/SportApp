//
//  FavoriteViewCell.swift
//  SportApp
//
//  Created by Ayatullah Salah on 15/05/2025.
//

import UIKit


class FavoriteViewCell: UITableViewCell {
    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myImage: UIImageView!

    private let roundedBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "orange")

        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()

    override func awakeFromNib() {
        super.awakeFromNib()

        contentView.insertSubview(roundedBackgroundView, at: 0)

        NSLayoutConstraint.activate([
            roundedBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            roundedBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            roundedBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            roundedBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])

        myImage.translatesAutoresizingMaskIntoConstraints = false
        myLabel.translatesAutoresizingMaskIntoConstraints = false

        myImage.layer.cornerRadius = 25
        myImage.clipsToBounds = true
        myImage.contentMode = .scaleAspectFill

        NSLayoutConstraint.activate([
            myImage.widthAnchor.constraint(equalToConstant: 50),
            myImage.heightAnchor.constraint(equalToConstant: 50),
            myImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            myImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            myLabel.leadingAnchor.constraint(equalTo: myImage.trailingAnchor, constant: 12),
            myLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            myLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        myImage.layer.cornerRadius = myImage.frame.height / 2
    }

}
