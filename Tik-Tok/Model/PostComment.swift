//
//  PostComment.swift
//  Tik-Tok
//
//  Created by Sergio on 16.05.23.
//

import Foundation

struct PostComment {
    let text: String
    let user: User
    let date: Date

    static func mockComments() -> [PostComment] {
        let user = User(
            userName: "kanywest",
            profilePictureURL: nil,
            identifier: UUID().uuidString)

        var comments = [PostComment]()

        let text = [
            "Tis is an awesome pos!",
            "LOL",
            "FO FOF GOG OG!"
        ]

        for comment in text {
            comments.append(PostComment(text: comment, user: user, date: Date()))
        }
        return comments
    }
}
