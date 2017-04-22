//
//  EditViewController.swift
//  CodeGen
//
//  Created by Olivier Halligon on 22/04/2017.
//  Copyright © 2017 AliSoftware. All rights reserved.
//

import UIKit

class EditViewController: UITableViewController {

  // MARK: IBOutlets

  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var titleField: UITextField!
  @IBOutlet private weak var authorLabel: UILabel!
  @IBOutlet private weak var authorField: UITextField!
  @IBOutlet private weak var kindLabel: UILabel!
  @IBOutlet private weak var kindPicker: UIPickerView!
  @IBOutlet private weak var tagsLabel: UILabel!
  @IBOutlet private weak var tagsField: UITextField!
  @IBOutlet private weak var dateLabel: UILabel!
  @IBOutlet private weak var dateField: UILabel!
  @IBOutlet private weak var datePicker: UIDatePicker!

  // MARK: Properties

  var imageMetaData: ImageMetaData?
  var saveMetaData: (ImageMetaData) -> Void = { _ in }
  private let fieldsCycler = FieldsCycler()

  // MARK: Setup

  override func viewDidLoad() {
    super.viewDidLoad()
    translateUI()
    fillForm()
    fieldsCycler.fields = [titleField, authorField, tagsField]
  }

  // MARK: IBActions

  @IBAction private func dateChanged(_ sender: UIDatePicker) {
    self.dateField.text = format(date: sender.date)
  }

  // MARK: Prvate methods

  private func translateUI() {
    // FIXME: String-based API 😱
    self.title = NSLocalizedString("edit.screenTitle", comment: "")

    let mappings = [
      titleLabel: "edit.fields.title",
      authorLabel: "edit.fields.author",
      kindLabel: "edit.fields.kind",
      tagsLabel: "edit.fields.tags",
      dateLabel: "edit.fields.date",
    ]

    for (label, key) in mappings {
      // FIXME: String-based API 😱
      label.text = NSLocalizedString(key, comment: "")
    }
  }

  private func format(date: Date) -> String {
    return DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .short)
  }

  private func fillForm() {
    guard let info = self.imageMetaData else { return }
    self.titleField.text = info.title
    self.authorField.text = info.author
    let row = ImageKind.allValues.index(of: info.kind) ?? 0
    self.kindPicker.selectRow(row, inComponent: 0, animated: false)
    self.tagsField.text = info.tags.joined(separator: " ")
    self.dateField.text = format(date: info.date)
  }

  fileprivate func imageMetaDataFromForm() -> ImageMetaData {
    return ImageMetaData(
      title: self.titleField.text ?? "",
      author: self.authorField.text ?? "",
      date: self.datePicker.date,
      tags: ImageMetaData.tags(from: self.tagsField.text ?? ""),
      kind: ImageKind.allValues[self.kindPicker.selectedRow(inComponent: 0)]
    )
  }
}

// MARK: - UIPickerView

extension EditViewController: UIPickerViewDataSource, UIPickerViewDelegate {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return ImageKind.allValues.count
  }
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return ImageKind.allValues[row].localizedString
  }
}

// MARK: - NavigationBar Pop Confirmation

extension EditViewController: NavigationPopConfirmation {
  func confirmNavigationPop(performPop: @escaping () -> Void) {
    let newMD = self.imageMetaDataFromForm()
    // FIXME: ⚠️ The real thing we want to do is compare the whole struct with Equatable
    guard newMD.title != self.imageMetaData?.title else {
      // No difference, so allow to pop
      performPop()
      return
    }

    // There has been changes, so ask confirmation first
    
    let imageTitle = self.imageMetaData?.title ?? ""
    // FIXME: String-based API 😱
    let format = NSLocalizedString("edit.alert.message", comment: "")
    // FIXME: 😱 You can use any argument in String(format:) even non-matching ones 😕💣
    let message = String(format: format, imageTitle)

    // FIXME: String-based API everywhere 😱
    showAlert(
      title: NSLocalizedString("edit.alert.title", comment: ""),
      message: message,
      defaultButton: NSLocalizedString("edit.alert.save", comment: ""),
      cancelButton: NSLocalizedString("edit.alert.dismiss", comment: ""),
      handler: { [unowned self] save in
        if (save) {
          let newImageMetaData = self.imageMetaDataFromForm()
          self.saveMetaData(newImageMetaData)
        }
        performPop()
      }
    )
  }
}
