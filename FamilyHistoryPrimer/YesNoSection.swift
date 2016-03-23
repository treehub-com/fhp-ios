//
//  YesNoSection.swift
//  FamilyHistoryPrimer
//
//  Created by John M Clark on 3/9/16.
//  Copyright © 2016 Treehub. All rights reserved.
//

import SwiftyJSON

class YesNoSection: Section {
    
    var task: String?
    var questions: [Question] = []
    
    init(section: JSON) {
        super.init(type: "yes-no")
        
        self.task = section["task"].string
        
        let jsonQuestions: Array<JSON> = section["questions"].arrayValue
        
        for question:JSON in jsonQuestions {
            questions.append(Question(question: question))
        }
    }
}
