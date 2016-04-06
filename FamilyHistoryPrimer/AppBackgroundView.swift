//
//  AppBackgroundView.swift
//  FamilyHistoryPrimer
//
//  Created by John M Clark on 4/6/16.
//  Copyright © 2016 Treehub. All rights reserved.
//

import UIKit

class AppBackgroundView: UIView {
    override func drawRect(rect: CGRect) {
        // Background pattern from http://subtlepatterns.com/cheap-diagonal-fabric/
        let image = UIImage(named: "background.png")!
        let context = UIGraphicsGetCurrentContext()
        CGContextSetBlendMode(context, .Normal)
        CGContextDrawTiledImage(context, CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height), image.CGImage)
    }
}
