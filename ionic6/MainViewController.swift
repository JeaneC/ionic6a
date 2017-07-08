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
    @IBOutlet weak var siteLabel: UILabel!
    
    var ref: DatabaseReference!
    var ref2: DatabaseReference!
    
    var options = ["Students","History","Attendance","Head Count Check","Back"]
    var logs = [String]()
    var students = [String]()
    var studentIDS = [Int]()
    var display = [String]()
    
    var logKey = ""
    var lLogs = [LogTrack]()
    var lStudents = [Student]()
    var lHistory = [History]()
    var profileStudent: Student!
    
    var selectedHistory = History(date: "", logsB: [LogTrack]())
    
    var siteLocation = ""
    var studentsActive = true
    var logsActive = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        ref2 = Database.database().reference()
        
        siteLabel.text = self.siteLocation
        
        tableView.rowHeight = 30
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "options")
        
        tableView1.dataSource = self
        tableView1.delegate = self
        tableView1.register(UITableViewCell.self, forCellReuseIdentifier: "logs")
        
        self.display = self.students
        
        loadLogs()
        loadStudents()
        
    }
    
    func loadLogs(){
        
        ref?.child("jDates").observe(.childAdded, with: { (snapshot) in
            
            //Code to execute when a child is added under "Jersey City"
            //This value is an Array of dictionaries
            //JK, that's what I thought, but the snapshots is the array element, making this
            //Conveniently just the dictionary
            if let dateDirectory = snapshot.value as? Dictionary<String, AnyHashable> {
                if let date = dateDirectory["Date"] as? String, !self.logs.contains(date){
                    //We get the current Date, and if the date is not in the log, then we do everything to add the date date there
                    
                    var logsTrack = [LogTrack]() //Fresh new array of logs
                    if let students = dateDirectory["Students"] as? [Dictionary<String, String>]{
                        for student in students {
                            let ins = student["In"]
                            let outs = student["Out"]
                            let name = student["Name"]
                            let pUp = student["Picked Up By"]
                            let dOff = student["Dropped Off By"]
                            
                            let logA = LogTrack(date: date, ins: ins!, out: outs!, pickedUp: pUp!, droppedOff: dOff!, fullName: name!)
                            
                            self.lLogs.append(logA)
                            logsTrack.append(logA)
                        }
                    }
                    
                    self.logs.append(date)
                    let historyA = History(date: date, logsB: logsTrack)
                    self.lHistory.append(historyA)
                }
                
            }
            self.display = self.logs
        })
        self.tableView1.reloadData()
    }
    func loadStudents(){
        
        ref?.child("Jersey City").observe(.childAdded, with: { (snapshot) in
            
            //Code to execute when a child is added under "Jersey City"
            //This value is an Array of dictionaries
            //JK, that's what I thought, but the snapshots is the array element, making this
            //Conveniently just the dictionary
            
            if let child = snapshot.value as? Dictionary<String, Any> {
                if let ID = child["ID"] as? Int, !self.studentIDS.contains(ID){
                    //We get the students ID, and if our current ID list does not have the student
                    //Then we can add the student to the directiory
                    let f = child["First"] as? String
                    let l = child["Last"] as? String
                    let sL = "Jersey City"
                    let fullName = "\(f!) \(l!)"
                    let gList = child["Guardians"] as? [Dictionary<String, String>]
                    
                    let studentA = Student(firstName: f!, lastName: l!, siteLocation: sL, ID: ID, gList: gList!)
                    
                    self.students.append(fullName)
                    self.lStudents.append(studentA)
                    self.studentIDS.append(ID)
                    
                }
            }
            
            self.display = self.students
            
        })
    }
    
    //Selected a section
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Selected a selection in the Options Pane
        if tableView == self.tableView {
            if indexPath.row == 0 {
                display = students
                studentsActive = true
                logsActive = false
                loadStudents()
                self.tableView1.reloadData()
                
            }
            if indexPath.row == 1 {
                display = logs
                studentsActive = false
                logsActive = true
                loadLogs()
                self.tableView1.reloadData()
            }
            
            tableView1.reloadData()
            if indexPath.row == 4 {
                dismiss(animated: true, completion: nil)
            }
        }
        
        //Selected a selection in the Students/Logs pane
        if tableView == self.tableView1 {
            if studentsActive {
                profileStudent = lStudents[indexPath.row]
                performSegue(withIdentifier: "student", sender: self)
            }
            if logsActive {
                selectedHistory = lHistory[indexPath.row]
                performSegue(withIdentifier: "logs", sender: self)
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if studentsActive{
            let ProfileViewContoller = segue.destination as? ProfileViewController
            ProfileViewContoller?.student = profileStudent
        }
        
        if logsActive{
            let LogsViewContoller = segue.destination as? LogsViewController
            LogsViewContoller?.history = selectedHistory
            
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
            //                cell?.switchA.alpha = 0
            
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
