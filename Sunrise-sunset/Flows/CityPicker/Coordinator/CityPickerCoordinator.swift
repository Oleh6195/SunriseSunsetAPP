//
//  FindPlaceCoordinator.swift
//  Sunrise-sunset
//
//  Created by Олег on 15.11.2019.
//  Copyright © 2019 Олег. All rights reserved.
//

import UIKit

class CityPickerCoordinator: Coordinator {
  private let presenter: UINavigationController
  private var currLocSunRSViewController: CurrLocSunRSCoordinator?
  private var cityPickerController: CityPicker?
  private let storage: Storage

  init(presenter: UINavigationController, storage: Storage) {
    self.presenter = presenter
    self.storage = storage
  }

  func start() {
    let cityPickerController = CityPicker()
    presenter.present(cityPickerController, animated: true, completion: nil)
    self.cityPickerController = cityPickerController
  }
}
