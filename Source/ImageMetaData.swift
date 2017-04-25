//
//  ImageInfo.swift
//  CodeGenDemo
//
//  Created by Olivier Halligon on 22/04/2017.
//  Copyright © 2017 AliSoftware. All rights reserved.
//

import Foundation


enum ImageKind: String, AutoCases {
  case unspecified
  case landscape
  case building
  case portrait
  case drawing
  case painting

  var localizedString: String {
    return NSLocalizedString("imagekind.\(self.rawValue)", comment: "")
  }
}

struct ImageMetaData: AutoEquatable {
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
