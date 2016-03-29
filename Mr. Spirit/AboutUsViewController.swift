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
        let image = UIImage(named: "grouppic")!
        aboutUsImage.image = image
        aboutUsText.text = "\tLorem ipsum dolor sit amet, eu nibh semper albucius eam, eos stet ancillae in. Id nec munere definiebas, possit definiebas eu cum, sint audiam elaboraret mel ex. Moderatius percipitur inciderint mea cu. Cum vidit iracundia no, natum voluptatibus his ne. Per ignota placerat cu, ei cibo philosophia eam. \n\tSimul menandri vim ut, ut mel antiopam oportere hendrerit. Lorem mediocrem voluptatibus pri at. Ea voluptua conclusionemque vim, ei sit saepe civibus, est electram adolescens ne."
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
