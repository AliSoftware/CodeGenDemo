//
//  ImageInfo.swift
//  CodeGen
//
//  Created by Olivier Halligon on 22/04/2017.
//  Copyright © 2017 AliSoftware. All rights reserved.
//

import Foundation

struct ImageMetaData {
  let title: String
  let author: String
  let date: Date
  let tags: [String]

  static func tags(from string: String) -> [String] {
    let tags = string.characters.split(omittingEmptySubsequences: true) {
      $0 == " " || $0 == ","
    }
    return tags.map(String.init)
  }
}

extension ImageMetaData {
  init() {
    self.init(title: "", author: "", date: Date(), tags: [])
  }
}
