//
//  Lesson.swift
//  FamilyHistoryPrimer
//
//  Created by John M Clark on 3/9/16.
//  Copyright © 2016 Treehub. All rights reserved.
//

import SwiftyJSON
import UIKit

class Lesson {
    var title: String
    var color: UIColor
    var sections: [Section] = []
    
    init(lesson: JSON) {
        self.title = lesson["title"].stringValue
        self.color = Color.fromHexString(lesson["color"].stringValue)
        
        let jsonSections: Array<JSON> = lesson["sections"].arrayValue
        
        for section:JSON in jsonSections {
            let type = section["type"].stringValue
            switch type {
            case "challenge":
                sections.append(ChallengeSection(json: section))
            case "text":
                sections.append(TextSection(json: section))
            case "yes-no":
                sections.append(YesNoSection(json: section))
            default:
                break
            }
        }
    }
}
