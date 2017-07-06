//
//  MainViewController.swift
//  ionic6
//
//  Created by Jeane Carlos on 7/6/17.
//  Copyright © 2017 ionic6. All rights reserved.
//

import UIKit


class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var NJ: UIButton!

    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var BK: UIButton!
    @IBOutlet weak var QN: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var options = ["Students","Attendance","History", "Other"]
    var logs = ["10-24-1997","10-25-1997","10-26-1997"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hello World")
        
        tableView.rowHeight = 80
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "options")
        
        tableView1.dataSource = self
        tableView1.delegate = self
        tableView1.register(UITableViewCell.self, forCellReuseIdentifier: "logs")
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        
        if tableView == self.tableView {
        cell = UITableViewCell()
        cell?.textLabel?.text = options[indexPath.row]
        }
        
        if tableView == self.tableView1 {
            cell = UITableViewCell()
            cell?.textLabel?.text = logs[indexPath.row]
        }
        return cell!
            
    }
    
    //Fix this so one displays logs and the other displays something else
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count:Int?
        
        if tableView == self.tableView {
            count = options.count
        }
        
        if tableView == self.tableView1 {
            count =  logs.count
        }
        
        return count!
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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
