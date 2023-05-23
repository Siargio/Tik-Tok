//
//  ExploreHashtagCollectionViewCell.swift
//  Tik-Tok
//
//  Created by Sergio on 18.05.23.
//

import UIKit

class ExploreHashtagCollectionViewCell: UICollectionViewCell {

    static let identifier = "ExploreHashtagCollectionViewCell"

    private let iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let hashtagLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()


    //MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.addSubview(iconImage)
        contentView.addSubview(hashtagLabel)
        contentView.backgroundColor = .systemGray5
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let iconSize: CGFloat = contentView.height / 3

        iconImage.frame = CGRect(
            x: 10,
            y: (contentView.height - iconSize)/2,
            width: iconSize,
            height: iconSize).integral

        hashtagLabel.sizeToFit()
        hashtagLabel.frame = CGRect(
            x: iconImage.right + 10,
            y: 0,
            width: contentView.width - iconImage.right - 10,
            height: contentView.height).integral
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        hashtagLabel.text = nil
        iconImage.image = nil
    }

    public func configure(with viewModel: ExploreHashtagViewModel) {
        hashtagLabel.text = viewModel.text
        iconImage.image = viewModel.icon
    }
}
