//
//  EditViewController.swift
//  CodeGen
//
//  Created by Olivier Halligon on 22/04/2017.
//  Copyright © 2017 AliSoftware. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {

  // MARK: IBOutlets

  @IBOutlet private weak var titleLabel: UILabel!
  @IBOutlet private weak var titleField: UITextField!
  @IBOutlet private weak var authorLabel: UILabel!
  @IBOutlet private weak var authorField: UITextField!
  @IBOutlet private weak var dateLabel: UILabel!
  @IBOutlet private weak var dateField: UILabel!
  @IBOutlet private weak var datePicker: UIDatePicker!
  @IBOutlet private weak var tagsLabel: UILabel!
  @IBOutlet private weak var tagsField: UITextField!

  // MARK: Properties

  var imageMetaData: ImageMetaData?
  var saveMetaData: (ImageMetaData) -> Void = { _ in }

  // MARK: Setup

  override func viewDidLoad() {
    super.viewDidLoad()
    translateUI()
    fillForm()
  }

  // MARK: IBActions

  @IBAction private func dateChanged(_ sender: UIDatePicker) {
    self.dateField.text = format(date: sender.date)
  }

  // MARK: Prvate methods

  private func translateUI() {
    self.title = NSLocalizedString("edit.screenTitle", comment: "")

    let mappings = [
      titleLabel: "edit.fields.title",
      authorLabel: "edit.fields.author",
      dateLabel: "edit.fields.date",
      tagsLabel: "edit.fields.tags"
    ]

    for (label, key) in mappings {
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
    self.dateField.text = format(date: info.date)
    self.tagsField.text = info.tags.joined(separator: " ")
  }

  fileprivate func imageMetaDataFromForm() -> ImageMetaData {
    return ImageMetaData(
      title: self.titleField.text ?? "",
      author: self.authorField.text ?? "",
      date: self.datePicker.date,
      tags: ImageMetaData.tags(from: self.tagsField.text ?? "")
    )
  }
}

protocol NavigationPopConfirmation {
  func confirmNavigationPop(performPop: @escaping () -> Void)
}

// Ask confirmation when going back if changes were made
extension UINavigationController: UINavigationBarDelegate {
  public func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
    if let vc = self.topViewController as? NavigationPopConfirmation {
      vc.confirmNavigationPop { [weak self] in
        DispatchQueue.main.async {
          self?.popViewController(animated: true)
        }
      }
      return false
    }
    return true
  }
}

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

    let alert = UIAlertController(
      // FIXME: String-based API 😱
      title: NSLocalizedString("edit.alert.title", comment: ""),
      message: message,
      preferredStyle: .alert
    )
    alert.addAction(UIAlertAction(
      // FIXME: String-based API 😱
      title: NSLocalizedString("edit.alert.save", comment: ""),
      style: .cancel,
      handler: { [unowned self] _ in
        let newImageMetaData = self.imageMetaDataFromForm()
        self.saveMetaData(newImageMetaData)
        performPop()
    }))
    alert.addAction(UIAlertAction(
      // FIXME: String-based API 😱
      title: NSLocalizedString("edit.alert.dismiss", comment: ""),
      style: .destructive,
      handler: { _ in performPop() }
    ))
    self.present(alert, animated: true)
  }
}
