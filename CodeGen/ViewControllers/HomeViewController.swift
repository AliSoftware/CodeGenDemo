//
//  ViewController.swift
//  CodeGen
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
    // FIXME: 😱 String-based API, prone to errors
    "Avenir-Black", "Avenir-Italique", "Avenir-Light" // Whoops, wrong postscript name 😕
    ].map({ UIFont(name: $0, size: 18) })

  private lazy var currentFontIndex = 0

  // MARK: Setup

  override func viewDidLoad() {
    super.viewDidLoad()

    let country = Locale.current.localizedString(forRegionCode: "hu") ?? "Magyarország"

    // FIXME: 😱 String-based API, prone to errors
    let format = NSLocalizedString("home.greetings", comment: "")
    // FIXME: 😱 You can use any argument in String(format:) even non-matching ones 😕💣
    self.titleLabel.text = String(format: format, "NSBudapest", 1, country)

    self.titleLabel.font = fonts[currentFontIndex]

    // FIXME: 😱 String-based API, prone to errors
    self.imageView.image = UIImage(named: "NSBudapest")

    // FIXME: 😱 String-based API, prone to errors
    let btnTitle = NSLocalizedString("home.slideshow", comment: "")
    self.slideshowButton.setTitle(btnTitle, for: .normal)

  }

  // MARK: IBActions

  @IBAction func cycleFonts() {
    currentFontIndex += 1
    if currentFontIndex > fonts.count - 1 { currentFontIndex = 0 }
    self.titleLabel.font = fonts[currentFontIndex]
  }

  @IBAction func presentSlideShow() {
    // FIXME: 😱 String-based API, will crash if typo 💣
    let sb = UIStoryboard(name: "Photos", bundle: nil)
    // FIXME: 😱 String-based API, will crash if typo 💣
    guard let vc = sb.instantiateInitialViewController() as? SlideShowViewController else {
      fatalError("The storyboard's initialVC isn't a SlideShowViewController")
    }
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
