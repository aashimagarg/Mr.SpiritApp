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
    var candidateNames = ["Ryan Howell", "Erik Solórzano", "Patrick Golden", "Steven Aviles", "Marc Castaneda", "Elias Hinojosa", "Alec Garcia", "Andy Wallace", "Jonathan Stevenson", "Caleb Young"]
    var candidateOrgs = ["Camp Texas","Texas THON", "Texas Blazers", "Camp Kesem", "Camp Kesem", "Pi Kappa Phi", "Alpha Sigma Pi", "Delta Sigma Pi", "Beta Upsilon Chi", "Student African American Brotherhood"]
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
        let photo1 = UIImage(named: "default")!
        
        // Get number of current votes
        ref.observeEventType(.ChildChanged, withBlock: { snapshot in
            votes = (snapshot.value.objectForKey("votes") as? Int)!
        })
        
        for index in 0...9 {
            candidate = Candidate(name: candidateNames[index], organization:candidateOrgs[index], bio:"Hi, my name is \(candidateNames[index])", votes: votes, headshot: UIImage(named: "WillFerrel")!, detailPhoto: photo1)
           
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
        cell.nameLabel.text = candidate.name.uppercaseString
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
