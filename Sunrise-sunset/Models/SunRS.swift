//
//  SunRS.swift
//  Sunrise-sunset
//
//  Created by Олег on 13.11.2019.
//  Copyright © 2019 Олег. All rights reserved.
//

import Foundation

struct SunRS {
    var sunrise: String
    var sunset: String
}

extension SunRS: Decodable {
    enum CodingKeys: String, CodingKey {
        case results
    }
    enum ResultsKeys: String, CodingKey {
        case sunrise
        case sunset
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let result = try container.nestedContainer(keyedBy: ResultsKeys.self, forKey: .results)
        self.sunrise = try result.decode(String.self, forKey: .sunrise)
        self.sunset = try result.decode(String.self, forKey: .sunset)
    }
}
