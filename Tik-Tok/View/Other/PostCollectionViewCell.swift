//
//  PostCollectionViewCell.swift
//  Tik-Tok
//
//  Created by Sergio on 26.05.23.
//

import AVFoundation
import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    static let identifier = "PostCollectionViewCell"

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        contentView.addSubview(imageView)
        contentView.backgroundColor = .secondarySystemBackground
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }

    func configure(with post: PostModel) {
        // Derive child path
        StorageManager.shared.getDownloadURL(for: post) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let url):
                    // Generate thumbnail
                    let asset = AVAsset(url: url)
                    let generator = AVAssetImageGenerator(asset: asset)

                    do {
                        let cgImage = try generator.copyCGImage(at: .zero, actualTime: nil)
                        self.imageView.image = UIImage(cgImage: cgImage)
                    }
                    catch {
                        
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
