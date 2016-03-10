//
//  LessonViewController.swift
//  FamilyHistoryPrimer
//
//  Created by John M Clark on 3/9/16.
//  Copyright © 2016 Treehub. All rights reserved.
//

import UIKit

class LessonViewController: UIViewController {
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var contentView: UIView!
    
    weak var lesson: Lesson!
    var sectionCards: [SectionCardView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navItem.title = lesson.title
        
        let top = (contentView.frame.height - 400) * 0.5
        
        for (i, section) in lesson.sections.enumerate() {
            let frame = CGRect(x: 0.0, y: CGFloat(i)*7.0 + top, width: 300.0, height: 400.0)
            switch(section.type) {
            case "text":
                let card = TextSectionCardView(frame: frame)
                sectionCards.append(card)
                break
            case "yes-no":
                let card = YesNoSectionCardView(frame: frame)
                sectionCards.append(card)
                break
            case "challenge":
                let card = ChallengeSectionCardView(frame: frame)
                sectionCards.append(card)
            default:
                break
            }
        }
        
        for card in sectionCards.reverse() {
            contentView.addSubview(card)
        }

    }
    
    override func viewDidLayoutSubviews() {
        //print("viewDidLayoutSubviews")
    }
}
