//
//  LessonCardView.swift
//  FamilyHistoryPrimer
//
//  Created by John M Clark on 3/9/16.
//  Copyright © 2016 Treehub. All rights reserved.
//

import UIKit

class LessonCardView: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var lessonTitleLabel: UILabel!
    @IBOutlet weak var lessonSubtitleLabel: UILabel!
    @IBOutlet weak var lessonImageView: UIImageView!
    @IBOutlet weak var sectionCountLabel: UILabel!
    
    var xibView: UIView!
    weak var lesson: Lesson!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibView = NSBundle.mainBundle().loadNibNamed("LessonCard", owner: self, options: nil)[0] as! UIView
        xibView.frame = self.frame
        xibView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        self.addSubview(xibView)

        contentView.layer.shadowPath = UIBezierPath(rect: contentView.bounds).CGPath
        contentView.layer.shadowColor = UIColor.blackColor().CGColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 7)
        contentView.layer.shadowOpacity = 0.37
        contentView.layer.shadowRadius = 3
        contentView.layer.shouldRasterize = true
        
        contentView.backgroundColor = UIColor(patternImage: UIImage(named: "plaqueFront.png")!)
    }

    func layout() {
        lessonTitleLabel.text = lesson.title
        lessonTitleLabel.textColor = lesson.color
        lessonSubtitleLabel.text = lesson.subtitle
        lessonSubtitleLabel.textColor = lesson.color
        lessonImageView.image = lesson.img
        if (lesson.sections.count == 1) {
            sectionCountLabel.text = String(lesson.sections.count) + " section"
        } else {
            sectionCountLabel.text = String(lesson.sections.count) + " sections"
        }
        sectionCountLabel.textColor = lesson.color
    }
    
}
