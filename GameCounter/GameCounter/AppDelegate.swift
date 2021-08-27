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
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .font: UIFont(name: "Nunito-ExtraBold", size: 36)!]
        if #available(iOS 13.0, *) {
            let buttonAppearance = UIBarButtonItemAppearance()
            buttonAppearance.normal.titleTextAttributes = [
                .foregroundColor: UIColor(named: "GulfStream")!,
                .font: UIFont(name: "Nunito-ExtraBold", size: 17)!
            ]
            navigationVC.navigationItem.standardAppearance?.buttonAppearance = buttonAppearance
            navigationVC.navigationItem.compactAppearance?.buttonAppearance = buttonAppearance
        } else {
            // Fallback on earlier versions
            UIBarButtonItem.appearance().setTitleTextAttributes([
                .foregroundColor: UIColor(named: "GulfStream")!,
                .font: UIFont(name: "Nunito-ExtraBold", size: 17)!
            ], for: .normal)
            UIBarButtonItem.appearance().setTitleTextAttributes([
                .font: UIFont(name: "Nunito-ExtraBold", size: 17)!
            ], for: .disabled)
            UIBarButtonItem.appearance().setTitleTextAttributes([
                .font: UIFont(name: "Nunito-ExtraBold", size: 17)!,
                .foregroundColor: UIColor.gray
            ], for: .highlighted)
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationVC
        window?.backgroundColor = .black
        window?.makeKeyAndVisible()
//        setupApperance()
        return true
    }
    
//    func setupApperance() {
////        UIView.appearance().tintColor = UIColor(named: "GulfStream")
//        UINavigationBar.appearance().barStyle = .black
//        UINavigationBar.appearance().isTranslucent = false
//        UINavigationBar.appearance().barTintColor = .black
//
//        if #available(iOS 13.0, *) {
//            let buttonAppearance = UIBarButtonItemAppearance()
//            buttonAppearance.normal.titleTextAttributes = [
//                .foregroundColor: UIColor(named: "GulfStream")!,
//                .font: UIFont(name: "Nunito-ExtraBold", size: 17)!
//            ]
//            navigationItem.standardAppearance?.buttonAppearance = buttonAppearance
//        } else {
//            // Fallback on earlier versions
//            UIBarButtonItem.appearance().setTitleTextAttributes([
//                .foregroundColor: UIColor(named: "GulfStream")!,
//                .font: UIFont(name: "Nunito-ExtraBold", size: 17)!
//            ], for: .normal)
//        }
//    }
    
}

