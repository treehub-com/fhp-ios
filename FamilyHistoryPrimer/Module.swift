//
//  Module.swift
//  FamilyHistoryPrimer
//
//  Created by John M Clark on 3/3/16.
//  Copyright © 2016 Treehub. All rights reserved.
//

import SwiftyJSON
import UIKit

class Module {
    var color: UIColor
    var title: String
    var subtitle: String?
    var img: UIImage?
    var lessons: [Lesson] = []
    
    init(module: JSON) {
        self.color = Color.fromHexString(module["color"].stringValue)
        self.title = module["title"].stringValue
        self.subtitle = module["subtitle"].string
        let imagePath = module["img"].string
        
        if imagePath != nil {
            let filename = NSString(string: imagePath!)
            let path = NSBundle.mainBundle().pathForResource("images/" + filename.stringByDeletingPathExtension, ofType: filename.pathExtension)
            self.img = UIImage(contentsOfFile: path!)
        }
        
        let jsonLessons: Array<JSON> = module["lessons"].arrayValue
        
        for lesson:JSON in jsonLessons {
            lessons.append(Lesson(lesson: lesson))
        }
    }
}