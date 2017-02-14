//
//  CandidatesViewController.swift
//  Mr. Spirit
//
//  Created by Aashima Garg on 3/24/16.
//  Copyright © 2016 Aashima Garg. All rights reserved.
//

import UIKit
import Foundation
import FirebaseDatabase

class CandidatesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    let cellId:String = "CandidateCell"
    
    // Load database
//    var ref = Firebase(url:"httvar//mrspirit2016.firebaseio.com/candidates")
    var ref = FIRDatabase.database().reference()
    
    var candidatesList = [Candidate]()
    var candidateNames = ["Alec Garcia", "Andy Wallace", "Erik Solorzano", "Jonathan Stevenson", "Marc Castaneda", "Patrick Golden", "Payne Keinarth", "Ryan Howell", "Steven Aviles"]
    let candidateYear = ["Junior", "Junior", "Junior", "Senior", "Freshman", "Freshman", "Junior", "Sophomore", "Senior", "Sophomore", "Senior"]
    var candidateOrgs = ["Alpha Sigma Pi", "Delta Sigma Pi", "Texas THON", "Beta Upsilon Chi", "Texas 4000", "Texas Blazers", "Texas Iron Spikes", "Camp Texas","Camp Kesem"]
    let bioText = [ "My name is Alec \"rockhard\" because when I listen to rock, I go hard! I'm a junior biology major. I like Pina coladas, getting caught in the rain. I'm not into yoga.", "Andy is a third year Marketing and RTF dual-major from Colleyville, TX. He is very passionate about the filmography of Paul Newman, the music of Ralph Stanley, puns, and America's National Parks. He once tried to take a selfie with Mark Cuban, but Mark Cuban slapped the phone away from his face.", "On a venn diagram comparing Beyoncé and Erik Solorzano, \"Hails from H-town\" would be only one of the MANY things they have in common. As the cultured and worldly young man he is, Erik is finishing his senior year as an international relations major. He enjoys short walks on the beach, is always down for a late night visit to Pluckers, and on his most generous days is willing to share his plate of holy Mac and cheese.", "Jon Stevenson is a first year Mathematics major from Houston, Texas. In his free time, he enjoys being an over zealous dancer in various situations including but not limited to: baptisms, funerals, and even right now on stage. In the future, he'd like to put his otherwise useless math degree to use by being a teacher.", "Hello everyone, my name is Marc Castañeda and I am a third year Health Promotions major with a specialization in health fitness! I am a fun loving talkative person who determines  a friendship based on food. I love getting to know people so never be afraid to spark a conversation with me.", "My name is Patrick Thomas Golden, and I do not like spaghetti. High School Musical 1 had a great storyline and an awesome soundtrack, High School Musical 2 had a terrible storyline but a great soundtrack, and High School Musical 3 is not worth anyone's time. My favorite color is blue, and the egg came before the chicken. Hook em and I love you mom.", "Payne Keinarth is a Senior from Bastrop, TX and will be receiving his B.A. in History this May. His interests include music, sports, and spending time with friends. Starting this fall, Payne will study law at the University of Texas Law School.", "Hello. My name is Ryan Howell. My spirit animal is a meerkat. I'm glad that we are able to share this moment together and hope you have a wonderful day.", "Hi! My names Steven, I'm a Senior studying Mechanical Engineering. My likes include Buzzfeed videos, GOT, basketball, Taco Joint, and Barbarella nights before cover. My dislikes are Erik Solorzano."]
    
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
        var amountRaised:Double = 0
    
        for index in 0...8 {
            let detailPic = UIImage(named: candidateNames[index])!
            let pic = UIImage(named: "sq-\(candidateNames[index])")!
            
            // Get number of current votes
            votes = candidate.getVoteCount(candidateNames[index], ref: ref)
            amountRaised = candidate.getAmountRaised(candidateNames[index], ref: ref)
            
            // Create candidate object
            candidate = Candidate(name: candidateNames[index], organization:candidateOrgs[index], bio:bioText[index], votes: votes, amountRaised:amountRaised, headshot: pic, detailPhoto: detailPic, year: candidateYear[index])
           
            // Add to candidate list
            candidatesList+=[candidate]
            
            // Save candidate ref
            candidateDict = candidate.toDict()
            candidate.saveRef(candidate.name, dict: candidateDict, ref: ref)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return candidatesList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath) as! CandidateCell
        let candidate = candidatesList[indexPath.row]
        
        // Configure cell
        cell.nameLabel.text = candidate.name
        cell.orgLabel.text = candidate.organization
        cell.headshotImage.image = candidate.headshot
        
        return cell
    }
  
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profileSegue" {
            let indexPath:IndexPath? = self.tableView!.indexPathForSelectedRow
            
            // Get the destination view controller
            let detailVC:ProfileViewController = segue.destination as! ProfileViewController
            
            self.tableView.deselectRow(at: indexPath!, animated: false)
            // Pass in the selected object to the new view controller
            let candidate:Candidate = candidatesList[indexPath!.row]
            detailVC.candidate = candidate
        }
    }
}
