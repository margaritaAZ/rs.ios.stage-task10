//
//  AppDelegate.swift
//  GameCounter
//
//  Created by Маргарита Жучик on 25.08.21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let newGameVC = NewGameViewController()
        
        let navigationVC = UINavigationController(rootViewController: newGameVC)
        navigationVC.navigationBar.barTintColor = .black
        navigationVC.navigationBar.isTranslucent = false
        navigationVC.navigationBar.barStyle = .black
        
        
//        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Nunito-ExtraBold", size: .zero)!]
//        navigationVC.navigationBar.titleTextAttributes =
//            [NSAttributedString.Key.font: UIFont(name: "Nunito-ExtraBold", size: 36)!
////                                                                            ?? UIFont.systemFont(ofSize: 24)
//        ]
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationVC
        window?.backgroundColor = .black
        window?.makeKeyAndVisible()
        return true
    }
}

