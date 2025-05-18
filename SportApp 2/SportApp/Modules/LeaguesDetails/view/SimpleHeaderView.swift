//
//  SimpleHeaderView.swift
//  SportsApp
//
//  Created by Macos on 15/05/2025.
//

import UIKit

class SimpleHeaderView: UICollectionReusableView {
      var reuseIdentifier = "SimpleHeaderView"

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = UIColor(named: "black")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(text: String) {
        titleLabel.text = text
    }
}

