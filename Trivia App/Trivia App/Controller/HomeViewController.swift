//
//  ViewController.swift
//  Trivia App
//
//  Created by Shaktiprasad Mohanty on 02/10/20.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var txtName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func nextTapped(_ sender: Any) {
        if let name = txtName.text, name != ""{
            let questionVC = mainStoryBoard.instantiateViewController(withIdentifier: "QuestionViewController") as! QuestionViewController
            questionVC.onDone = { [self] in
                txtName.text = ""
            }
            questionVC.userId = UUID()
            questionVC.userName = txtName.text
            self.navigationController?.pushViewController(questionVC, animated: true)
        }
    }
}
extension HomeViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
