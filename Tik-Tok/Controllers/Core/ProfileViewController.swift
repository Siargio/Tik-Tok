//
//  ProfileViewController.swift
//  Tik-Tok
//
//  Created by Sergio on 15.05.23.
//

import UIKit

class ProfileViewController: UIViewController {

    let user: User

    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = user.userName.uppercased()

    }


}
