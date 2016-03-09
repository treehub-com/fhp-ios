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
    
    weak var lesson: Lesson!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navItem.title = lesson.title
    }
}
