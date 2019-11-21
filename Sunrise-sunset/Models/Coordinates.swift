//
//  Coordinates.swift
//  Sunrise-sunset
//
//  Created by Олег on 13.11.2019.
//  Copyright © 2019 Олег. All rights reserved.
//

import Foundation
import CoreLocation

struct Coordinates {
    var lat: Double
    var lng: Double
    var city: String
}
struct Address: Decodable {
    // swiftlint:disable identifier_name
    var short_name: String
    var long_name: String
}

extension Coordinates: Decodable {
    enum CodingKeys: String, CodingKey {
        case result
    }

    enum ResultKeys: String, CodingKey {
        case geometry
        case address_components
         // swiftlint:enable identifier_name
    }
    enum GeometryKeys: String, CodingKey {
        case location
    }

    enum LocationKeys: String, CodingKey {
        case lat
        case lng
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let resultContainer = try container.nestedContainer(keyedBy: ResultKeys.self, forKey: .result)
        let geometryContainer = try resultContainer.nestedContainer(keyedBy: GeometryKeys.self, forKey: .geometry)
        let locationContainer = try geometryContainer.nestedContainer(keyedBy: LocationKeys.self, forKey: .location)
        self.lat = try locationContainer.decode(Double.self, forKey: .lat)
        self.lng = try locationContainer.decode(Double.self, forKey: .lng)
        let address = try resultContainer.decode([Address].self, forKey: .address_components)
        self.city = address[0].short_name
    }
}
