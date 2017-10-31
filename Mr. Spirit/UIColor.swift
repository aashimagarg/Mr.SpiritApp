//
//  UIColor.swift
//  Mr. Spirit
//
//  Created by Laura Artiles on 10/30/17.
//  Copyright © 2017 Aashima Garg. All rights reserved.
//

import UIKit

extension UIColor {
  convenience init?(string: String) {
    var cString = string.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    guard cString.hasPrefix("#"), cString.characters.count == 7 else {
      return nil
    }

    cString.remove(at: cString.startIndex)

    var rgbValue: UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)

    let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
    let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
    let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
    let alpha = CGFloat(1.0)

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}
