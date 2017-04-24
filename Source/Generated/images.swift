// Auto-Generated, to not EDIT

import UIKit

enum Assets: String {
  case closeBtn = "Close-Btn"
  case next = "Next"
  case nsBudapest = "NSBudapest"
  case photos = "photos"
  case previous = "Previous"
  case swiftGenLogo = "SwiftGen-Logo"
}

extension UIImage {
  convenience init!(asset: Assets) {
    self.init(named: asset.rawValue)
  }
}
