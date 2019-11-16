//
//  Storage.swift
//  Sunrise-sunset
//
//  Created by Олег on 15.11.2019.
//  Copyright © 2019 Олег. All rights reserved.
//

import Foundation

class Storage {
    public static var shared = Storage()

    var sunRS: SunRS?
    var location: Coordinates?

    func syncSunRS() {
        DispatchQueue.main.async {
            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "syncSunRS")))
        }
    }
    func syncLocation() {
        DispatchQueue.main.async {
            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "syncLocation")))
        }
    }
}
