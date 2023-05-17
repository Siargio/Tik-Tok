//
//  ExploreCell.swift
//  Tik-Tok
//
//  Created by Sergio on 17.05.23.
//

import UIKit

enum ExploreCell {
    case banner(viewModel: ExploreBannerViewModel)
    case post(viewModel: ExplorePostViewModel)
    case hashtag(viewModel: ExploreHashtagViewModel)
    case user(viewModel: ExploreUserViewModel)
}
