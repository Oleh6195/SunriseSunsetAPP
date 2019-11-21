//
//  AppDelegate.swift
//  Sunrise-sunset
//
//  Created by Олег on 13.11.2019.
//  Copyright © 2019 Олег. All rights reserved.
//

import UIKit
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    private var applicationCoordinator: ApplicationCoordinator?
    var window: UIWindow?

    // swiftlint:disable line_length
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // swiftlint:enable line_length
        GMSPlacesClient.provideAPIKey("AIzaSyC946KOPL80LIVILtxgwp10CQbo5_S5CL0")

        let window = UIWindow(frame: UIScreen.main.bounds)
        let applicationCoordinator = ApplicationCoordinator(window: window)

        self.window = window
        self.applicationCoordinator = applicationCoordinator

        applicationCoordinator.start()
        return true
    }

}
