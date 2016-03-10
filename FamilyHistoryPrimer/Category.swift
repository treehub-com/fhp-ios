//
//  Category.swift
//  FamilyHistoryPrimer
//
//  Created by John M Clark on 3/3/16.
//  Copyright © 2016 Treehub. All rights reserved.
//

import SwiftyJSON
import UIKit

class Category {
    
    var title: String
    var color: UIColor
    var modules: [Module] = []
    
    init(category: JSON) {
        self.title = category["title"].stringValue
        self.color = Color.fromHexString(category["color"].stringValue)
        
        let jsonModules: Array<JSON> = category["modules"].arrayValue
        
        for module:JSON in jsonModules {
            modules.append(Module(module: module))
        }
        
    }
}
