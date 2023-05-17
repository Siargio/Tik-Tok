//
//  ExploreHashtagViewModel.swift
//  Tik-Tok
//
//  Created by Sergio on 17.05.23.
//

import UIKit

struct ExploreHashtagViewModel {
    let text: String
    let icon: UIImage?
    let count: Int
    let handler: (() -> Void)
}
