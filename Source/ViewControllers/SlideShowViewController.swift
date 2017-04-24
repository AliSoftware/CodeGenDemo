//
//  SlideShowViewController.swift
//  CodeGenDemo
//
//  Created by Olivier Halligon on 20/04/2017.
//  Copyright © 2017 AliSoftware. All rights reserved.
//

import UIKit

class SlideShowViewController: UIViewController {

  // MARK: IBOutlets

  @IBOutlet private weak var previousButton: UIButton!
  @IBOutlet private weak var nextButton: UIButton!
  @IBOutlet private weak var imageView: UIImageView!

  // MARK: Public properties

  var images: [(image: UIImage, metaData: ImageMetaData)] = []

  // MARK: Private propertes

  private var currentIndex = 0 {
    willSet {
      if newValue < 0 { self.currentIndex = 0 }
      if newValue > self.images.count-1 { self.currentIndex = self.images.count-1 }
    }
    didSet {
      updateUI()
    }
  }

  // MARK: Setup

  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.leftBarButtonItem?.title = L10n.imageClose
    self.navigationItem.rightBarButtonItem?.title = L10n.imageEdit
    self.updateUI()
  }

  // MARK: IBActions

  @IBAction private func showPrevious() {
    self.currentIndex -= 1
  }

  @IBAction private func showNext() {
    self.currentIndex += 1
  }

  @IBAction private func close() {
    self.presentingViewController?.dismiss(animated: true)
  }

  @IBAction private func edit() {
    // FIXME: 📐 String-based API, will crash if typo 💣
    let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditVC")
    guard let editVC = vc as? EditViewController else { return }
    let currentImage = self.images[self.currentIndex]
    editVC.imageMetaData = currentImage.metaData
    editVC.saveMetaData = { newMetaData in
      self.images[self.currentIndex] = (currentImage.image, newMetaData)
    }
    self.navigationController?.pushViewController(editVC, animated: true)
  }

  // MARK: Private methods

  private func updateUI() {
    self.imageView.image = images[self.currentIndex].image
    self.previousButton.isEnabled = self.currentIndex > 0
    self.nextButton.isEnabled = self.currentIndex < self.images.count - 1
  }
}
