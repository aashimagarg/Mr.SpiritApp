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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let image = UIImage(named: "group")!
        aboutUsImage.layer.cornerRadius = 10.0
        aboutUsImage.clipsToBounds = true
        aboutUsImage.image = image
        aboutUsText.text = "The Mr. Spirit Pageant Show began as an initiative to raise money for Texas Spirits’ two philanthropies: Make-A-Wish Foundation and Saint Louise House. This April, Texas Spirits is hosting its third annual Mr. Spirit, showcasing ten contestants from all over the UT Community!"
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
