//
//  GMSViewController.swift
//  Sunrise-sunset
//
//  Created by Олег on 15.11.2019.
//  Copyright © 2019 Олег. All rights reserved.
//

import UIKit
import GooglePlaces

class CityPicker: GMSAutocompleteViewController, GMSAutocompleteViewControllerDelegate {

  private var cityPickerCoordinator: CityPickerCoordinator?

  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
    if let placeId = place.placeID {
      DataManager.shared.fetchLocation(from: placeId)
    }
    dismiss(animated: true, completion: nil)
  }

  func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
    print("Error: ", error.localizedDescription)
  }

  func wasCancelled(_ viewController: GMSAutocompleteViewController) {
    dismiss(animated: true, completion: nil)
  }

  func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
  }

  func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    delegate = self
    let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
        UInt(GMSPlaceField.placeID.rawValue))!
    placeFields = fields

    let filter = GMSAutocompleteFilter()
    filter.type = .region
    autocompleteFilter = filter
  }
}
