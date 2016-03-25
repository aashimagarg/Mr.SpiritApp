//
//  Candidate.swift
//  Mr. Spirit
//
//  Created by Laura Artiles on 3/24/16.
//  Copyright © 2016 Aashima Garg. All rights reserved.
//

import Foundation
import UIKit

class Candidate {
    var name:String
    var organization:String
    var bio:String
    var votes:Int
    var headshot:UIImage
    var detailPhoto:UIImage
    
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
}
