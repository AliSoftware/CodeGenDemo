//
//  RawDemo.swift
//  CodeGenDemo
//
//  Created by Olivier Halligon on 14/05/2017.
//  Copyright © 2017 AliSoftware. All rights reserved.
//

import Foundation

func rowDemo() {

  // Collect an array of Row items
  let cells: [AnyRow<File>] = [AnyRow(FileCell()),
                               AnyRow(DetailFileCell())]

  // Grab a random instance of Row
  let randomFileCell: AnyRow = (arc4random() % 2 == 0) ?
    AnyRow(FileCell()) :
    AnyRow(DetailFileCell())

  // Pass a Row as a function argument
  func resize(row: AnyRow<File>) {
    let file = File()
    row.configure(model: file)
  }

  // Return an instance of Row
  func firstRow() -> AnyRow<File> {
    return cells[0]
  }

  // Configure our collection of cells with a new File
  cells.forEach() {
    $0.configure(model: File())
  }

  // Mutate and access properties on a Cell
  if let firstCell = cells.first {
    firstCell.sizeLabelText = "200KB"
    print(firstCell.sizeLabelText) // Prints 200KB
  }
  
}
