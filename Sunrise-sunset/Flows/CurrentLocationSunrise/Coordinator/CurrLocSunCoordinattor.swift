//
//  CurrLocSunCoordinattor.swift
//  Sunrise-sunset
//
//  Created by Олег on 15.11.2019.
//  Copyright © 2019 Олег. All rights reserved.
//

import UIKit

class CurrLocSunRSCoordinator: Coordinator {
  private let presenter: UINavigationController
  private var currLocSunRsViewController: UIViewController?
  private let storage: Storage // 4

  init(presenter: UINavigationController, storage: Storage) {
    self.presenter = presenter
    self.storage = storage
  }

  func start() {
    let storyboard = UIStoryboard(name: "CurrentLocationSunrise", bundle: nil)
    // swiftlint:disable force_cast line_length
    let currLocSunRsViewController = storyboard.instantiateViewController(withIdentifier: "CurrentLocationSunrise") as! CurrentLocationSunriseViewController
    // swiftlint:enable force_cast line_length
    currLocSunRsViewController.delegate = self
    presenter.pushViewController(currLocSunRsViewController, animated: true)
    self.currLocSunRsViewController = currLocSunRsViewController
  }
}

extension CurrLocSunRSCoordinator: CurrentLocationSunriseViewControllerDelegate {
  func searchButtonTapped() {
    let gmsCoordinator = CityPickerCoordinator(presenter: presenter, storage: storage)
    gmsCoordinator.start()
  }
}
