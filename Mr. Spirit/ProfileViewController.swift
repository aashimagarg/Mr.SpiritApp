//
//  ProfileViewController.swift
//  Mr. Spirit
//
//  Created by Aashima Garg on 3/24/16.
//  Copyright © 2016 Aashima Garg. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    @IBOutlet weak var modelImage: UIImageView!
    @IBOutlet weak var bioText: UILabel!
    @IBOutlet weak var voteButton: UIButton!
    @IBOutlet weak var donateButton: UIButton!
    var candidate:Candidate? = Candidate()
    var ref = Firebase(url:"httvar//mrspirit2016.firebaseio.com/candidates/")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        voteButton.layer.cornerRadius = 5.0;
        donateButton.layer.cornerRadius = 5.0;
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if (defaults.boolForKey("hasVoted")) {
            voteButton.setTitle("Voted", forState: .Normal)
            voteButton.backgroundColor = UIColor(hexString: "#9E9EA5")
            voteButton.enabled = false
        }
        
        getCandidateInfo()

        // Do any additional setup after loading the view.
    }
    @IBAction func voteBttnClicked(sender: AnyObject) {
        // Update vote count
        candidate!.votes += 1
        let votesDict = ["votes":self.candidate!.votes]
        ref.updateChildValues(votesDict)
        
        // Update button
        voteButton.setTitle("Voted", forState: .Normal)
        voteButton.backgroundColor = UIColor(hexString: "#9E9EA5")
        voteButton.enabled = false
        
        //TO-DO: disable all others voting
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(true, forKey: "hasVoted")

    }
    
    func getCandidateInfo(){
        // Get candidate image
        modelImage.image = self.candidate?.detailPhoto
        
        // Get candidate bio
        bioText.text = self.candidate!.bio
        
        // Votes
        ref = ref.childByAppendingPath(candidate!.name)
        ref.observeEventType(.Value, withBlock: { snapshot in
            let votes = (snapshot.value.objectForKey("votes") as? Int)!
            self.candidate!.votes = votes
            }, withCancelBlock: { error in
                print(error.description)
        })
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
