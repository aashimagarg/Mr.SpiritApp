//
//  AboutUsViewController.swift
//  Mr. Spirit
//
//  Created by Aashima Garg on 3/24/16.
//  Copyright © 2016 Aashima Garg. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {
    
    @IBOutlet weak var aboutUsImage: UIImageView!
    @IBOutlet weak var pageantText: UILabel!
    @IBOutlet weak var haydenKorsmo: UIImageView!
    @IBOutlet weak var mariaBenson: UIImageView!
    @IBOutlet weak var kevinHelgren: UIImageView!
    @IBOutlet weak var binnaKim: UIImageView!
    @IBOutlet weak var malikJefferson: UIImageView!
    @IBOutlet weak var alexaGould: UIImageView!
    @IBOutlet weak var buyTicketsLabel: UILabel!
    @IBOutlet weak var philanthropyText: UILabel!
//    @IBOutlet weak var infoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
//        aboutUsImage.layer.cornerRadius = 10.0
//        aboutUsImage.clipsToBounds = true
        aboutUsImage.image = UIImage(named: "group")
        haydenKorsmo.image = UIImage(named: "host1")
        mariaBenson.image = UIImage(named: "host2")
        kevinHelgren.image = UIImage(named: "kevinHelgren")
        binnaKim.image = UIImage(named: "binnaKim")
        alexaGould.image = UIImage(named: "alexaGould")
        malikJefferson.image = UIImage(named: "malikJefferson")

        let aboutText = "Texas Spirits is an honorary spirit, service, and social organization at the University of Texas at Austin. The Mr. Spirit Pageant Show began three years ago as an initiative to raise money for Texas Spirits’ two philanthropies: Make-A-Wish Foundation and Saint Louise House."
        let philText = "The Make-A-Wish Foundation grants wishes to children with life-threatening medical conditions. Since its founding in 1980, the Make-A-Wish foundation has granted over 180,000 wishes and currently grants a wish every 40 minutes.\n\nSaint Louise House provides housing and services to homeless women and children in Austin, in an effort to help families stay together and encourage self-sufficiency. Saint Louise House has housed 130 families since 2012."
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.Justified
        pageantText.attributedText = NSAttributedString(string: aboutText, attributes: [NSParagraphStyleAttributeName: paragraphStyle, NSBaselineOffsetAttributeName: NSNumber(float: 0)])

        philanthropyText.attributedText = NSAttributedString(string: philText, attributes: [NSParagraphStyleAttributeName: paragraphStyle, NSBaselineOffsetAttributeName: NSNumber(float: 0)])
        
        buyTicketsLabel.attributedText = NSAttributedString(string: philText, attributes: [NSParagraphStyleAttributeName: paragraphStyle, NSBaselineOffsetAttributeName: NSNumber(float: 0)])

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
