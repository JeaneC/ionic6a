//
//  LogsViewController.swift
//  ionic6
//
//  Created by Jeane Carlos on 7/7/17.
//  Copyright © 2017 ionic6. All rights reserved.
//

import UIKit

class LogsViewController: UIViewController, UITableViewDataSource, UITabBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navBarItem: UINavigationItem!
    var history = History(date: "", logsB: [LogTrack]())
    var date = ""
    


    override func viewDidLoad() {
        super.viewDidLoad()
        date = self.history.date
        self.title = date
        tableView.rowHeight = 120
        navBar.topItem?.title = date
        
        // Do any additional setup after loading the view.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.history.logs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "log", for: indexPath) as? LogsTableViewCell {
            cell.studentName.text =  history.logs[indexPath.row].fullName
            cell.timeIn.text = history.logs[indexPath.row].ins
            cell.timeOut.text = history.logs[indexPath.row].out
            cell.pickedUpBy.text = history.logs[indexPath.row].pickedUp
            cell.droppedOffBy.text = history.logs[indexPath.row].droppedOff
            cell.authDropLbl.text = history.logs[indexPath.row].authDrop
            cell.authPickLbl.text = history.logs[indexPath.row].authPick
            
            return cell
        } else {
            return LogsTableViewCell()
        }
    }
    
    @IBAction func organizedPressed(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
