//
//  ViewController.swift
//  CodeGenDemo
//
//  Created by Olivier Halligon on 20/04/2017.
//  Copyright © 2017 AliSoftware. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

  // MARK: IBOutlets

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var slideshowButton: UIButton!

  // MARK: Private properties

  private let fonts = [
    FontFamily.Avenir.black,
    FontFamily.Avenir.oblique,
    FontFamily.Avenir.light,
    ].map({ $0.font(size: 18) })

  private lazy var currentFontIndex = 0

  // MARK: Setup

  override func viewDidLoad() {
    super.viewDidLoad()

    let country = Locale.current.localizedString(forRegionCode: "hu") ?? "Magyarország"

    self.titleLabel.text = L10n.homeGreetings("NSBudapest", 1, country).string

    self.titleLabel.font = fonts[currentFontIndex]

    self.imageView.image = UIImage(asset: .nsBudapest)

    let btnTitle = L10n.homeSlideshow.string
    self.slideshowButton.setTitle(btnTitle, for: .normal)

  }

  // MARK: IBActions

  @IBAction func cycleFonts() {
    currentFontIndex += 1
    if currentFontIndex > fonts.count - 1 { currentFontIndex = 0 }
    self.titleLabel.font = fonts[currentFontIndex]
  }

  @IBAction func presentSlideShow() {
    let vc = StoryboardScene.Photos.initialViewController()
    // Ok, Image literals made things a little better, but still not organized as groups and only for Bundle.main
    vc.images = [
      #imageLiteral(resourceName: "photos/Budapest-1"),
      #imageLiteral(resourceName: "photos/Budapest-2"),
      #imageLiteral(resourceName: "photos/Budapest-3"),
      #imageLiteral(resourceName: "photos/Budapest-4"),
      #imageLiteral(resourceName: "photos/Budapest-5")
      ].map { ($0, ImageMetaData()) }

    let nc = UINavigationController(rootViewController: vc)
    self.present(nc, animated: true)
  }
}
