//
//  TextSectionCardView.swift
//  FamilyHistoryPrimer
//
//  Created by John M Clark on 3/9/16.
//  Copyright © 2016 Treehub. All rights reserved.
//

import UIKit

class TextSectionCardView: SectionCardView {
    @IBOutlet weak var contentView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        didLoad()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        didLoad()
    }
    
    func didLoad() {
        let xibView = NSBundle.mainBundle().loadNibNamed("TextSectionCard", owner: self, options: nil)[0] as! UIView
        xibView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: self.frame.size)
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

}
