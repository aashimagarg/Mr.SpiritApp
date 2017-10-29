//
//  AboutUsViewController.swift
//  Mr. Spirit
//
//  Created by Aashima Garg on 3/24/16.
//  Copyright © 2016 Aashima Garg. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {
  
  @IBOutlet weak var urlText: UIButton!
  @IBOutlet weak var aboutUsImage: UIImageView!
  @IBOutlet weak var pageantText: UILabel!
    @IBOutlet weak var daisyHolland: UIImageView!
    @IBOutlet weak var haydenKorsmo: UIImageView!
  @IBOutlet weak var mariaBenson: UIImageView!
  @IBOutlet weak var buyTicketsLabel: UILabel!
  @IBOutlet weak var philanthropyText: UILabel!
  @IBOutlet weak var buttonText: UIButton!
  
  @IBAction func butttonClicked(_ sender: AnyObject) {
    let url = URL(string: "https://www.mrspiritpageantshow.splashthat.com")
    UIApplication.shared.openURL(url!)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    aboutUsImage.image = UIImage(named: "group")
    haydenKorsmo.image = UIImage(named: "host1")
    mariaBenson.image = UIImage(named: "host2")
    daisyHolland.image = UIImage(named: "Daisy Holland")
    
    let aboutText = "Texas Spirits is an honorary spirit, service, and social organization at the University of Texas at Austin. The Mr. Spirit Pageant Show began three years ago as an initiative to raise money for Texas Spirits’ two philanthropies: Make-A-Wish Foundation and Saint Louise House."
    let philText = "The Make-A-Wish Foundation grants wishes to children with life-threatening medical conditions. Since its founding in 1980, the Make-A-Wish foundation has granted over 180,000 wishes and currently grants a wish every 40 minutes.\n\nSaint Louise House provides housing and services to homeless women and children in Austin, in an effort to help families stay together and encourage self-sufficiency. Saint Louise House has housed 130 families since 2012."
    
    buyTicketsLabel.text = "Purchase tickets at:"
    urlText.setTitle("www.mrspiritpageantshow.splashthat.com", for: .normal)
    
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = NSTextAlignment.justified
    pageantText.attributedText = NSAttributedString(string: aboutText, attributes: [NSParagraphStyleAttributeName: paragraphStyle, NSBaselineOffsetAttributeName: NSNumber(value: 0 as Float)])
    
    philanthropyText.attributedText = NSAttributedString(string: philText, attributes: [NSParagraphStyleAttributeName: paragraphStyle, NSBaselineOffsetAttributeName: NSNumber(value: 0 as Float)])
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
