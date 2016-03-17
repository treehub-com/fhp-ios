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
    var cards: [SectionCardView] = []
    
    // Placement Variables
    let xScale: CGFloat = 0.007
    let cardSpacing: CGFloat = 13.0
    var readOffset: CGFloat = -380
    var unreadOffset: CGFloat = 100
    
    // Pan Variables
    var readIndex = -1
    var unreadIndex = 0
    var initialPoint: CGPoint!
    var readInitialOrigin: CGPoint!
    var unreadInitialOrigin: CGPoint!
    var direction: Direction = .None
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navItem.title = lesson.title
        
        // If there are no sections don't bother doing anything
        if lesson.sections.count == 0 {
            return
        }

        unreadOffset = (self.view.frame.height - contentView.frame.origin.y - 400) * 0.5
        
        for (i, section) in lesson.sections.enumerate() {
            let frame = CGRect(x: 0.0, y: CGFloat(i)*cardSpacing + unreadOffset, width: 300.0, height: 400.0)
            let transform = CGAffineTransformMakeScale(1 - (xScale * CGFloat(i)), 1)
            switch(section.type) {
            case "text":
                let card = TextSectionCardView(frame: frame)
                card.section = section as! TextSection
                card.transform = transform
                cards.append(card)
                break
            case "yes-no":
                let card = YesNoSectionCardView(frame: frame)
                card.section = section as! YesNoSection
                card.transform = transform
                cards.append(card)
                break
            case "challenge":
                let card = ChallengeSectionCardView(frame: frame)
                card.section = section as! ChallengeSection
                card.transform = transform
                cards.append(card)
            default:
                break
            }
            
        }
        
        for card in cards.reverse() {
            contentView.addSubview(card)
            card.layout()
        }

        let pan = UIPanGestureRecognizer(target:self, action:"pan:")
        pan.maximumNumberOfTouches = 1
        pan.minimumNumberOfTouches = 1
        self.view.addGestureRecognizer(pan)
        
    }
    
    override func viewDidLayoutSubviews() {
        //print("viewDidLayoutSubviews")
    }
    
    func pan(rec:UIPanGestureRecognizer) {
        let point = rec.locationInView(self.view)
        
        switch rec.state {
        case .Began:
            //print("began")
            initialPoint = point
            if readIndex >= 0 {
                readInitialOrigin = cards[readIndex].frame.origin
            }
            if unreadIndex < cards.count {
                unreadInitialOrigin = cards[unreadIndex].frame.origin
            }
        case .Changed:
            //print("changed")
            let offsetY = initialPoint.y - point.y
            let offsetX = initialPoint.x - point.x
            if direction == .None {
                if (initialPoint.y - point.y) > 0 && unreadIndex < cards.count {
                    direction = .Up
                    contentView.bringSubviewToFront(cards[unreadIndex])
                } else if (initialPoint.y - point.y) < 0 && readIndex >= 0 {
                    direction = .Down
                    contentView.bringSubviewToFront(cards[readIndex])
                } else {
                    direction = .Invalid
                }
            }
            if direction == .Up {
                let actualOffset = max(offsetY, 0)
                var newOrigin = unreadInitialOrigin
                newOrigin.y = unreadInitialOrigin.y - actualOffset
                newOrigin.x = unreadInitialOrigin.x - offsetX
                cards[unreadIndex].frame.origin = newOrigin
            }
            if direction == .Down {
                let actualOffset = min(offsetY, 0)
                var newOrigin = readInitialOrigin
                newOrigin.y = readInitialOrigin.y - actualOffset
                newOrigin.x = unreadInitialOrigin.x - offsetX
                cards[readIndex].frame.origin = newOrigin
            }
        case .Ended:
            //print("ended")
            let offset = initialPoint.y - point.y
            let velocity = abs(rec.velocityInView(contentView).y)
            if direction == .Up {
                let card = self.cards[self.unreadIndex]
                if offset > 100 || velocity > 500 {
                    unreadIndex += 1
                    readIndex += 1
                    
                    var newOrigin = unreadInitialOrigin
                    newOrigin.y = readOffset
                    let shiftOffset = unreadIndex
                    
                    UIView.animateWithDuration(0.37, animations: {
                        card.frame.origin = newOrigin
                        var i = 0
                        for card in self.cards[shiftOffset..<self.cards.count] {
                            var newOrigin = card.frame.origin
                            newOrigin.y -= self.cardSpacing
                            card.frame.origin = newOrigin
                            card.transform = CGAffineTransformMakeScale(1 - (self.xScale * CGFloat(i)), 1)
                            i += 1
                        }
                    })
                } else {
                    let newOrigin = unreadInitialOrigin
                    UIView.animateWithDuration(0.37, animations: {
                        card.frame.origin = newOrigin
                    })
                }
            }
            if direction == .Down {
                let card = self.cards[self.readIndex]
                if offset < 100 || velocity > 500 {
                    unreadIndex -= 1
                    readIndex -= 1
                    
                    var newOrigin = readInitialOrigin
                    newOrigin.y = unreadOffset
                    let shiftOffset = unreadIndex + 1 // don't move the new top unread card
                    
                    UIView.animateWithDuration(0.37, animations: {
                        card.frame.origin = newOrigin
                        card.transform = CGAffineTransformMakeScale(1, 1)
                        var i = 1
                        for card in self.cards[shiftOffset..<self.cards.count] {
                            var newOrigin = card.frame.origin
                            newOrigin.y += self.cardSpacing
                            card.frame.origin = newOrigin
                            card.transform = CGAffineTransformMakeScale(1 - (self.xScale * CGFloat(i)), 1)
                            i += 1
                        }
                    })
                } else {
                    let newOrigin = readInitialOrigin
                    UIView.animateWithDuration(0.37, animations: {
                        card.frame.origin = newOrigin
                    })
                }
            }
            direction = .None
        case .Possible:
            print("possible")
        case .Cancelled:
            print("cancelled")
        case .Failed:
            print("failed")
        }
    }
}
