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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCategories()
        
        navItem.title = "Family History: A Primer"
    }
    
    // Set insets appropriately
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Set categoryCollectionView top and bottom insets
        var insets = self.categoryCollectionView.contentInset
        let value = (self.categoryCollectionView.frame.height - (self.categoryCollectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize.height) * 0.5
        insets.top = value
        insets.bottom = value
        self.categoryCollectionView.contentInset = insets

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let moduleCell = sender as! ModuleCell
        let moduleView = segue.destinationViewController as! ModuleViewController
        moduleView.module = moduleCell.moduleCard.module
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
        let value = (self.categoryCollectionView.frame.width - (cell.moduleCollectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize.width) * 0.5
        insets.left = value
        insets.right = value
        cell.moduleCollectionView.contentInset = insets
        
        // TODO set the offset of each row
        
        return cell
        
    }
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout {
    
    // Make each cell the size of the view area
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(collectionView.bounds.width, (collectionViewLayout as! UICollectionViewFlowLayout).itemSize.height)
    }
}
