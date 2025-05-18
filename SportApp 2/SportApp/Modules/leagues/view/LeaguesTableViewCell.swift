import UIKit

class LeaguesTableViewCell: UITableViewCell {

    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myImage: UIImageView!

    @IBOutlet weak var favButton: UIButton!
    private let roundedBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.orange.withAlphaComponent(0.3)
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()

    override func awakeFromNib() {
        super.awakeFromNib()

        // 1. Add background view
        contentView.insertSubview(roundedBackgroundView, at: 0)
        NSLayoutConstraint.activate([
            roundedBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            roundedBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            roundedBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            roundedBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])

        // 2. Setup Image
        myImage.translatesAutoresizingMaskIntoConstraints = false
        myImage.layer.cornerRadius = 25
        myImage.clipsToBounds = true
        myImage.contentMode = .scaleAspectFill

        // 3. Setup Label
        myLabel.translatesAutoresizingMaskIntoConstraints = false

        // 4. Constraints relative to roundedBackgroundView
        NSLayoutConstraint.activate([
            myImage.widthAnchor.constraint(equalToConstant: 50),
            myImage.heightAnchor.constraint(equalToConstant: 50),
            myImage.leadingAnchor.constraint(equalTo: roundedBackgroundView.leadingAnchor, constant: 16),
            myImage.centerYAnchor.constraint(equalTo: roundedBackgroundView.centerYAnchor),

            myLabel.leadingAnchor.constraint(equalTo: myImage.trailingAnchor, constant: 12),
            myLabel.trailingAnchor.constraint(equalTo: roundedBackgroundView.trailingAnchor, constant: -16),
            myLabel.centerYAnchor.constraint(equalTo: roundedBackgroundView.centerYAnchor)
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        myImage.layer.cornerRadius = myImage.frame.height / 2
    }
}

