//
//  AppDelegate.swift
//  RPSSim
//
//  Created by Ahmed Khalaf on 11/12/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setUpWindow()
        return true
    }
    
    private func setUpWindow() {
        window = .init(frame: UIScreen.main.bounds)
        window?.rootViewController = SimulationViewController()
        window?.makeKeyAndVisible()
    }
}

