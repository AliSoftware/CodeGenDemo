//
//  SlideShowViewController.swift
//  CodeGen
//
//  Created by Olivier Halligon on 20/04/2017.
//  Copyright © 2017 AliSoftware. All rights reserved.
//

import UIKit

class SlideShowViewController: UIViewController {
  @IBOutlet weak var previousButton: UIButton!
  @IBOutlet weak var nextButton: UIButton!
  @IBOutlet weak var imageView: UIImageView!

  var images: [UIImage] = []

  private var currentIndex = 0 {
    willSet {
      if newValue < 0 { self.currentIndex = 0 }
      if newValue > images.count-1 { self.currentIndex = images.count-1 }
    }
    didSet {
      updateUI()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.updateUI()
  }

  @IBAction func showPrevious() {
    self.currentIndex -= 1
  }

  @IBAction func showNext() {
    self.currentIndex += 1
  }

  @IBAction func close() {
    self.presentingViewController?.dismiss(animated: true)
  }

  private func updateUI() {
    self.imageView.image = images[self.currentIndex]
    self.previousButton.isEnabled = self.currentIndex > 0
    self.nextButton.isEnabled = self.currentIndex < self.images.count - 1
  }
}
