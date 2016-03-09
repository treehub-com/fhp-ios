//
//  Lesson.swift
//  FamilyHistoryPrimer
//
//  Created by John M Clark on 3/9/16.
//  Copyright © 2016 Treehub. All rights reserved.
//

import SwiftyJSON

class Lesson {
    var title: String
    
    init(lesson: JSON) {
        self.title = lesson["title"].stringValue
    }
}
