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
    
    
    
    var candidates = [Candidate]()
    var candidateNames = ["Ryan Howell", "Erik Solórzano", "Patrick Golden", "Steven Aviles", "Marc Castaneda", "Elias Hinojosa", "Alec Garcia", "Andy Wallace", "Jonathan Stevenson", "Caleb Young"]
    var candidateOrgs = ["Camp Texas","Texas THON", "Texas Blazers", "Camp Kesem", "Camp Kesem", "Pi Kappa Phi", "Alpha Sigma Pi", "Delta Sigma Pi", "Beta Upsilon Chi", "Student African American Brotherhood"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        self.view.addSubview(self.tableView)


        // Load candidate data
         loadCandidates()
    }
    
    func loadCandidates(){
        // Load Candidates
        var candidate = Candidate()
        var candidateDict:AnyObject
        
        let photo1 = UIImage(named: "default")!
        for index in 0...9 {
            candidate = Candidate(name: candidateNames[index], organization:candidateOrgs[index], bio:"This is a bio", votes: 0, headshot: photo1, detailPhoto: photo1)
            candidates+=[candidate]
            candidateDict = candidate.toDict()
            let candidatesRef = self.ref.childByAppendingPath(candidate.name)
            candidatesRef.setValue(candidateDict)
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
        return candidates.count
        
    }
    
  
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(self.cellId, forIndexPath: indexPath) as! CandidateCell

        // Fetch candidates
        let candidate = candidates[indexPath.row]
        
        cell.nameLabel.text = candidate.name.uppercaseString
        cell.orgLabel.text = candidate.organization
        cell.headshotImage.image = candidate.headshot
        
//        let destinationVC = ProfileViewController()
//        destinationVC.candidate = candidate
//        destinationVC.performSegueWithIdentifier("profileSegue", sender: self)

        return cell
    }
    


  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Do something for the ShowDetail segue
        if segue.identifier == "profileSegue" {
            
            let indexPath:NSIndexPath? = self.tableView!.indexPathForSelectedRow
            
            // Get the destination view controller
            let detailVC:ProfileViewController = segue.destinationViewController as! ProfileViewController
            
            // Pass in the selected object to the new view controller
            let cand:Candidate = candidates[indexPath!.row]
            detailVC.candidate = cand
//            detailVC.candidateRef = self.ref.childByAppendingPath(cand.name)
//            detailVC.suit = card.suit

        }
    }

}
