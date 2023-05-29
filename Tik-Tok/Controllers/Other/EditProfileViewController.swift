//
//  EditProfileViewController.swift
//  Tik-Tok
//
//  Created by Sergio on 29.05.23.
//

import UIKit

class EditProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Edit Profile"
        view.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(didTapClose))
    }
    
    @objc func didTapClose() {
        dismiss(animated: true)
    }

}
