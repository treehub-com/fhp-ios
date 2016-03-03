//
//  Category.swift
//  FamilyHistoryPrimer
//
//  Created by John M Clark on 3/3/16.
//  Copyright © 2016 Treehub. All rights reserved.
//

import SwiftyJSON

class Category {
    
    var title: String
    
    init(category: JSON) {
        self.title = category["title"].stringValue
    }
}
