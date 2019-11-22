//
//  Error+extension.swift
//  Sunrise-sunset
//
//  Created by Олег on 21.11.2019.
//  Copyright © 2019 Олег. All rights reserved.
//

import UIKit

extension Error {

  func alert(with controller: UIViewController) {
    let alertController = UIAlertController(title: "Oops ❗️", message: "\(self)", preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(okAction)
    controller.present(alertController, animated: true, completion: nil)
  }
}
