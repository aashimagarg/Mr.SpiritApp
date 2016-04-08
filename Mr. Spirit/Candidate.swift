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
    var name:String=""
    var organization:String=""
    var bio:String=""
    var votes:Int = 0
    var headshot:UIImage=UIImage(named:"Bowtie Icon")!
    var detailPhoto:UIImage=UIImage(named:"Bowtie Icon")!
    
    // MARK: Initialization
    
    init(name: String, organization:String, bio:String, votes:Int, headshot:UIImage, detailPhoto: UIImage) {
        // Initialize stored properties.
        self.name = name
        self.organization = organization
        self.bio = bio
        self.votes = votes
        self.headshot = headshot
        self.detailPhoto = detailPhoto
    }
    convenience init() {
        self.init(name: "", organization:"", bio:"", votes:0, headshot:UIImage(named:"Bowtie Icon")!, detailPhoto: UIImage(named:"Bowtie Icon")!)
    }
    func toDict()-> AnyObject {
        return [
            "name": name,
            "organization": organization,
            "bio": bio,
            "votes":votes
        ]
    }
}
