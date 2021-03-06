//
//  EditViewController.swift
//  CodeGenDemo
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
    self.title = tr(.editScreenTitle)

    let mappings: [UILabel: L10n] = [
      titleLabel: L10n.editFieldsTitle,
      authorLabel: L10n.editFieldsAuthor,
      kindLabel: L10n.editFieldsKind,
      tagsLabel: L10n.editFieldsTags,
      dateLabel: L10n.editFieldsDate,
    ]

    for (label, l10n) in mappings {
      label.text = l10n.string
    }
  }

  private func format(date: Date) -> String {
    return DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .short)
  }

  private func fillForm() {
    guard let info = self.imageMetaData else { return }
    self.titleField.text = info.title
    self.authorField.text = info.author
    let row = ImageKind.allCases.index(of: info.kind) ?? 0
    self.kindPicker.selectRow(row, inComponent: 0, animated: false)
    self.tagsField.text = info.tags.joined(separator: " ")
    self.dateField.text = format(date: info.date)
    self.datePicker.date = info.date
  }

  fileprivate func imageMetaDataFromForm() -> ImageMetaData {
    return ImageMetaData(
      title: self.titleField.text ?? "",
      author: self.authorField.text ?? "",
      date: self.datePicker.date,
      tags: ImageMetaData.tags(from: self.tagsField.text ?? ""),
      kind: ImageKind.allCases[self.kindPicker.selectedRow(inComponent: 0)]
    )
  }
}

// MARK: - UIPickerView

extension EditViewController: UIPickerViewDataSource, UIPickerViewDelegate {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return ImageKind.allCases.count
  }
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return ImageKind.allCases[row].localizedString
  }
}

// MARK: - NavigationBar Pop Confirmation

extension EditViewController: NavigationPopConfirmation {
  func confirmNavigationPop(performPop: @escaping () -> Void) {
    let newMD = self.imageMetaDataFromForm()
    guard newMD != self.imageMetaData else {
      // No difference, so allow to pop
      performPop()
      return
    }

    // There has been changes, so ask confirmation first
    
    let imageTitle = self.imageMetaData?.title ?? ""
    let message = tr(.editAlertMessage(imageTitle))

    showAlert(
      title: tr(.editAlertTitle),
      message: message,
      defaultButton: tr(.editAlertSave),
      cancelButton: tr(.editAlertDismiss),
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
