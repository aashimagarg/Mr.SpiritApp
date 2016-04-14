//
//  Candidate.swift
//  Mr. Spirit
//
//  Created by Laura Artiles on 3/24/16.
//  Copyright © 2016 Aashima Garg. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Candidate {
    var candidateRef:Firebase!
    var name:String=""
    var organization:String=""
    var bio:String=""
    var votes:Int = 0
    var headshot:UIImage=UIImage(named:"WillFerrel")!
    var detailPhoto:UIImage=UIImage(named:"Bowtie Icon")!
    var amountRaised:Double
    
    // MARK: Initialization
    
    init(name: String, organization:String, bio:String, votes:Int, amountRaised:Double, headshot:UIImage, detailPhoto: UIImage) {
        // Initialize stored properties.
        self.name = name
        self.organization = organization
        self.bio = bio
        self.votes = votes
        self.amountRaised = amountRaised
        self.headshot = headshot
        self.detailPhoto = detailPhoto
    }
    
    convenience init() {
        self.init(name: "<NoName>", organization:"", bio:"", votes:0, amountRaised: 0, headshot:UIImage(named:"Bowtie Icon")!, detailPhoto: UIImage(named:"Bowtie Icon")!)
    }
    
    // Formats candidate data as dictionary for DB use
    func toDict()-> AnyObject {
        return [
            "name": name,
            "organization": organization,
            "bio": bio,
            "votes":votes,
            "amountRaised":amountRaised
        ]
    }
    
    func getFirstName() -> String {
        return name.componentsSeparatedByString(" ").first!
    }
    
    func getVoteCount(name:String, ref:Firebase) -> Int {
        let childRef = ref.childByAppendingPath(name)
        var votes:Int = 0
        
        childRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            votes = (snapshot.value.objectForKey("votes") as? Int)!
        })
        return votes
    }
    
    func getAmountRaised(name:String, ref:Firebase) -> Double {
        let childRef = ref.childByAppendingPath(name)
        var amountRaised:Double = 0.0
        
        childRef.observeSingleEventOfType(.Value, withBlock: { snapshot in
            amountRaised = (snapshot.value.objectForKey("amountRaised") as? Double)!
        })
        return amountRaised
    }
    
    func saveRef(name:String, dict:AnyObject, ref:Firebase) {
        self.candidateRef = ref.childByAppendingPath(self.name)
    }
}
