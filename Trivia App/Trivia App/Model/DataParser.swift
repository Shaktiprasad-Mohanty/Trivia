//
//  DataParser.swift
//  Trivia App
//
//  Created by Shaktiprasad Mohanty on 02/10/20.
//

import Foundation
class DataParser {
    func parseQuestions()->[QuestionBO]{
        let questions = [[
            "options" :     [
                        [
                            "option_id" : 3,
                            "option_value" : "Sachin Tendulkar",
                ],
                [
                    "option_id" : 6,
                    "option_value" : "Virat Kolli",
        ],
                [
                    "option_id" : 5,
                    "option_value" : "Adam Gilchirst",
        ],
                        [
                            "option_id" : 4,
                            "option_value" : "Jacques Kallis",
                ]
            ],
            "question" :     [
                "placeholder" : "",
                "question" : "Who is the best cricketer in the world?",
                "question_id" : 2,
                "question_type" : "radio_button",
                "validation" : "",
            ],
        ],[
            "options" :     [
                        [
                            "option_id" : 1,
                            "option_value" : "White",
                ],
                [
                    "option_id" : 2,
                    "option_value" : "Yellow",
        ],
                [
                    "option_id" : 3,
                    "option_value" : "Orange",
        ],
                        [
                            "option_id" : 4,
                            "option_value" : "Green",
                ]
            ],
            "question" :     [
                "placeholder" : "",
                "question" : "What are the colors in the Indian national flag?",
                "question_id" : 3,
                "question_type" : "check_box",
                "validation" : "",
            ],
        ]] as [[String : Any]]
        var arrQuestions = [QuestionBO]()
        for qus in questions {
            arrQuestions.append(QuestionBO(dict: qus))
        }
        return arrQuestions
    }
}
