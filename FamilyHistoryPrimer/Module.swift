//
//  Module.swift
//  FamilyHistoryPrimer
//
//  Created by John M Clark on 3/3/16.
//  Copyright © 2016 Treehub. All rights reserved.
//

import SwiftyJSON

class Module {
    var title: String
    
    init(module: JSON) {
        self.title = module["title"].stringValue
    }
}