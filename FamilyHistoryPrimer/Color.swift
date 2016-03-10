//
//  Color.swift
//  FamilyHistoryPrimer
//
//  Created by John M Clark on 3/10/16.
//  Copyright © 2016 Treehub. All rights reserved.
//

import UIKit

struct Color {
    static func fromHexString(hexString: String, alpha:CGFloat? = 1.0) -> UIColor {
        
        // Convert hex string to an integer
        var hexInt32: UInt32 = 0
        // Create scanner
        let scanner: NSScanner = NSScanner(string: hexString)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = NSCharacterSet(charactersInString: "#")
        // Scan hex value
        scanner.scanHexInt(&hexInt32)
        let hexInt = Int(hexInt32)
        let red = CGFloat((hexInt & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexInt & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexInt & 0xff) >> 0) / 255.0
        let alpha = alpha!
        
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
}