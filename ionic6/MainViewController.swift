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
    var ref2: DatabaseReference!
    
    var options = ["Students","Attendance","History", "Head Count Check"]
    var logs = [String]()
    var students = [String]()
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
    var attendanceActive = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        ref2 = Database.database().reference()
        
        tableView.rowHeight = 30
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "options")
        
        tableView1.dataSource = self
        tableView1.delegate = self
        tableView1.register(UITableViewCell.self, forCellReuseIdentifier: "logs")
        
        self.display = self.students
        

        //loadStudents()
        
    }
    
    func loadLogs(){
        //Goes through each date
        ref2?.child("Jersey").child("Dates").observe(.childAdded, with: { (snapshot) in
            
            

            if !self.logs.contains(snapshot.key){ //If we haven't done this date yet
                self.logs.append(snapshot.key)
                
                let cDate = snapshot.key as? String //This warning is false, since I get errors if I don't do this
                var dateLog = [LogTrack]()

                
               let children = snapshot.value as? Dictionary<String,AnyHashable>
                
                for student in self.students {
                    print(children!)
                    let child = children?[student] as? Dictionary<String, AnyHashable>
                    let cIn = child?["In"] as? String
                    let cOut = child?["Out"] as? String
                    let pUp = child?["Picked Up"] as? String
                    let newLog = LogTrack(date: cDate!, ins: cIn!, out: cOut!, pickedUp: pUp!, fullName: student)
                    dateLog.append(newLog)

                }
                let nHistory = History(date: cDate!, logsB: dateLog)
                self.selectedHistory = nHistory
                self.lHistory.append(nHistory)

            }
            if self.logsActive{
                self.display = self.logs
                self.tableView1.reloadData()
            }
        })
        
        
        
    }
    
    func loadStudents(){
        ref?.child("Jersey").child("Children").observe(.childAdded, with: { (snapshot) in
            
            //Code to execute when a child is added under "Posts"
            //Take the value from the snapshot and add it to the postData array
            
            //Convert the data into a string
            if let child = snapshot.value as? Dictionary<AnyHashable, AnyHashable> {
                
                let f = child["First Name"] as? String
                let l = child["Last Name"] as? String
                let s = " "
                let siteLocation = "Jersey City"
                let fullName = f! + s + l!
                
                
                let gList = child["Authorized Guardians"] as? Dictionary<String, Dictionary<String,String>>
                
                
                let studentA = Student(firstName: f!, lastName: l!, siteLocation: siteLocation, gList: gList!)
                
                if !self.students.contains(fullName){
                    self.lStudents.append(studentA)
                    self.students.append(fullName)
                }
                
                
            }
            if self.studentsActive{
                self.display = self.students
                
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
                attendanceActive = false
                loadStudents()
                
            }
            if indexPath.row == 1 {
                display = students
                studentsActive = false
                attendanceActive = true
                logsActive = false
                loadStudents()
                
            }
            if indexPath.row == 2 {
                display = logs
                studentsActive = false
                logsActive = true
                attendanceActive = false
                loadLogs()
                print("Got Here")
            }
            tableView1.reloadData()
        }
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
            //LogsViewContoller?.history = selectedHistory //Disable this segue for now
            
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
            
            if attendanceActive{
                let cellB = AttendnanceTableViewCell()
                cellB.textLabel?.text = display[indexPath.row]
                return cellB
            } else {
                
                cell?.textLabel?.text = display[indexPath.row]
//                cell?.switchA.alpha = 0
            }
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
