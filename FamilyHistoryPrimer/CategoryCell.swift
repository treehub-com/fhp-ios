//
//  CategoryCell.swift
//  FamilyHistoryPrimer
//
//  Created by John M Clark on 3/3/16.
//  Copyright © 2016 Treehub. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    @IBOutlet weak var moduleCollectionView: UICollectionView!

    weak var category: Category!
    
}

extension CategoryCell : UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.modules.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("moduleCell", forIndexPath: indexPath) as! ModuleCell
        
        cell.moduleCard.module = category.modules[indexPath.item]
        cell.moduleCard.layout()
        
        return cell
    }
    
}