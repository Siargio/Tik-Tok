//
//  Model.swift
//  Tik-Tok
//
//  Created by Sergio on 16.05.23.
//

import Foundation

struct PostModel {

    let identifier: String

    var isLikedByCurrentUser = false
    
    static func mockModels() -> [PostModel] {
        var posts = [PostModel]()
        for _ in 0...100 {
            let post = PostModel(identifier: UUID().uuidString)
            posts.append(post)
        }
        return posts
    }
}
