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
    sunrise = try result.decode(String.self, forKey: .sunrise)
    sunset = try result.decode(String.self, forKey: .sunset)
  }
}

extension SunRS {
  private func UTCToLocal(date: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "h:mm:ss a"
    dateFormatter.timeZone = TimeZone(identifier: "UTC")
    let date = dateFormatter.date(from: date)

    dateFormatter.dateFormat = "h:mm a"
    dateFormatter.timeZone = TimeZone.current
    let timeStamp = dateFormatter.string(from: date!)
    return timeStamp
  }

  public func localizede() -> SunRS {
    return SunRS(sunrise: UTCToLocal(date: sunrise), sunset: UTCToLocal(date: sunset))
  }
}
