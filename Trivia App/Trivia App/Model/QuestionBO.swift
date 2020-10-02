//
//  QuestionBO.swift
//  Trivia App
//
//  Created by Shaktiprasad Mohanty on 02/10/20.
//

import UIKit

public enum AnswerType {
    case CheckBox,RadioButton
}
class QuestionBO: NSObject {
    var  strQuestionID : String! = ""
    var  inputType : String! = ""
    var  placeHolder : String! = ""
    var  strQuestion : String! = ""
    var  strOptionType : String! = ""
    var  typeVal : AnswerType! = AnswerType.RadioButton
    var  arrOptions : [OptionBO]! = [OptionBO]()
     
     override init() {
         super.init()
     }
     init(dict:[String: Any]) {
         let question = dict["question"] as! [String: Any]
         strQuestionID = "\(question["question_id"]!)"
         inputType = question["validation"] as? String
         placeHolder = question["placeholder"] as? String
         strQuestion = question["question"] as? String
         strOptionType = question["question_type"] as? String
         
         if (strOptionType == "check_box") {
             typeVal = AnswerType.CheckBox
         } else if (strOptionType == "radio_button") {
             typeVal = AnswerType.RadioButton
         }
         if (strOptionType != "text_field") {
             for option in dict["options"] as! [[String:Any]] {
                 arrOptions.append(OptionBO(dict: option))
             }
         }
     }
}
class OptionBO: NSObject {
   var  optionID : String! = ""
   var  value : String! = ""
   var  resonRequired : String! = ""
    
    init(dict:[String: Any]) {
        optionID = "\(dict["option_id"]!)"
        value = dict["option_value"] as? String
        resonRequired = dict["reason_required"] as? String
    }
    
}
