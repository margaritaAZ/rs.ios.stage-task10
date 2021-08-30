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
        
        UINavigationBar.appearance().barStyle = .black
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = .black
        
        UIBarButtonItem.appearance().setTitleTextAttributes([
            .foregroundColor: UIColor.gulfStream,
            .font: UIFont.nunito(17, .extraBold)], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([
            .font: UIFont.nunito(17, .extraBold)], for: .disabled)
        UIBarButtonItem.appearance().setTitleTextAttributes([
            .font: UIFont.nunito(17, .extraBold),
            .foregroundColor: UIColor.gray
        ], for: .highlighted)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationVC
        window?.backgroundColor = .black
        window?.makeKeyAndVisible()
        return true
    }
    
}

