//
//  ModuleCard.swift
//  FamilyHistoryPrimer
//
//  Created by John M Clark on 3/3/16.
//  Copyright © 2016 Treehub. All rights reserved.
//

import UIKit

class ModuleCardView: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var moduleTitleLabel: UILabel!
    @IBOutlet weak var moduleImageView: UIImageView!
    @IBOutlet weak var lessonNumberLabel: UILabel!

    var xibView: UIView!
    weak var module: Module!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibView = NSBundle.mainBundle().loadNibNamed("ModuleCard", owner: self, options: nil)[0] as! UIView
        xibView.frame = self.frame
        xibView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        self.addSubview(xibView)
        
        let cardMaskPath = UIBezierPath(roundedRect: xibView.bounds,byRoundingCorners: .AllCorners, cornerRadii: CGSize(width: 10.0, height: 10.0))
        let cardMaskLayer = CAShapeLayer(layer: cardMaskPath)
        cardMaskLayer.frame = xibView.bounds
        cardMaskLayer.path = cardMaskPath.CGPath
        xibView.layer.mask = cardMaskLayer

        let contentMaskPath = UIBezierPath(roundedRect: contentView.bounds,byRoundingCorners: .AllCorners, cornerRadii: CGSize(width: 5.0, height: 5.0))
        let contentMaskLayer = CAShapeLayer(layer: contentMaskPath)
        contentMaskLayer.frame = contentView.bounds
        contentMaskLayer.path = contentMaskPath.CGPath
        contentView.layer.mask = contentMaskLayer
        
    }
    
    func layout() {
        moduleTitleLabel.text = module.title
        moduleImageView.image = module.img
        xibView.backgroundColor = module.color
        switch module.lessons.count {
        case 0:
            lessonNumberLabel.text = ""
        case 1:
            lessonNumberLabel.text = String(module.lessons.count) + " lesson"
        default:
            lessonNumberLabel.text = String(module.lessons.count) + " lessons"
        }
    }

}
