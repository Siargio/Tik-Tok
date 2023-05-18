//
//  ExploreBannerCollectionViewCell.swift
//  Tik-Tok
//
//  Created by Sergio on 18.05.23.
//

import UIKit

class ExploreBannerCollectionViewCell: UICollectionViewCell {

    static let identifier = "ExploreBannerCollectionViewCell"

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()

    //MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        label.sizeToFit()
        imageView.frame = contentView.bounds
        label.frame = CGRect(x: 10, y: contentView.height - 5 - label.height, width: label.width, height: label.height)
        contentView.bringSubviewToFront(label)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        imageView.image = nil
    }

    public func configure(with viewModel: ExploreBannerViewModel) {
        label.text = viewModel.title
        imageView.image = viewModel.imageView
    }
}
