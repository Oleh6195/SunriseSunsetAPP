//
//  CurrentLocationSunriseViewController.swift
//  Sunrise-sunset
//
//  Created by Олег on 13.11.2019.
//  Copyright © 2019 Олег. All rights reserved.
//

import UIKit
import CoreLocation

protocol CurrentLocationSunriseViewControllerDelegate: class {
  func searchButtonTapped()
}

class CurrentLocationSunriseViewController: UIViewController {

  @IBOutlet weak var city: UILabel!
  @IBOutlet weak var sunsetLabel: UILabel!
  @IBOutlet weak var sunriseLabel: UILabel!
  var locationManager: CLLocationManager!
  weak var delegate: CurrentLocationSunriseViewControllerDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()
    setupLocationManager()
    setupNotificationCenter()
  }

  @IBAction func searchButttonClicked(_ sender: Any) {
    locationManager.stopUpdatingLocation()
    delegate?.searchButtonTapped()
  }
  // MARK: - Notification Center
  func setupNotificationCenter() {
    let sunrsname = NSNotification.Name(rawValue: "syncSunRS")
    let locname = NSNotification.Name(rawValue: "syncLocation")
    NotificationCenter.default.addObserver(self, selector: #selector(sunRSchanged), name: sunrsname, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(locationChaged), name: locname, object: nil)
  }

  @objc func sunRSchanged() {
    let defaultSunRS = SunRS(sunrise: "", sunset: "")
    setSunRS(sunRS: Storage.shared.sunRS ?? defaultSunRS)
  }

  @objc func locationChaged() {
    let defaultLocation = Coordinates(lat: 0.0, lng: 0.0, city: "")
    DataManager.shared.fetchSunrises(from: Storage.shared.location ?? defaultLocation)
  }

  // MARK: - View Changing
  func setSunRS(sunRS: SunRS) {
    let sunRS: SunRS = sunRS.localizede()
    DispatchQueue.main.async {
      self.sunriseLabel.text = sunRS.sunrise
      self.sunsetLabel.text = sunRS.sunset
      self.city.text = Storage.shared.location?.city
    }
  }

  // MARK: Defining Current Location
  func setupLocationManager() {
    locationManager = CLLocationManager()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestAlwaysAuthorization()

    if CLLocationManager.locationServicesEnabled() {
      locationManager.startUpdatingLocation()
    }
  }
}

extension CurrentLocationSunriseViewController: CLLocationManagerDelegate {

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let userLocation: CLLocation = locations[0] as CLLocation
    let lat = Double(userLocation.coordinate.latitude)
    let lng = Double(userLocation.coordinate.longitude)
    let coordinates: Coordinates = Coordinates(lat: lat, lng: lng, city: "")
    DataManager.shared.fetchSunrises(from: coordinates)
  }

  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("Error \(error)")
  }

}
