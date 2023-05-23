//
//  TabBarViewController.swift
//  Tik-Tok
//
//  Created by Sergio on 15.05.23.
//

import UIKit

class TabBarViewController: UITabBarController {

    private var signInPresented = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpControllers()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !signInPresented {
            presentSignInIfNeeded()
        }
    }

    private func presentSignInIfNeeded() {
        if !AuthManager.shared.isSignedIn {
            signInPresented = true
            let vc = SingInViewController()
            vc.completion = { [weak self] in
                self?.signInPresented = false
            }
            let navVc = UINavigationController(rootViewController: vc)
            navVc.modalPresentationStyle = .fullScreen
            present(navVc, animated: true)
        }
    }

    private func setUpControllers() {
        let home = HomeViewController()
        let explore = ExploreViewController()
        let camera = CameraViewController()
        let notifications = NotificationsViewController()
        let profile = ProfileViewController(user: User(
            userName: "fafaf",
            profilePictureURL: nil,
            identifier: "123456"))

        notifications.title = "Notifications"
        profile.title = "Profile"

        let nav1 = UINavigationController(rootViewController: home)
        let nav2 = UINavigationController(rootViewController: explore)
        let nav3 = UINavigationController(rootViewController: notifications)
        let nav4 = UINavigationController(rootViewController: profile)
        let cameraNav = UINavigationController(rootViewController: camera)

        //cameraNav.navigationBar.isHidden = true

        nav1.navigationBar.backgroundColor = .clear
        nav1.navigationBar.setBackgroundImage(UIImage(), for: .default)
        nav1.navigationBar.shadowImage = UIImage()

        cameraNav.navigationBar.backgroundColor = .clear
        cameraNav.navigationBar.setBackgroundImage(UIImage(), for: .default)
        cameraNav.navigationBar.shadowImage = UIImage()
        cameraNav.navigationBar.tintColor = .white

        nav3.navigationBar.tintColor = .label

        nav1.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "safari"), tag: 2)
        camera.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "camera"), tag: 3)
        nav3.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "bell"), tag: 4)
        nav4.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person.circle"), tag: 5)

        if #available(iOS 14.0, *) {
            nav1.navigationItem.backButtonDisplayMode = .minimal
            nav2.navigationItem.backButtonDisplayMode = .minimal
            nav3.navigationItem.backButtonDisplayMode = .minimal
            nav4.navigationItem.backButtonDisplayMode = .minimal
            cameraNav.navigationItem.backButtonDisplayMode = .minimal
        }

        setViewControllers([nav1, nav2, cameraNav, nav3, nav4], animated: false)
    }
}
