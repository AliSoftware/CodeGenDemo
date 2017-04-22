//
//  UIViewController+Alert.swift
//  CodeGen
//
//  Created by Olivier Halligon on 22/04/2017.
//  Copyright © 2017 AliSoftware. All rights reserved.
//

import UIKit

extension UIViewController {
  func showAlert(title: String, message: String,
                 defaultButton: String, cancelButton: String,
                 handler: @escaping (Bool) -> Void) {
    let alert = UIAlertController(
      title: title,
      message: message,
      preferredStyle: .alert
    )
    alert.addAction(UIAlertAction(
      title: defaultButton,
      style: .default,
      handler: { _ in handler(true) }
    ))
    alert.addAction(UIAlertAction(
      title: cancelButton,
      style: .destructive,
      handler: { _ in handler(false) }
    ))
    self.present(alert, animated: true)
  }
}
