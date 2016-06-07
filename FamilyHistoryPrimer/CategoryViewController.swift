//
//  CategoryViewController.swift
//  FamilyHistoryPrimer
//
//  Created by John M Clark on 3/3/16.
//  Copyright © 2016 Treehub. All rights reserved.
//

import SwiftyJSON
import UIKit

class CategoryViewController: UIViewController {
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var categoryCollectionView: UICollectionView!

    var categories: [Category] = []
    var titleColor = Color.fromHexString("#000000", alpha: 0.73)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()

        navItem.title = categories[0].title

        // Set navigation text color
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: titleColor]
        self.navigationController?.navigationBar.tintColor = titleColor
    }
    
    // Invalidate any existing layout so we calculate new item sizes on device rotation (looking at you iPad)
    override func viewWillLayoutSubviews() {
        categoryCollectionView.collectionViewLayout.invalidateLayout()
        super.viewDidLayoutSubviews()
    }
    
    // Set insets appropriately
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Set categoryCollectionView top and bottom insets
        var insets = self.categoryCollectionView.contentInset
        let value = (self.categoryCollectionView.frame.width - (self.categoryCollectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize.width) * 0.5
        insets.left = value
        insets.right = value
        self.categoryCollectionView.contentInset = insets

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let moduleCell = sender as! ModuleCell
        let moduleView = segue.destinationViewController as! ModuleViewController
        moduleView.module = moduleCell.moduleCard.module
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        let moduleCell = sender as! ModuleCell
        if (moduleCell.moduleCard.module.lessons.count == 0) {
            return false
        } else {
            return true
        }
    }
    
    
    
    func loadCategories() {
        let path = NSBundle.mainBundle().pathForResource("learn", ofType: "json")
        let jsonData = NSData(contentsOfFile:path!)
        let json = JSON(data: jsonData!)
        let jsonCategories: Array<JSON> = json["categories"].arrayValue
        
        for category:JSON in jsonCategories {
            categories.append(Category(category: category))
        }
    }
}

extension CategoryViewController: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("categoryCell", forIndexPath: indexPath) as! CategoryCell

        cell.category = categories[indexPath.item]
        
        // Set moduleCollectionView top and bottom insets
        var insets = cell.moduleCollectionView.contentInset
        let value = (self.categoryCollectionView.frame.height - (cell.moduleCollectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize.height)
        insets.top = 16
        insets.bottom = value - 16
        cell.moduleCollectionView.contentInset = insets
        
        // Set the offset of each row
        cell.moduleCollectionView.contentOffset.y = cell.category.offset
        // Trigger a data reload
        cell.moduleCollectionView.reloadData()
        
        return cell
        
    }
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    
    // Make each cell the size of the view area
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake((collectionViewLayout as! UICollectionViewFlowLayout).itemSize.width, collectionView.bounds.height)
        //return CGSizeMake(collectionView.bounds.width, (collectionViewLayout as! UICollectionViewFlowLayout).itemSize.height)
    }
}

extension CategoryViewController: UIScrollViewDelegate {
    
    // Modify the Nav bar correctly for each section
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let adjustedOffset = categoryCollectionView.contentOffset.x + categoryCollectionView.contentInset.left
        let collectionViewFlowLayout = categoryCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemWidth = collectionViewFlowLayout.itemSize.width + collectionViewFlowLayout.minimumLineSpacing
        
        let currentIndex = Int(adjustedOffset / itemWidth);
        self.navItem.title = categories[currentIndex].title
    }
    
}
