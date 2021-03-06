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
    
    var switchPressed = false
    
    
    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var siteLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var titelLabel: UILabel!
    var ref: DatabaseReference!
    var ref2: DatabaseReference!
    
    var options = ["Students","History","Attendance","Head Check","Back"]
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
    var siteDate = ""
    var studentsActive = true
    var logsActive = false
    var attendanceActive = false
    var headCheck = false
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        logsActive = false
        attendanceActive = false
        headCheck = false
        studentsActive = true
        self.titleLabel.text = "Students"
        
        
        loadLogs()
        loadStudents()
        tableView1.reloadData()
        
    }
    override func viewDidLoad() {
        
        // func reset (necessary for when viewing other sites)
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
        print(userName)
        loadLogs()
        loadStudents()
        
    }
    
    func loadLogs(){
        if siteLocation == "Brooklyn" {
            siteDate = "bDates"
            
        } else if siteLocation == "Queens" {
            siteDate = "qDates"
            
        } else if siteLocation == "Jersey City"{
            siteDate = "jDates"
            
        }
        ref?.child("\(siteDate)").observe(.childAdded, with: { (snapshot) in
            
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
                            
                            var logA = LogTrack(date: date, ins: ins!, out: outs!, pickedUp: pUp!, droppedOff: dOff!, fullName: name!)
                            
                            logA.authPick = student["AuthPick"]!
                            logA.authDrop = student["AuthDrop"]!
                            
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
        ref?.child("\(siteLocation)").observe(.childAdded, with: { (snapshot) in
            
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
                    let aloneValue = child["LeaveAlone"] as? Bool
                    
                    let studentA = Student(firstName: f!, lastName: l!, siteLocation: sL, ID: ID, gList: gList!, leaveAlone: aloneValue!)
                    
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
                self.titleLabel.text = "Students"
                display = students
                studentsActive = true
                logsActive = false
                attendanceActive = false
                headCheck = false
                loadStudents()
                self.tableView1.reloadData()
                
            }
            if indexPath.row == 1 {
                self.titleLabel.text = "Logs"
                display = logs
                studentsActive = false
                attendanceActive = false
                headCheck = false
                logsActive = true
                loadLogs()
                self.tableView1.reloadData()
            }
            if indexPath.row == 2 {
                studentsActive = false
                logsActive = false
                headCheck = false
                attendanceActive = true
                tableView.deselectRow(at: indexPath, animated: true)
                performSegue(withIdentifier: "attendance", sender: self)
            }
            if indexPath.row == 3 {
                studentsActive = false
                logsActive = false
                headCheck = true
                attendanceActive = false
                tableView.deselectRow(at: indexPath, animated: true)
                performSegue(withIdentifier: "headCheck", sender: self)
            }
            
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
        if attendanceActive{
            let AttendanceViewController = segue.destination as? AttendanceViewController
            AttendanceViewController?.students = self.lStudents
            AttendanceViewController?.siteDate = self.siteDate
        }
        if headCheck{
            let HeadCheckViewController = segue.destination as? HeadCheckViewController
            HeadCheckViewController?.students = self.lStudents
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
