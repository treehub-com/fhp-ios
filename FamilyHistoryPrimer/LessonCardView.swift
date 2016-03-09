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
    @IBOutlet weak var sectionCountLabel: UILabel!
    
    weak var lesson: Lesson!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let xibView = NSBundle.mainBundle().loadNibNamed("LessonCard", owner: self, options: nil)[0] as! UIView
        xibView.frame = self.frame
        xibView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        self.addSubview(xibView)

        let cardMaskPath = UIBezierPath(roundedRect: self.bounds,byRoundingCorners: .AllCorners, cornerRadii: CGSize(width: 10.0, height: 10.0))
        let cardMaskLayer = CAShapeLayer(layer: cardMaskPath)
        cardMaskLayer.frame = self.bounds
        cardMaskLayer.path = cardMaskPath.CGPath
        self.layer.mask = cardMaskLayer
        
        let contentMaskPath = UIBezierPath(roundedRect: contentView.bounds,byRoundingCorners: .AllCorners, cornerRadii: CGSize(width: 5.0, height: 5.0))
        let contentMaskLayer = CAShapeLayer(layer: contentMaskPath)
        contentMaskLayer.frame = contentView.bounds
        contentMaskLayer.path = contentMaskPath.CGPath
        contentView.layer.mask = contentMaskLayer
        
    }

    func layout() {
        lessonTitleLabel.text = lesson.title
        if (lesson.sections.count == 1) {
            sectionCountLabel.text = String(lesson.sections.count) + " section"
        } else {
            sectionCountLabel.text = String(lesson.sections.count) + " sections"
        }
    }
    
}
