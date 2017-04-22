//
//  ImageInfo.swift
//  CodeGenDemo
//
//  Created by Olivier Halligon on 22/04/2017.
//  Copyright © 2017 AliSoftware. All rights reserved.
//

import Foundation

enum ImageKind: String {
  case unspecified
  case landscape
  case building
  case portrait
  case drawing
  case painting

  static var allValues: [ImageKind] {
    // FIXME: Quite cumbersome to type, and har to maintain! 😱
    // Look, we even forgot one!
    return [
      .unspecified,
      .landscape,
      .building,
      .portrait,
      .drawing,
    ]
  }
  
  var localizedString: String {
    // FIXME: String-based API 😱
    return NSLocalizedString("imagekind.\(self.rawValue)", comment: "")
  }
}

struct ImageMetaData {
  let title: String
  let author: String
  let date: Date
  let tags: [String]
  let kind: ImageKind

  static func tags(from string: String) -> [String] {
    let tags = string.characters.split(omittingEmptySubsequences: true) {
      $0 == " " || $0 == ","
    }
    return tags.map(String.init)
  }
}

extension ImageMetaData {
  init() {
    self.init(title: "", author: "", date: Date(), tags: [], kind: .unspecified)
  }
}
