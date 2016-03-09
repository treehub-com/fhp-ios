//
//  ModuleViewController.swift
//  FamilyHistoryPrimer
//
//  Created by John M Clark on 3/9/16.
//  Copyright © 2016 Treehub. All rights reserved.
//

import UIKit

class ModuleViewController: UIViewController {
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var lessonCollectionView: UICollectionView!

    weak var module: Module!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navItem.title = module.title
    }
    
    // Set insets appropriately
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Set categoryCollectionView top and bottom insets
        var insets = self.lessonCollectionView.contentInset
        let topValue = (self.lessonCollectionView.frame.height - (self.lessonCollectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize.height) * 0.5
        insets.top = topValue
        insets.bottom = topValue
        let sideValue = (self.lessonCollectionView.frame.width - (self.lessonCollectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize.width) * 0.5
        insets.left = sideValue
        insets.right = sideValue

        self.lessonCollectionView.contentInset = insets
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let lessonCell = sender as! LessonCell
        let lessonView = segue.destinationViewController as! LessonViewController
        lessonView.lesson = lessonCell.lessonCard.lesson
    }
    
}

extension ModuleViewController : UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return module.lessons.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("lessonCell", forIndexPath: indexPath) as! LessonCell
        
        cell.lessonCard.lesson = module.lessons[indexPath.item]
        cell.lessonCard.layout()
        
        return cell
    }
    
}