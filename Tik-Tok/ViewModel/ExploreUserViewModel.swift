//
//  ExploreUserViewModel.swift
//  Tik-Tok
//
//  Created by Sergio on 17.05.23.
//

import UIKit

struct ExploreUserViewModel {
    let profilePicture: UIImage?
    let username : String
    let followerCount: Int
    let handler: (() -> Void)
}
