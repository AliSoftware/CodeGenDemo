//
//  FocusCycler.swift
//  CodeGenDemo
//
//  Created by Olivier Halligon on 23/04/2017.
//  Copyright © 2017 AliSoftware. All rights reserved.
//

import UIKit

class FieldsCycler: NSObject, UITextFieldDelegate {
  var fields: [UITextField] = [] {
    willSet {
      self.fields.forEach { (field: UITextField) in
        field.inputAccessoryView = nil
        field.delegate = nil
      }
    }
    didSet {
      self.fields.enumerated().forEach { (idx: Int, field: UITextField) in
        let hasNext = idx < self.fields.count-1
        setAccessoryView(for: field, hasPrevious: idx > 0, hasNext: hasNext)
        field.returnKeyType = hasNext ? .next : .done
        field.delegate = self
      }
    }
  }

  private func setAccessoryView(for field: UITextField, hasPrevious: Bool, hasNext: Bool) {
    let bar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
    let prevBtn: UIBarButtonItem
    if (hasPrevious) {
      prevBtn = UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(previousField))
    } else {
      prevBtn = UIBarButtonItem(barButtonSystemItem: .rewind, target: nil, action: nil)
      prevBtn.isEnabled = false
    }
    let nextBtn: UIBarButtonItem
    if (hasNext) {
      nextBtn = UIBarButtonItem(barButtonSystemItem: .fastForward, target: self, action: #selector(nextField))
    } else {
      nextBtn = UIBarButtonItem(barButtonSystemItem: .fastForward, target: nil, action: nil)
      nextBtn.isEnabled = false
    }

    let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
    bar.items = [prevBtn, nextBtn, space, doneBtn]
    field.inputAccessoryView = bar
  }

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    nextField()
    return false
  }

  @objc private func previousField() {
    // tuple: ([1,2,3,4], [0,1,2,3])
    let found = zip(self.fields.dropFirst(), self.fields).first(where:{ tuple in
      tuple.0.isFirstResponder
    })
    found?.1.becomeFirstResponder()
  }

  @objc private func nextField() {
    // tuple: ([1,2,3,4], [0,1,2,3])
    zip(self.fields.dropFirst(), self.fields).first(where:{ tuple in
      tuple.1.isFirstResponder
    })?.0.becomeFirstResponder()
  }

  @objc private func done() {
    self.fields.first(where: { $0.isFirstResponder })?.resignFirstResponder()
  }
}
