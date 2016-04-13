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
    @IBOutlet weak var aboutUsText: UILabel!
    @IBOutlet weak var philanthropyText: UILabel!
    @IBOutlet var infoView: UIView!
    
    @IBOutlet weak var hostImage1: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
//    @IBOutlet weak var infoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let image = UIImage(named: "group")!
//        aboutUsImage.layer.cornerRadius = 10.0
//        aboutUsImage.clipsToBounds = true
        aboutUsImage.image = image
        aboutUsText.text = "Texas Spirits is an honorary spirit, service, and social organization at the University of Texas at Austin. The Mr. Spirit Pageant Show began three years ago as an initiative to raise money for Texas Spirits’ two philanthropies: Make-A-Wish Foundation and Saint Louise House."
        philanthropyText.text = "The Make-A-Wish Foundation grants wishes to children with life-threatening medical conditions. Since its founding in 1980, the Make-A-Wish foundation has granted over 180,000 wishes and currently grants a wish every 40 minutes.\n\nSaint Louise House provides housing and services to homeless women and children in Austin, in an effort to help families stay together and encourage self-sufficiency. Saint Louise House has housed 130 families since 2012."
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
