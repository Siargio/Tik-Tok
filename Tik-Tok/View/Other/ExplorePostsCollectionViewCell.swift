//
//  ExplorePostsCollectionViewCell.swift
//  Tik-Tok
//
//  Created by Sergio on 18.05.23.
//

import UIKit

class ExplorePostsCollectionViewCell: UICollectionViewCell {

    static let identifier = "ExplorePostsCollectionViewCell"

    private let thumbnailImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        //imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()

    private let captionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()


    //MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.addSubview(thumbnailImage)
        contentView.addSubview(captionLabel)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let captionHeight = contentView.height / 5
        thumbnailImage.frame = CGRect(
            x: 0,
            y: 0,
            width: contentView.width,
            height: contentView.height - captionHeight)

        captionLabel.frame = CGRect(
            x: 0,
            y: contentView.height - captionHeight,
            width: contentView.width,
            height: captionHeight)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        captionLabel.text = nil
        thumbnailImage.image = nil
    }

    public func configure(with viewModel: ExplorePostViewModel) {
        captionLabel.text = viewModel.caption
        thumbnailImage.image = viewModel.imageView
    }
}
