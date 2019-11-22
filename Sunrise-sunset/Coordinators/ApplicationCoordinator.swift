//
//  ApplicationCoordinator.swift
//  Sunrise-sunset
//
//  Created by Олег on 16.11.2019.
//  Copyright © 2019 Олег. All rights reserved.
//

import UIKit

class ApplicationCoordinator: Coordinator {
  let storage: Storage
  let window: UIWindow
  let rootViewController: UINavigationController
  let currLocSunrsCoordinator: CurrLocSunRSCoordinator

  init(window: UIWindow) {
    self.window = window
    storage = Storage.shared
    rootViewController = UINavigationController()
    rootViewController.navigationBar.isHidden = true
    currLocSunrsCoordinator = CurrLocSunRSCoordinator(presenter: rootViewController, storage: storage)
  }

  func start() {
    window.rootViewController = rootViewController
    currLocSunrsCoordinator.start()
    window.makeKeyAndVisible()
  }
}
