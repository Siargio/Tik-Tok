//
//  ExploreSectionType.swift
//  Tik-Tok
//
//  Created by Sergio on 17.05.23.
//

import Foundation

enum ExploreSectionType: CaseIterable {
    case banners
    case trendingPost
    case users
    case trendingHashtags
    case recommended
    case popular
    case new

    var title: String {
        switch self {
        case .banners:
            return "Feature"
        case .trendingPost:
            return "Trending Videos"
        case .users:
            return "Popular Creators"
        case .trendingHashtags:
            return "Hashtags"
        case .recommended:
            return "Recommended"
        case .popular:
            return "Popular"
        case .new:
            return "Recently Posted"

        }
    }
}
