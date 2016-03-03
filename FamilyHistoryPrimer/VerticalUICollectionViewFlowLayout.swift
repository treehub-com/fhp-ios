//
//  VerticallyCenterUICollectionViewFlowLayout.swift
//  FamilyHistoryPrimer
//
//  Created by John M Clark on 3/3/16.
//  Copyright © 2016 Treehub. All rights reserved.
//

import UIKit

class VerticalUICollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {

        if let cv = self.collectionView {
            let topInset = cv.contentInset.top
            let itemHeight = self.itemSize.height
            let spacing = self.minimumLineSpacing
            let numberOfItems = cv.numberOfItemsInSection(0)
            let proposedOffset = proposedContentOffset.y + topInset + itemHeight/2

            var targetItem = 0;
            var targetDistance = Float.infinity
            
            for i in 0...numberOfItems-1 {
                let offset = (itemHeight + spacing)*CGFloat(i) + itemHeight/2
                let distance = fabsf(Float(offset - proposedOffset))
                if distance < targetDistance {
                    targetItem = i
                    targetDistance = distance
                }
            }
            let targetY = (itemHeight + spacing)*CGFloat(targetItem) - topInset
            
            //print("selected item: " + String(targetItem))
            //print("proposed:\(proposedContentOffset.y) - target:\(targetY)");
            return CGPoint(x: proposedContentOffset.x, y: targetY)
        }
        
        // fallback
        return super.targetContentOffsetForProposedContentOffset(proposedContentOffset)
    }
}
