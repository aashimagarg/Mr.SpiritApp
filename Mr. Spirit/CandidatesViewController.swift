//
//  CandidatesViewController.swift
//  Mr. Spirit
//
//  Created by Aashima Garg on 3/24/16.
//  Copyright © 2016 Aashima Garg. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class CandidatesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    let cellId:String = "CandidateCell"
    
    // Load database
    var ref = Firebase(url:"httvar//mrspirit2016.firebaseio.com/candidates")
    
    var candidatesList = [Candidate]()
    var candidateNames = ["Alec Garcia", "Andy Wallace", "Caleb Young","Erik Solorzano", "Jonathan Stevenson", "Marc Castaneda", "Patrick Golden", "Ryan Howell", "Steven Aviles"]
    var candidateOrgs = ["Alpha Sigma Pi", "Delta Sigma Pi", "Student African American Brotherhood", "Texas THON", "Beta Upsilon Chi", "Texas 4000", "Texas Blazers", "Camp Texas","Camp Kesem"]
    // Need array of bios, photos
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load candidate data
        loadCandidates()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        self.view.addSubview(self.tableView)
    }
    
    func loadCandidates(){
        var candidate = Candidate()
        var candidateDict:AnyObject
        var votes:Int = 0
        let bioText = "Texas Spirits is an honorary spirit, service, and social organization at the University of Texas at Austin that strives to serve the University and the Austin community through its commitment to school spirit and philanthropic efforts. The Mr. Spirit Pageant Show began as an initiative to raise money for Texas Spirits’ two philanthropies: Make-A-Wish Foundation and Saint Louise House. This April, Texas Spirits is hosting its third annual Mr. Spirit, showcasing ten contestants from all over the UT Community! The Make-A-Wish Foundation is a nonprofit organization that serves to grant “wishes” to children with life-threatening medical conditions. Since its founding in 1980, the Make-A-Wish foundation has granted"
        // Get number of current votes
        ref.observeEventType(.ChildChanged, withBlock: { snapshot in
            votes = (snapshot.value.objectForKey("votes") as? Int)!
        })
        
        for index in 0...8 {
            let detailPic = UIImage(named: candidateNames[index])!
            let pic = UIImage(named: "sq-\(candidateNames[index])")!
            candidate = Candidate(name: candidateNames[index], organization:candidateOrgs[index], bio:bioText, votes: votes, headshot: pic, detailPhoto: detailPic)
           
            // Add to candidate list
            candidatesList+=[candidate]
            
            // Save to database
            candidateDict = candidate.toDict()
            candidate.saveData(candidate.name, dict: candidateDict, ref: ref)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return candidatesList.count
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(self.cellId, forIndexPath: indexPath) as! CandidateCell
        let candidate = candidatesList[indexPath.row]
        
        // Configure cell
        cell.nameLabel.text = candidate.name
        cell.orgLabel.text = candidate.organization
        cell.headshotImage.image = candidate.headshot
        
        
        
        return cell
    }
    


  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "profileSegue" {
            let indexPath:NSIndexPath? = self.tableView!.indexPathForSelectedRow
            
            // Get the destination view controller
            let detailVC:ProfileViewController = segue.destinationViewController as! ProfileViewController
            
            self.tableView.deselectRowAtIndexPath(indexPath!, animated: false)
            // Pass in the selected object to the new view controller
            let candidate:Candidate = candidatesList[indexPath!.row]
            detailVC.candidate = candidate

        }
    }

}
