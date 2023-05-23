//
//  ExploreUserCollectionViewCell.swift
//  Tik-Tok
//
//  Created by Sergio on 18.05.23.
//


import UIKit

class ExploreUserCollectionViewCell: UICollectionViewCell {

    static let identifier = "ExploreUserCollectionViewCell"

    private let profilePicture: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .secondarySystemGroupedBackground
        return imageView
    }()

    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.textAlignment = .center
        return label
    }()

    //MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.addSubview(profilePicture)
        contentView.addSubview(usernameLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize: CGFloat = contentView.height - 55
        profilePicture.frame = CGRect(
            x: (contentView.width - imageSize)/2,
            y: 0,
            width: imageSize,
            height: imageSize)

        profilePicture.layer.cornerRadius = profilePicture.height/2

        usernameLabel.frame = CGRect(
            x: 0,
            y: profilePicture.bottom,
            width: contentView.width,
            height: 55)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        usernameLabel.text = nil
        profilePicture.image = nil
    }

    public func configure(with viewModel: ExploreUserViewModel) {
        usernameLabel.text = viewModel.username
        profilePicture.image = viewModel.profilePicture
    }
}
