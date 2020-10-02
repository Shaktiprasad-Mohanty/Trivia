//
//  HistoryViewController.swift
//  Trivia App
//
//  Created by Shaktiprasad Mohanty on 02/10/20.
//

import UIKit

class HistoryViewController: UIViewController {
    @IBOutlet weak var historyTableview: UITableView!
    var arrUsers = [History]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        historyTableview.dataSource = self
        historyTableview.delegate = self
        loadData()
    }
    func loadData() {
        let concurrentQueue = DispatchQueue(label: "com.some.concurrentQueue", attributes: .concurrent)
        concurrentQueue.async { [self] in
            self.arrUsers = HistoryDBM.shared.fetchUsers()
            DispatchQueue.main.async {
                self.historyTableview.reloadData()
            }
        }
    }
    @IBAction func backTapped(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
}

extension HistoryViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrUsers.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell?
        cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = arrUsers[indexPath.row].username
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sumuryVC = mainStoryBoard.instantiateViewController(withIdentifier: "SummeryViewController") as! SummeryViewController
        sumuryVC.userId = arrUsers[indexPath.row].userId
        self.navigationController?.pushViewController(sumuryVC, animated: true)
    }
    
}
