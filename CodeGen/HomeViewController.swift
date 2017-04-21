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
    "Avenir-Black", "Avenir-Italique", "Avenir-Light" // Whoops, wrong postscript name 😕
  ].map({ UIFont(name: $0, size: 18) })

  private lazy var currentFontIndex = 0

  // MARK: Setup

  override func viewDidLoad() {
    super.viewDidLoad()

    let country = Locale.current.localizedString(forRegionCode: "hu") ?? "Magyarországon"

    // String-based API for Localizable Strings 😕 What if I mistype the key?
    let format = NSLocalizedString("greeting", comment: "")
    // You can use any argument in String(format:) even non-matching ones 😕💣
    self.titleLabel.text = String(format: format, 1, "NSBudapest", country)

    // And another String-based API, error-prone to typos and mismatches between file name and postscript name 😕
    self.titleLabel.font = fonts[currentFontIndex]

    // And yet another one
    self.imageView.image = UIImage(named: "nsbudapest")

  }

  // MARK: IBActions

  @IBAction func cycleFonts() {
    currentFontIndex += 1
    if currentFontIndex > fonts.count - 1 { currentFontIndex = 0 }
    self.titleLabel.font = fonts[currentFontIndex]
  }

  @IBAction func presentSlideShow() {
    // String-based API again, and will crash if no Storyboard with this name 😕💣
    let sb = UIStoryboard(name: "SlideShowViewController", bundle: nil)
    // And has to force-cast (and will 💣 at runtime if inconsistent instead of being detected at compile-time)
    let vc = sb.instantiateInitialViewController() as! SlideShowViewController
    // Ok, Image literals made things a little better, but still not organized as groups and only for Bundle.main
    vc.images = [
      #imageLiteral(resourceName: "photos/Budapest-1"),
      #imageLiteral(resourceName: "photos/Budapest-2"),
      #imageLiteral(resourceName: "photos/Budapest-3"),
      #imageLiteral(resourceName: "photos/Budapest-4"),
      #imageLiteral(resourceName: "photos/Budapest-5")
    ]
    self.present(vc, animated: true)
  }
}
