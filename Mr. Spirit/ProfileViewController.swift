//
//  ProfileViewController.swift
//  Mr. Spirit
//
//  Created by Aashima Garg on 3/24/16.
//  Copyright © 2016 Aashima Garg. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var modelImage: UIImageView!
    @IBOutlet weak var bioText: UILabel!
    @IBOutlet weak var voteButton: UIButton!
    @IBOutlet weak var donateButton: UIButton!
    var candidate:Candidate? = Candidate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        voteButton.layer.cornerRadius = 5.0;
        donateButton.layer.cornerRadius = 5.0;
        getCandidateInfo()

        // Do any additional setup after loading the view.
    }
    @IBAction func voteBttnClicked(sender: AnyObject) {
        voteButton.setTitle("Voted", forState: .Normal)
        // TO DO: 
        // Change color button if voted
        // Allocate vote to correct person
    }
    
    func getCandidateInfo(){
        // Get candidate image
        let image = UIImage(named:"Bowtie Icon")
        modelImage.image = image
        
        // Get candidate bio
        bioText.text = candidate!.name
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
