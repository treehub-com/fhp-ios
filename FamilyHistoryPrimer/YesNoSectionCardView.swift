//
//  YesNoSectionCardView.swift
//  FamilyHistoryPrimer
//
//  Created by John M Clark on 3/9/16.
//  Copyright © 2016 Treehub. All rights reserved.
//

import UIKit

class YesNoSectionCardView: SectionCardView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var sectionTaskLabel: UILabel!
    @IBOutlet weak var questionsView: UIView!
    @IBOutlet weak var yesView: UIView!
    @IBOutlet weak var yesLabel: UILabel!
    @IBOutlet weak var noView: UIView!
    @IBOutlet weak var noLabel: UILabel!

    var section: YesNoSection!
    var questions: [UIView] = [];
    var completeLabel: UIView!
    
    let questionFontSize: CGFloat = 24.0
    let questionColor = Color.fromHexString("#008040")
    let correctLabelColor = Color.fromHexString("#000000")
    let correctBackgroundColor = Color.fromHexString("#008040", alpha: 0.73)
    let incorrectLabelColor = Color.fromHexString("#000000")
    let incorrectBackgroundColor = Color.fromHexString("#FF0000", alpha: 0.73)
    let activeLabelColor = Color.fromHexString("#000000")
    let activeBackgroundColor = Color.fromHexString("#CCCCCC", alpha: 0.73)
    let inactiveLabelColor = Color.fromHexString("#CCCCCC")
    let inactiveBackgroundColor = UIColor.clearColor()
    
    var currentQuestion: Int = 0
    var initialPoint: CGPoint!
    var initialOrigin: CGPoint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        didLoad()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        didLoad()
    }
    
    func didLoad() {
        let xibView = NSBundle.mainBundle().loadNibNamed("YesNoSectionCard", owner: self, options: nil)[0] as! UIView
        xibView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: self.frame.size)
        xibView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        self.addSubview(xibView)
        
        let cardMaskPath = UIBezierPath(roundedRect: xibView.bounds,byRoundingCorners: .AllCorners, cornerRadii: CGSize(width: 10.0, height: 10.0))
        let cardMaskLayer = CAShapeLayer(layer: cardMaskPath)
        cardMaskLayer.frame = xibView.bounds
        cardMaskLayer.path = cardMaskPath.CGPath
        xibView.layer.mask = cardMaskLayer
        
        self.layer.shadowPath = cardMaskPath.CGPath
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowOpacity = 0.37
        self.layer.shadowRadius = 2
        self.layer.shouldRasterize = true
        
        let contentMaskPath = UIBezierPath(roundedRect: contentView.bounds,byRoundingCorners: .AllCorners, cornerRadii: CGSize(width: 5.0, height: 5.0))
        let contentMaskLayer = CAShapeLayer(layer: contentMaskPath)
        contentMaskLayer.frame = contentView.bounds
        contentMaskLayer.path = contentMaskPath.CGPath
        contentView.layer.mask = contentMaskLayer
        
        contentView.backgroundColor = UIColor(patternImage: UIImage(named: "cardFront.png")!)
        
        let yesMaskPath = UIBezierPath(roundedRect: yesView.bounds,byRoundingCorners: .AllCorners, cornerRadii: CGSize(width: 3.0, height: 3.0))
        let yesMaskLayer = CAShapeLayer(layer: yesMaskPath)
        yesMaskLayer.frame = yesView.bounds
        yesMaskLayer.path = yesMaskPath.CGPath
        yesView.layer.mask = yesMaskLayer
        
        let noMaskPath = UIBezierPath(roundedRect: noView.bounds,byRoundingCorners: .AllCorners, cornerRadii: CGSize(width: 3.0, height: 3.0))
        let noMaskLayer = CAShapeLayer(layer: noMaskPath)
        noMaskLayer.frame = noView.bounds
        noMaskLayer.path = noMaskPath.CGPath
        noView.layer.mask = noMaskLayer
    }
    
    override func layout() {
        sectionTaskLabel.text = section.task
        let questionsViewHeight = questionsView.frame.height
        let questionHeight: CGFloat = 132.0
        let topOffset = (questionsViewHeight / 2) - (questionHeight / 2)
        
        for question in section.questions {
            let label = UILabel(frame: CGRectMake(0, 0, 264, questionHeight))
            label.text = question.question
            label.font = UIFont.systemFontOfSize(questionFontSize)
            label.textAlignment = .Center
            label.textColor = questionColor
            label.lineBreakMode = .ByWordWrapping
            label.numberOfLines = 3
            
            let view = UIView(frame: CGRectMake(0, topOffset, 264, questionHeight))
            view.addSubview(label)
            
            let pan = UIPanGestureRecognizer(target:self, action:#selector(YesNoSectionCardView.pan(_:)))
            pan.minimumNumberOfTouches = 1
            pan.maximumNumberOfTouches = 1
            view.addGestureRecognizer(pan)
            
            questions.append(view)
        }
        
        if questions.count > 0 {
            questionsView.addSubview(questions[0])
        }
        
        // Add all done text
        let label = UILabel(frame: CGRectMake(0, 0, 264, questionHeight))
        label.text = "Complete"
        label.font = UIFont.systemFontOfSize(questionFontSize)
        label.textAlignment = .Center
        label.textColor = inactiveLabelColor
        label.lineBreakMode = .ByWordWrapping
        label.numberOfLines = 3
        
        completeLabel = UIView(frame: CGRectMake(0, topOffset, 264, questionHeight))
        completeLabel.addSubview(label)
    }
    
    func pan(rec:UIPanGestureRecognizer) {
        let point = rec.locationInView(questionsView)
        switch rec.state {
        case .Began:
            // Store our initial points
            initialPoint = point
            initialOrigin = questions[currentQuestion].frame.origin
            
            // Make our targets active
            UIView.transitionWithView(yesLabel, duration: 0.13, options: .TransitionCrossDissolve, animations: {
                    self.yesLabel.textColor = self.activeLabelColor
                }, completion: { complete in})
            UIView.transitionWithView(noLabel, duration: 0.13, options: .TransitionCrossDissolve, animations: {
                self.noLabel.textColor = self.activeLabelColor
                }, completion: { complete in})
            UIView.animateWithDuration(0.13, animations: {
                self.yesView.backgroundColor = self.activeBackgroundColor
                self.noView.backgroundColor = self.activeBackgroundColor
            })
        case .Changed:
            // Cancel if we go out of bounds
            if point.x <= 0 || point.x >= questionsView.frame.width ||
                point.y <= 0 || point.y >= questionsView.frame.height {
                rec.enabled = false
                return
            }
            // Update the position of the question
            questions[currentQuestion].frame.origin = CGPoint(x: initialOrigin.x - (initialPoint.x - point.x),
                                                              y: initialOrigin.y - (initialPoint.y - point.y))
        case .Ended:
            // If we landed in the yes
            if CGRectContainsPoint(yesView.frame, point) {
                if section.questions[currentQuestion].answer == "yes" {
                    answerCorrect("yes")
                } else {
                    answerIncorrect("yes")
                }
            // If we landed in the no
            } else if CGRectContainsPoint(noView.frame, point) {
                if section.questions[currentQuestion].answer != "yes" {
                    answerCorrect("no")
                } else {
                    answerIncorrect("no")
                }
            // If we missed
            } else {
               answerMissed()
            }
        case .Possible:
            print("possible")
        case .Cancelled:
            // This happens when we disable the pan due to an out of bounds error
            answerMissed(point)
            rec.enabled = true
        case .Failed:
            print("failed")
        }
    }
    
    func answerMissed(point: CGPoint! = nil) {
        // Be nice and allow for dragging past to count for an answer
        
        // If yes
        if point != nil && point.y <= 0 {
            if section.questions[currentQuestion].answer == "yes" {
                answerCorrect("yes")
            } else {
                answerIncorrect("yes")
            }
        // If no
        } else if point != nil && point.y >= questionsView.frame.height {
            if section.questions[currentQuestion].answer != "yes" {
                answerCorrect("no")
            } else {
                answerIncorrect("no")
            }
        // We're just out of bounds at this point
        } else {
            UIView.transitionWithView(yesLabel, duration: 0.37, options: .TransitionCrossDissolve, animations: {
                self.yesLabel.textColor = self.inactiveLabelColor
                }, completion: { complete in})
            UIView.transitionWithView(noLabel, duration: 0.37, options: .TransitionCrossDissolve, animations: {
                self.noLabel.textColor = self.inactiveLabelColor
                }, completion: { complete in})
            UIView.animateWithDuration(0.37, animations: {
                self.questions[self.currentQuestion].frame.origin = self.initialOrigin
                self.yesView.backgroundColor = self.inactiveBackgroundColor
                self.noView.backgroundColor = self.inactiveBackgroundColor
            })
        }
    }
    
    func answerCorrect(answer: String) {
        // Add our new question in
        self.currentQuestion += 1
        if self.currentQuestion < self.questions.count {
            self.questions[self.currentQuestion].alpha = 0
            self.questionsView.addSubview(self.questions[self.currentQuestion])
        } else {
            //Complete
            completeLabel.alpha = 0
            questionsView.addSubview(completeLabel)
        }
        // Transition to correct background, fade out old question, fade in new question
        if answer == "yes" {
            UIView.transitionWithView(noLabel, duration: 0.37, options: .TransitionCrossDissolve, animations: {
                self.noLabel.textColor = self.inactiveLabelColor
                }, completion: { complete in
                    UIView.transitionWithView(self.yesLabel, duration: 0.37, options: .TransitionCrossDissolve, animations: {
                        self.yesLabel.textColor = self.inactiveLabelColor
                        }, completion: { complete in})
                })
        } else {
            UIView.transitionWithView(yesLabel, duration: 0.37, options: .TransitionCrossDissolve, animations: {
                self.yesLabel.textColor = self.inactiveLabelColor
                }, completion: { complete in
                    UIView.transitionWithView(self.noLabel, duration: 0.37, options: .TransitionCrossDissolve, animations: {
                        self.noLabel.textColor = self.inactiveLabelColor
                        }, completion: { complete in})
                })
        }
        UIView.animateWithDuration(0.37,
            animations: {
                self.questions[self.currentQuestion-1].alpha = 0
                if answer == "yes" {
                    self.yesView.backgroundColor = self.correctBackgroundColor
                    self.noView.backgroundColor = self.inactiveBackgroundColor
                } else {
                    self.noView.backgroundColor = self.correctBackgroundColor
                    self.yesView.backgroundColor = self.inactiveBackgroundColor
                }
            }, completion: { complete in
                self.questions[self.currentQuestion-1].removeFromSuperview()
                // Transition back to inactive background & fade in new question
                UIView.animateWithDuration(0.37,
                    animations: {
                        if self.currentQuestion < self.questions.count {
                            self.questions[self.currentQuestion].alpha = 1
                        } else {
                            // Complete
                            self.completeLabel.alpha = 1
                            self.yesView.alpha = 0
                            self.noView.alpha = 0
                        }
                        if answer == "yes" {
                            self.yesView.backgroundColor = self.inactiveBackgroundColor
                        } else {
                            self.noView.backgroundColor = self.inactiveBackgroundColor
                        }
                    })
            })
    }
    
    func answerIncorrect(answer: String) {
        if answer == "yes" {
            UIView.transitionWithView(noLabel, duration: 0.37, options: .TransitionCrossDissolve, animations: {
                self.noLabel.textColor = self.inactiveLabelColor
                }, completion: { complete in
                    UIView.transitionWithView(self.yesLabel, duration: 0.37, options: .TransitionCrossDissolve, animations: {
                        self.yesLabel.textColor = self.inactiveLabelColor
                        }, completion: { complete in})
            })
        } else {
            UIView.transitionWithView(yesLabel, duration: 0.37, options: .TransitionCrossDissolve, animations: {
                self.yesLabel.textColor = self.inactiveLabelColor
                }, completion: { complete in
                    UIView.transitionWithView(self.noLabel, duration: 0.37, options: .TransitionCrossDissolve, animations: {
                        self.noLabel.textColor = self.inactiveLabelColor
                        }, completion: { complete in})
            })
        }
        UIView.animateWithDuration(0.37,
            animations: {
                if answer == "yes" {
                    self.yesView.backgroundColor = self.incorrectBackgroundColor
                    self.noView.backgroundColor = self.inactiveBackgroundColor
                } else {
                    self.noView.backgroundColor = self.incorrectBackgroundColor
                    self.yesView.backgroundColor = self.inactiveBackgroundColor
                }
            }, completion: { complete in
                // Transition back to inactive background
                UIView.animateWithDuration(0.37,
                    animations: {
                        self.questions[self.currentQuestion].frame.origin = self.initialOrigin
                        if answer == "yes" {
                            self.yesView.backgroundColor = self.inactiveBackgroundColor
                        } else {
                            self.noView.backgroundColor = self.inactiveBackgroundColor
                        }
                })
        })
    }
}
