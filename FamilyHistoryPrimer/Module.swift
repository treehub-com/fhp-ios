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
    var title: String
    var color: UIColor
    var img: UIImage?
    var lessons: [Lesson] = []
    
    init(module: JSON) {
        self.title = module["title"].stringValue
        self.color = Color.fromHexString(module["color"].stringValue)
        
        let imagePath = module["img"].string
        
        if imagePath != nil {
            print(imagePath)
            let path = NSBundle.mainBundle().pathForResource("images/" + imagePath!, ofType: "png")
            self.img = UIImage(contentsOfFile: path!)
            print(img?.size)
        }
        
        let jsonLessons: Array<JSON> = module["lessons"].arrayValue
        
        for lesson:JSON in jsonLessons {
            lessons.append(Lesson(lesson: lesson))
        }
    }
}