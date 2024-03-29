//
//  AppDelegate.swift
//  Tik-Tok
//
//  Created by Sergio on 15.05.23.
//

import Appirater
import FirebaseCore
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        Appirater.appLaunched(true)
        Appirater.setDebug(false)
        Appirater.setAppId("12231321313")
        Appirater.setDaysUntilPrompt(7)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let tabBarController = TabBarViewController()
        window.rootViewController = tabBarController
        self.window = window
        self.window?.makeKeyAndVisible()

        FirebaseApp.configure()

//        AuthManager.shared.singOut { _ in
//
//        }

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

