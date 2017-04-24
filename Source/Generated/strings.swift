// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import Foundation

// swiftlint:disable file_length
// swiftlint:disable line_length

// swiftlint:disable type_body_length
enum L10n {
  /// Edit Image
  case editScreenTitle
  /// Dismiss changes
  case editAlertDismiss
  /// Changes have been made to the image « %@ »
  case editAlertMessage(String)
  /// Save changes
  case editAlertSave
  /// Dismiss changes?
  case editAlertTitle
  /// Author
  case editFieldsAuthor
  /// Date
  case editFieldsDate
  /// Kind
  case editFieldsKind
  /// Tags
  case editFieldsTags
  /// Title
  case editFieldsTitle
  /// Welcome to %1$@, the #%2$d meetup in %3$@!
  case homeGreetings(String, Int, String)
  /// Slideshow
  case homeSlideshow
  /// Close
  case imageClose
  /// Edit
  case imageEdit
  /// Building
  case imagekindBuilding
  /// Drawing
  case imagekindDrawing
  /// Nature/Landscape
  case imagekindLandscape
  /// Painting
  case imagekindPainting
  /// Face/Portrait
  case imagekindPortrait
  /// Unspecified
  case imagekindUnspecified
}
// swiftlint:enable type_body_length

extension L10n: CustomStringConvertible {
  var description: String { return self.string }

  var string: String {
    switch self {
      case .editScreenTitle:
        return L10n.tr(key: "edit.screenTitle")
      case .editAlertDismiss:
        return L10n.tr(key: "edit.alert.dismiss")
      case .editAlertMessage(let p1):
        return L10n.tr(key: "edit.alert.message", p1)
      case .editAlertSave:
        return L10n.tr(key: "edit.alert.save")
      case .editAlertTitle:
        return L10n.tr(key: "edit.alert.title")
      case .editFieldsAuthor:
        return L10n.tr(key: "edit.fields.author")
      case .editFieldsDate:
        return L10n.tr(key: "edit.fields.date")
      case .editFieldsKind:
        return L10n.tr(key: "edit.fields.kind")
      case .editFieldsTags:
        return L10n.tr(key: "edit.fields.tags")
      case .editFieldsTitle:
        return L10n.tr(key: "edit.fields.title")
      case .homeGreetings(let p1, let p2, let p3):
        return L10n.tr(key: "home.greetings", p1, p2, p3)
      case .homeSlideshow:
        return L10n.tr(key: "home.slideshow")
      case .imageClose:
        return L10n.tr(key: "image.close")
      case .imageEdit:
        return L10n.tr(key: "image.edit")
      case .imagekindBuilding:
        return L10n.tr(key: "imagekind.building")
      case .imagekindDrawing:
        return L10n.tr(key: "imagekind.drawing")
      case .imagekindLandscape:
        return L10n.tr(key: "imagekind.landscape")
      case .imagekindPainting:
        return L10n.tr(key: "imagekind.painting")
      case .imagekindPortrait:
        return L10n.tr(key: "imagekind.portrait")
      case .imagekindUnspecified:
        return L10n.tr(key: "imagekind.unspecified")
    }
  }

  private static func tr(key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

func tr(_ key: L10n) -> String {
  return key.string
}

private final class BundleToken {}
