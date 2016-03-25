//
//  CandidatesViewController.swift
//  Mr. Spirit
//
//  Created by Aashima Garg on 3/24/16.
//  Copyright © 2016 Aashima Garg. All rights reserved.
//

import UIKit
import Foundation

class CandidatesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
//    var tableView:UITableView = UITableView()
    let cellId:String = "CandidateCell"
    
    var candidates = [Candidate]()
    
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
        ///////////
        // TO-DO//
        /////////
        
        
        // SAMPLE CANDIDATE
        let photo1 = UIImage(named: "Bowtie Icon")!
        let candidate1 = Candidate(name: "John Doe", organization:"Texas 4000", bio:"This is a bio", votes: 0, headshot: photo1, detailPhoto: photo1)
        
        candidates+=[candidate1]
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
//        print(cell.nameLabel)
        
        // Fetch candidates
        let candidate = candidates[indexPath.row]
        
        cell.nameLabel.text = candidate.name
        cell.orgLabel.text = candidate.organization
        cell.headshotImage.image = candidate.headshot

        return cell
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
