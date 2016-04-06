//
//  CompleteCardView.swift
//  FamilyHistoryPrimer
//
//  Created by John M Clark on 4/6/16.
//  Copyright © 2016 Treehub. All rights reserved.
//

import UIKit

class CompleteCardView: SectionCardView {
    @IBOutlet weak var completeLabel: UILabel!
    
    var messages: [String] = [
        "Good Show!",
        "Good Job",
        "Excellent Work",
        "Nice \\o/"
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        didLoad()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        didLoad()
    }
    
    func didLoad() {
        let xibView = NSBundle.mainBundle().loadNibNamed("CompleteCard", owner: self, options: nil)[0] as! UIView
        xibView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: self.frame.size)
        xibView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        self.addSubview(xibView)
        
        completeLabel.text = messages[Int(arc4random_uniform(UInt32(messages.count)))]
    }
    
}
