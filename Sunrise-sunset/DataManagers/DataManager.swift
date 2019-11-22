//
//  DataManager.swift
//  Sunrise-sunset
//
//  Created by Олег on 13.11.2019.
//  Copyright © 2019 Олег. All rights reserved.
//

import UIKit

class DataManager {
  public static var shared = DataManager()
  private var decoder = JSONDecoder()

  func fetchSunrises(from coordinates: Coordinates) {
    let urlString = "https://api.sunrise-sunset.org/json?lat=\(coordinates.lat)&lng=\(coordinates.lng)"
    let url = URL(string: urlString)!

    _ = URLSession.shared.dataTask(with: url) { (data, _, error) in
      if error != nil {
        print(error!)
        return
      }
      if let dataW = data, dataW.count > 0 {
        do {
          let sunRS: SunRS = try self.decoder.decode(SunRS.self, from: dataW)
          Storage.shared.sunRS = sunRS
          Storage.shared.syncSunRS()
        } catch {
          print("error")
        }
      }

    }.resume()

  }

  func fetchLocation(from placeId: String) {
    // swiftlint:disable line_length
    let urlString = "https://maps.googleapis.com/maps/api/place/details/json?place_id=\(placeId)&fields=geometry,address_components&key=\(APIKeys.google)"
    print(urlString)
    // swiftlint:enable line_length
    let url = URL(string: urlString)!

    _ = URLSession.shared.dataTask(with: url) { (data, _, error) in
      if error != nil {
        print(error!)
        return
      }
      if let dataW = data, dataW.count > 0 {
        do {
          let location: Coordinates = try self.decoder.decode(Coordinates.self, from: dataW)
          Storage.shared.location = location
          Storage.shared.syncLocation()
        } catch {
          print("error")
        }
      }
    }.resume()
  }
}
