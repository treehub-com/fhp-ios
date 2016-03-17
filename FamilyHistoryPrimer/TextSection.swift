//
//  TextSection.swift
//  FamilyHistoryPrimer
//
//  Created by John M Clark on 3/9/16.
//  Copyright © 2016 Treehub. All rights reserved.
//

import SwiftyJSON
import UIKit

class TextSection: Section {
    
    var content: String?
    var img: UIImage?
    
    init(section: JSON) {
        super.init(type: "text")
        
        self.content = section["content"].string
        let imagePath = section["img"].string
        
        if imagePath != nil {
            let filename = NSString(string: imagePath!)
            let path = NSBundle.mainBundle().pathForResource("images/" + filename.stringByDeletingPathExtension, ofType: filename.pathExtension)
            self.img = UIImage(contentsOfFile: path!)
        }
    }
}
