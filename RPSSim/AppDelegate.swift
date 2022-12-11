//
//  AppDelegate.swift
//  RPSSim
//
//  Created by Ahmed Khalaf on 11/12/2022.
//

import UIKit
import RPSSimCore
import RPSSimUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private let simulationViewControllerFactory: SimulationViewControllerFactory = .init()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setUpWindow()
        return true
    }
    
    private func setUpWindow() {
        window = .init(frame: UIScreen.main.bounds)
        window?.rootViewController = simulationViewControllerFactory.makeSimulationViewController()
        window?.makeKeyAndVisible()
    }
}

