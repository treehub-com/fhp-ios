//
//  TextSection.swift
//  FamilyHistoryPrimer
//
//  Created by John M Clark on 3/9/16.
//  Copyright © 2016 Treehub. All rights reserved.
//

import SwiftyJSON

class TextSection: Section {
    
    init(json: JSON) {
        super.init(type: "text")
    }
}
