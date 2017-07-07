//
//  MainViewController.swift
//  ionic6
//
//  Created by Jeane Carlos on 7/6/17.
//  Copyright © 2017 ionic6. All rights reserved.
//

import UIKit
import Firebase


class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var tableView: UITableView!
    var ref: DatabaseReference!
    
    var options = ["Students","Attendance","History", "Head Count Check"]
    var logs = ["10-24-1997","10-25-1997","10-26-1997", "10-27-1997"]
    var students = [String]()
    var display = [String]()
    var test = [String]()
    var lStudents = [Student]()
    
    var studentsActive = true
    var logsActive = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        tableView.rowHeight = 80
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "options")
        
        tableView1.dataSource = self
        tableView1.delegate = self
        tableView1.register(UITableViewCell.self, forCellReuseIdentifier: "logs")
        
        self.display = self.students
        
        // Do any additional setup after loading the view.
        
        // Do any additional setup after loading the view, typically from a nib.
        ref?.child("Jersey").child("Children").observe(.childAdded, with: { (snapshot) in
            
            //Code to execute when a child is added under "Posts"
            //Take the value from the snapshot and add it to the postData array
            
            //Convert the data into a string
            if let child = snapshot.value as? Dictionary<AnyHashable, Any> {
                let f = child["First Name"] as? String
                let l = child["Last Name"] as? String
                let s = " "
                let fullName = f! + s + l!
                self.test.append(fullName)
            }
            self.students = self.test
            if self.studentsActive{
                self.display = self.students
                
            } else {
                //llogs version
            }
            self.tableView1.reloadData()
        })
    }
    
    //Selected a section
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.tableView {

            if indexPath.row == 0 {
                display = students
                studentsActive = true
                logsActive = false
                
            }
            if indexPath.row == 1 {
                display = logs
                studentsActive = false
                logsActive = true
            }
            tableView1.reloadData()
        }
        if tableView == self.tableView1 {

            if indexPath.row == 2 {
                if studentsActive {
                performSegue(withIdentifier: "student", sender: self)
                }
            }
        }
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
            cell?.textLabel?.text = display[indexPath.row]
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
            count =  display.count
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
