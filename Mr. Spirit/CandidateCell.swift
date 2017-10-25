//
//  CandidateCell.swift
//  Mr. Spirit
//
//  Created by Aashima Garg on 3/24/16.
//  Copyright © 2016 Aashima Garg. All rights reserved.
//

import UIKit

class CandidateCell: UITableViewCell {
  
  // MARK: Properties
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var orgLabel: UILabel!
  @IBOutlet weak var headshotImage: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()      
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
    headshotImage.layer.cornerRadius = headshotImage.frame.size.width / 2
    headshotImage.clipsToBounds = true
  }
  
}
