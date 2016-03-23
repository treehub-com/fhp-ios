//
//  Question.swift
//  FamilyHistoryPrimer
//
//  Created by John M Clark on 3/23/16.
//  Copyright © 2016 Treehub. All rights reserved.
//

import SwiftyJSON

class Question {
    
    var question: String?
    var answer: String?
    
    init(question: JSON) {
        self.question = question["question"].string
        self.answer = question["answer"].string
    }
}
