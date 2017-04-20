//
//  ViewController.swift
//  CodeGen
//
//  Created by Olivier Halligon on 20/04/2017.
//  Copyright © 2017 AliSoftware. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var slideshowButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()
    // String-based API for Localizable Strings 😕
    let format = NSLocalizedString("greetings", comment: "")
    // You can use any argument in String(format:) even non-matching ones 😕💣
    self.titleLabel.text = String(format: format, "NSBudapest")
    // Ok, Image literals made things a little better, but still not organized as groups and only for Bundle.main
    self.imageView.image = #imageLiteral(resourceName: "NSBudapest")
  }

  @IBAction func presentSlideShow() {
    // String-based API again, and will crash if no Storyboard with this name 😕💣
    let sb = UIStoryboard(name: "SlideShowViewController", bundle: nil)
    // And has to force-cast (and will 💣 at runtime if inconsistent instead of being detected at compile-time)
    let vc = sb.instantiateInitialViewController() as! SlideShowViewController
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
