//
//  Candidate.swift
//  Mr. Spirit
//
//  Created by Laura Artiles on 3/24/16.
//  Copyright © 2016 Aashima Garg. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class Candidate {
    var candidateRef:FIRDatabaseReference!
    var name:String=""
    var organization:String=""
    var bio:String=""
    var votes:Int = 0
    var headshot:UIImage=UIImage(named:"WillFerrel")!
    var detailPhoto:UIImage=UIImage(named:"Bowtie Icon")!
    var amountRaised:Double
    var year:String=""
    
    // MARK: Initialization
    
    init(name: String, organization:String, bio:String, votes:Int, amountRaised:Double, headshot:UIImage, detailPhoto: UIImage, year:String) {
        // Initialize stored properties.
        self.name = name
        self.organization = organization
        self.bio = bio
        self.votes = votes
        self.amountRaised = amountRaised
        self.headshot = headshot
        self.detailPhoto = detailPhoto
        self.year = year
    }
    
    convenience init() {
        self.init(name: "<NoName>", organization:"", bio:"", votes:0, amountRaised: 0, headshot:UIImage(named:"Bowtie Icon")!, detailPhoto: UIImage(named:"Bowtie Icon")!, year:"")
    }
    
    // Formats candidate data as dictionary for DB use excluding year
    func toDict()-> NSDictionary {
        return [
            "name": name,
            "organization": organization,
            "bio": bio,
            "votes":votes,
            "amountRaised":amountRaised
        ]
    }
    
    func getFirstName() -> String {
        return name.components(separatedBy: " ").first!
    }
    
    func getVoteCount(_ name:String, ref:FIRDatabaseReference) -> Int {
        let childRef = ref.child(name)
        var votes:Int = 0
        
        childRef.observeSingleEvent(of: .value, with: { snapshot in
            let value = snapshot.value as? NSDictionary
            votes = value?["votes"] as? Int ?? 0
        })
        return votes
    }
    
    func getAmountRaised(_ name:String, ref:FIRDatabaseReference) -> Double {
        let childRef = ref.child(name)
        var amountRaised:Double = 0.0
        
        childRef.observeSingleEvent(of: .value, with: { snapshot in
            let value = snapshot.value as? NSDictionary
            amountRaised = value?["amountRaised"] as? Double ?? 0
         })
        return amountRaised
    }
    
    func saveRef(_ name:String, dict:AnyObject, ref:FIRDatabaseReference) {
        self.candidateRef = ref.child(self.name)
    }
}
