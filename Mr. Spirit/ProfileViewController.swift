//
//  ProfileViewController.swift
//  Mr. Spirit
//
//  Created by Aashima Garg on 3/24/16.
//  Copyright © 2016 Aashima Garg. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Braintree
import SwiftyJSON

class ProfileViewController: UIViewController {

    @IBOutlet weak var orgName: UILabel!
    @IBOutlet weak var bioHeader: UILabel!
    @IBOutlet weak var modelImage: UIImageView!
    @IBOutlet weak var bioText: UILabel!
    @IBOutlet weak var voteButton: UIButton!
    @IBOutlet weak var donateButton: UIButton!
    var candidate:Candidate? = Candidate()
    var ref = FIRDatabase.database().reference()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        voteButton.layer.cornerRadius = 3
        voteButton.clipsToBounds = true
        
        donateButton.layer.cornerRadius = 3
        donateButton.clipsToBounds = true
        
        // Disable vote button if user has voted
        let defaults = UserDefaults.standard
        if (defaults.bool(forKey: "hasVoted")) {
            voteButton.setTitle("Voted", for: UIControlState())
            voteButton.backgroundColor = UIColor(hexString: "#9E9EA5")
            voteButton.isEnabled = false
        }
        
        getCandidateInfo()
    }
    
    func getCandidateInfo(){
        // Get candidate image
        modelImage.image = self.candidate?.detailPhoto
        
        // Get candidate bio header
        bioHeader.text = self.candidate!.name
        
        // Candidate bio, justfied
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.justified
        let attributedString = NSAttributedString(string: self.candidate!.bio, attributes: [NSParagraphStyleAttributeName: paragraphStyle, NSBaselineOffsetAttributeName: NSNumber(value: 0 as Float)])
        bioText.attributedText = attributedString
    }
    
    @IBAction func voteBttnClicked(_ sender: AnyObject) {
        // Display UIAlertView
        let alert_title = "Are you sure you want to vote for \(candidate!.getFirstName())?"
        let alert_message = "You can only vote for one candidate and you cannot change your vote."
        
        
        let alertController = UIAlertController(title: alert_title, message: alert_message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            // ...
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
//            let upvotesRef = Firebase(url: "httvar//mrspirit2016.firebaseio.com/candidates/\(self.candidate!.name)/votes")
            let upvotesRef = self.ref.child("candidates/(candidate.name)/votes").setValue(self.candidate!.name)
            upvotesRef.runTransactionBlock({
                (currentData: FIRMutableData) -> FIRTransactionResult in
                var value = currentData.value as? Int
                if (value == nil) {
                    value = 0
                }
                currentData.value = value! + 1
                print(currentData)
                print(currentData.value)
                return FTransactionResult.success(withValue: currentData)
            })
            
            // Update button
            self.voteButton.setTitle("Voted", for: UIControlState())
            self.voteButton.backgroundColor = UIColor(hexString: "#9E9EA5")
            self.voteButton.isEnabled = false
            
            // Disable all others voting
            let defaults = UserDefaults.standard
            defaults.set(true, forKey: "hasVoted")
            // ...
        }
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true) {
            // ...
        }
    }
    
    @IBAction func donateButtonClicked(_ sender: AnyObject) {
        let place = "https://mrspirit.site/donate/?name=\(candidate!.getFirstName().lowercased())"
        print(place)
        let url = URL(string: place)
        UIApplication.shared.openURL(url!)
    }
    
    func getVoteCount(){
        // Votes
        ref = ref.child(candidate!.name)
        ref.observeSingleEvent(of: .value, with: { snapshot in
            let value = snapshot.value as? NSDictionary
            let votes = value?["votes"] as? Int ?? 0
            self.candidate!.votes = votes
            }) { (error) in
                print(error.localizedDescription)
        }
    }
    
    func getAmountRaised() {
        ref = ref.child(candidate!.name)
        ref.observeSingleEvent(of: .value, with: { snapshot in
            let value = snapshot.value as? NSDictionary
            let amountRaised = value?["amountRaised"] as? Double ?? 0
            self.candidate!.amountRaised = amountRaised
            }) { error in
                print(error.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
