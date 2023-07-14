//
//  ProfileHeaderCollectionReusableView.swift
//  Tik-Tok
//
//  Created by Sergio on 23.05.23.
//

import SDWebImage
import UIKit

protocol ProfileHeaderCollectionReusableViewDelegate: AnyObject {
    func profileHeaderCollectionReusableView(_ header: ProfileHeaderCollectionReusableView, didTapPrimaryButtonWith viewModel: profileHeaderViewModel)
    func profileHeaderCollectionReusableView(_ header: ProfileHeaderCollectionReusableView, didTapFollowersButtonWith viewModel: profileHeaderViewModel)
    func profileHeaderCollectionReusableView(_ header: ProfileHeaderCollectionReusableView, didTapFollowingButtonWith viewModel: profileHeaderViewModel)
    func profileHeaderCollectionReusableView(_ header: ProfileHeaderCollectionReusableView, didTapTapAvatarFor viewModel: profileHeaderViewModel)
}

class ProfileHeaderCollectionReusableView: UICollectionReusableView {

    static let identifier = "ProfileHeaderCollectionReusableView"

    weak var delegate: ProfileHeaderCollectionReusableViewDelegate?

    var viewModel: profileHeaderViewModel?

    // subviews
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()

    private let primaryButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.setTitle("Follow", for: .normal)
        button.setTitleColor(.label, for: .normal) 
        button.backgroundColor = .systemPink
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        return button
    }()

    private let followersButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.setTitle("0\nFollowers", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.numberOfLines = 2
        button.backgroundColor = .secondarySystemBackground
        return button
    }()

    private let followingButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 6
        button.layer.masksToBounds = true
        button.setTitle("0\nFollowing", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.numberOfLines = 2
        button.backgroundColor = .secondarySystemBackground
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        backgroundColor = .systemBackground
        addSubviews()
        configureButtons()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapAvatar))
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(tap)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews() {
        addSubview(avatarImageView)
        addSubview(primaryButton)
        addSubview(followersButton)
        addSubview(followingButton)
    }

    private func configureButtons() {
        primaryButton.addTarget(self, action: #selector(didTapPrimaryButton), for: .touchUpInside)
        followersButton.addTarget(self, action: #selector(didTapFollowersButton), for: .touchUpInside)
        followingButton.addTarget(self, action: #selector(didTapFollowingButton), for: .touchUpInside)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let avatarSize: CGFloat = 130
        avatarImageView.frame = CGRect(x: (width - avatarSize)/2, y: 5, width: avatarSize, height: avatarSize)
        avatarImageView.layer.cornerRadius = avatarImageView.height/2

        followersButton.frame = CGRect(x: (width - 210)/2, y: avatarImageView.bottom+10, width: 100, height: 60)
        followingButton.frame = CGRect(x: followersButton.right + 10, y: avatarImageView.bottom+10, width: 100, height: 60)

        primaryButton.frame = CGRect(x: (width - 220)/2, y: followingButton.bottom+15, width: 220, height: 44)
    }

    //Actions

    @objc func didTapAvatar() {
        guard let viewModel = self.viewModel else {
            return
        }
        delegate?.profileHeaderCollectionReusableView(self, didTapTapAvatarFor: viewModel)
    }

    @objc func didTapPrimaryButton() {
        guard let viewModel = self.viewModel else {
            return
        }
        delegate?.profileHeaderCollectionReusableView(self, didTapPrimaryButtonWith: viewModel)
    }

    @objc func didTapFollowersButton() {
        guard let viewModel = self.viewModel else {
            return
        }
        delegate?.profileHeaderCollectionReusableView(self, didTapFollowersButtonWith: viewModel)
    }

    @objc func didTapFollowingButton() {
        guard let viewModel = self.viewModel else {
            return
        }
        delegate?.profileHeaderCollectionReusableView(self, didTapFollowingButtonWith: viewModel)
    }

    func configure(with viewModel: profileHeaderViewModel) {
        self.viewModel = viewModel
        //Set up our header
        followersButton.setTitle("\(viewModel.followerCount)\nFollowers", for: .normal)
        followingButton.setTitle("\(viewModel.followingCount)\nFollowing", for: .normal)
        if let avatarURL = viewModel.avatarImageURL {
            avatarImageView.sd_setImage(with: avatarURL)
        } else {
            avatarImageView.image = UIImage(named: "test")
        }

        if let isFollowing = viewModel.isFollowing {
            primaryButton.backgroundColor = isFollowing ? .secondarySystemBackground : .systemPink
            primaryButton.setTitle(isFollowing ? "Unfollow" : "Follow", for: .normal)
        } else {
            primaryButton.backgroundColor = .secondarySystemBackground
            primaryButton.setTitle("Edit Profile", for: .normal)
        }
    }
}
