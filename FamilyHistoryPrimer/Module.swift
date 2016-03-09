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
    var lessons: [Lesson] = []
    
    init(module: JSON) {
        self.title = module["title"].stringValue
        
        let jsonLessons: Array<JSON> = module["lessons"].arrayValue
        
        for lesson:JSON in jsonLessons {
            lessons.append(Lesson(lesson: lesson))
        }
    }
}