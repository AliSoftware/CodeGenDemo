// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import Foundation
import UIKit

// swiftlint:disable file_length
// swiftlint:disable line_length
// swiftlint:disable type_body_length

protocol StoryboardSceneType {
  static var storyboardName: String { get }
}

extension StoryboardSceneType {
  static func storyboard() -> UIStoryboard {
    return UIStoryboard(name: self.storyboardName, bundle: Bundle(for: BundleToken.self))
  }

  static func initialViewController() -> UIViewController {
    guard let vc = storyboard().instantiateInitialViewController() else {
      fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
    }
    return vc
  }
}

extension StoryboardSceneType where Self: RawRepresentable, Self.RawValue == String {
  func viewController() -> UIViewController {
    return Self.storyboard().instantiateViewController(withIdentifier: self.rawValue)
  }
  static func viewController(identifier: Self) -> UIViewController {
    return identifier.viewController()
  }
}

protocol StoryboardSegueType: RawRepresentable { }

extension UIViewController {
  func perform<S: StoryboardSegueType>(segue: S, sender: Any? = nil) where S.RawValue == String {
    performSegue(withIdentifier: segue.rawValue, sender: sender)
  }
}

enum StoryboardScene {
  enum LaunchScreen: StoryboardSceneType {
    static let storyboardName = "LaunchScreen"
  }
  enum Main: StoryboardSceneType {
    static let storyboardName = "Main"

    static func initialViewController() -> CodeGenDemo.HomeViewController {
      guard let vc = storyboard().instantiateInitialViewController() as? CodeGenDemo.HomeViewController else {
        fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
      }
      return vc
    }
  }
  enum Photos: String, StoryboardSceneType {
    static let storyboardName = "Photos"

    static func initialViewController() -> CodeGenDemo.SlideShowViewController {
      guard let vc = storyboard().instantiateInitialViewController() as? CodeGenDemo.SlideShowViewController else {
        fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
      }
      return vc
    }

    case editVCScene = "EditVC"
    static func instantiateEditVC() -> CodeGenDemo.EditViewController {
      guard let vc = StoryboardScene.Photos.editVCScene.viewController() as? CodeGenDemo.EditViewController
      else {
        fatalError("ViewController 'EditVC' is not of the expected class CodeGenDemo.EditViewController.")
      }
      return vc
    }
  }
}

enum StoryboardSegue {
}

private final class BundleToken {}
