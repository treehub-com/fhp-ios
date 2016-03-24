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
    var subtitle: String?
    var color: UIColor
    var img: UIImage?
    var sections: [Section] = []
    
    init(lesson: JSON) {
        self.color = Color.fromHexString(lesson["color"].stringValue)
        self.title = lesson["title"].stringValue
        self.subtitle = lesson["subtitle"].string
        
        let imagePath = lesson["img"].string
        
        if imagePath != nil {
            let filename = NSString(string: imagePath!)
            let path = NSBundle.mainBundle().pathForResource("images/" + filename.stringByDeletingPathExtension, ofType: filename.pathExtension)
            self.img = UIImage(contentsOfFile: path!)
        }
        
        let jsonSections: Array<JSON> = lesson["sections"].arrayValue
        
        for section:JSON in jsonSections {
            let type = section["type"].stringValue
            switch type {
            case "challenge":
                sections.append(ChallengeSection(section: section))
            case "text":
                sections.append(TextSection(section: section))
            case "yes-no":
                sections.append(YesNoSection(section: section))
            default:
                break
            }
        }
    }
}
