//
//  NavigationPopConfirmation.swift
//  CodeGen
//
//  Created by Olivier Halligon on 22/04/2017.
//  Copyright © 2017 AliSoftware. All rights reserved.
//

import UIKit

protocol NavigationPopConfirmation {
  func confirmNavigationPop(performPop: @escaping () -> Void)
}

// Ask confirmation when going back if changes were made
extension UINavigationController: UINavigationBarDelegate {
  public func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
    if let vc = self.topViewController as? NavigationPopConfirmation {
      vc.confirmNavigationPop { [weak self] in
        DispatchQueue.main.async {
          self?.popViewController(animated: true)
        }
      }
      return false
    }
    return true
  }
}
