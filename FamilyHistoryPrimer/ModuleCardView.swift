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
    @IBOutlet weak var moduleSubtitleLabel: UILabel!
    @IBOutlet weak var lessonNumberLabel: UILabel!

    var xibView: UIView!
    weak var module: Module!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibView = NSBundle.mainBundle().loadNibNamed("ModuleCard", owner: self, options: nil)[0] as! UIView
        xibView.frame = self.frame
        xibView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        self.addSubview(xibView)

        contentView.layer.shadowPath = UIBezierPath(rect: contentView.bounds).CGPath
        contentView.layer.shadowColor = UIColor.blackColor().CGColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 7)
        contentView.layer.shadowOpacity = 0.37
        contentView.layer.shadowRadius = 3
        contentView.layer.shouldRasterize = true
    }
    
    func layout() {
        moduleTitleLabel.text = module.title
        moduleTitleLabel.textColor = module.color
        moduleSubtitleLabel.text = module.subtitle
        moduleSubtitleLabel.textColor = module.color
        moduleImageView.image = module.img
        if (module.lessons.count == 1) {
            lessonNumberLabel.text = String(module.lessons.count) + " lesson"
        } else {
            lessonNumberLabel.text = String(module.lessons.count) + " lessons"
        }
        lessonNumberLabel.textColor = module.color
    }

}
