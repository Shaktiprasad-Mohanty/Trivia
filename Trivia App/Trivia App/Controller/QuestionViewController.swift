//
//  QuestionViewController.swift
//  Trivia App
//
//  Created by Shaktiprasad Mohanty on 02/10/20.
//

import UIKit

class QuestionViewController: UIViewController {
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var tblOptipn: UITableView!
    
    fileprivate var questionIndex = 0
    var arrQuestions : [QuestionBO]!
    fileprivate var arrSelectedAnswer = [String]()
    var userId : UUID!
    var userName : String!
    var onDone : (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //dummydata setup
        tblOptipn.dataSource = self
        tblOptipn.delegate = self
        arrQuestions = DataParser().parseQuestions()
        resetView()
        // Do any additional setup after loading the view.
    }
    
    
    //MARK : User Defined Methods
    func resetView(){
        let question = arrQuestions[questionIndex]
        lblQuestion.text = question.strQuestion
        arrSelectedAnswer.removeAll()
        tblOptipn.reloadData()
    }
    
    
    //MARK: button action
    @IBAction func nextTapped(_ sender: Any) {
        if validAnswer() {
                saveServey()
        } else {
            let alert = UIAlertController(title: nil, message: "Give an answer to proceed.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel) { (action) in
            }
            alert.addAction(action)
            self.present(alert, animated: true) {
                
            }
        }
    }
    func validAnswer() -> Bool {        
        if arrSelectedAnswer.count == 0 {
            return false
        }
        
        return true
    }
    // MARK: service call
    func saveServey() {
        var answer = ""
        if arrSelectedAnswer.count > 1 {
            answer = arrSelectedAnswer.joined(separator: ",")
        } else {
            answer = arrSelectedAnswer[0]
        }
        HistoryDBM.shared.saveData(userId: userId, userName: userName, question: arrQuestions[questionIndex].strQuestion, answer: answer)
        if(self.questionIndex < self.arrQuestions.count - 1){
            arrQuestions.remove(at: 0)
            self.resetView()
        } else {
            self.onDone?()
            let sumuryVC = mainStoryBoard.instantiateViewController(withIdentifier: "SummeryViewController") as! SummeryViewController
            sumuryVC.userId = userId
            self.navigationController?.pushViewController(sumuryVC, animated: true)
        }
        
        
    }
    
}

extension QuestionViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let question = arrQuestions[questionIndex]
        if question.typeVal == AnswerType.CheckBox || question.typeVal == AnswerType.RadioButton{
            return question.arrOptions.count
        } else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : OptionTableViewCell!
        let question = arrQuestions[questionIndex]
        if question.typeVal == AnswerType.CheckBox {
            cell = tableView.dequeueReusableCell(withIdentifier: "OptionCheckBox") as? OptionTableViewCell
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "OptionRadioButton") as? OptionTableViewCell
        }
        let option = question.arrOptions[indexPath.row]
        cell.lblOption.text = option.value
        if arrSelectedAnswer.contains(option.value) {
            cell.btnOption.isSelected = true
        } else {
            cell.btnOption.isSelected = false
        }
        cell.btnOption.tag = indexPath.row
        cell.btnOption.addTarget(self, action: #selector(buttonSelect), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        optionSelectAtIndex(index: indexPath.row)
    }
    
    @objc func buttonSelect(sender: UIButton){
        optionSelectAtIndex(index: sender.tag)
    }
    func optionSelectAtIndex(index: Int){
        let question = arrQuestions[questionIndex]
        let option = question.arrOptions[index]
        if question.typeVal == AnswerType.CheckBox {
            if arrSelectedAnswer.contains(option.value) {
                arrSelectedAnswer.remove(at: arrSelectedAnswer.firstIndex(of: option.value)!)
            } else {
                arrSelectedAnswer.append(option.value)
            }
        } else {
            arrSelectedAnswer.removeAll()
            arrSelectedAnswer.append(option.value)
        }
        tblOptipn.reloadData()
    }
    
}
