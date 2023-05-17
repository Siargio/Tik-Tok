//
//  ExploreUserViewModel.swift
//  Tik-Tok
//
//  Created by Sergio on 17.05.23.
//

import UIKit

struct ExploreUserViewModel {
    let profilePictureURL: URL?
    let username : String
    let followCount: Int
    let handler: (() -> Void)
}
