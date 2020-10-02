//
//  SummeryViewController.swift
//  Trivia App
//
//  Created by Shaktiprasad Mohanty on 02/10/20.
//

import UIKit

class SummeryViewController: UIViewController {
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var btnHistory: UIButton!
    @IBOutlet weak var btnFinish: UIButton!
    var userId : UUID!
    
    fileprivate var arrUser = [History]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadData()
    }
    
    func loadData() {
        let concurrentQueue = DispatchQueue(label: "com.some.concurrentQueue", attributes: .concurrent)
        concurrentQueue.async { [self] in
            self.arrUser = HistoryDBM.shared.fetchQuestions(userid: userId)
            DispatchQueue.main.async {
                var text = ""
                if arrUser.count > 0 {
                    text = text + "Hello " + (arrUser[0].username ?? "There") + ":\n\nHere are the answers selected:\n"
                    for question in arrUser {
                        let answer = question.answer ?? ""
                        text = text + "\n\n\(question.qusetion ?? "")\n\(answer.contains(",") ? "Answers:  " : "Answer:  ")\(answer)"
                    }
                }
                lblDetails.text = text
            }
        }
    }
    
    @IBAction func historyTapped(_ sender: Any) {
        let selectedNavVC = self.navigationController!
        for vc in selectedNavVC.viewControllers {
            if vc.isKind(of: HistoryViewController.self){
                selectedNavVC.popToViewController(vc, animated: true)
                return
            }
        }
        let historyVC = mainStoryBoard.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
        self.navigationController?.pushViewController(historyVC, animated: true)
    }
    @IBAction func finishTapped(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }

}
