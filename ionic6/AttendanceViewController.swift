//
//  AttendanceViewController.swift
//  ionic6
//
//  Created by Jeane Carlos on 7/8/17.
//  Copyright © 2017 ionic6. All rights reserved.
//

import UIKit
import Firebase


class AttendanceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var students = [Student]()
    var stringDate = ""
    var ref = Database.database().reference()
    var logList = [LogTrack]()
    var studentList = [Dictionary<String,String>]()
    var dateExists = false

    var switchValueSent:Bool?
    
    let date = Date()
    let formatter = NumberFormatter()
    let formatter2 = DateFormatter()
    let calendar = Calendar.current
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    
    func setValueFromPop(valueSent: Bool){
        self.switchValueSent = valueSent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 90
        formatter.minimumIntegerDigits = 2
        formatter2.dateFormat = "MMddyyyy"
        stringDate = formatter2.string(from: date)
        navBar.topItem?.title = stringDate
        
        //createLogs()

        
        ref.child("jDates").observe(.value, with: { (snapshot) in
            if let dateDirectoryB = snapshot.value as? Dictionary<String, AnyHashable> {
                if (dateDirectoryB[self.stringDate] != nil){// Date Exists
                    self.logList.removeAll()

                    //Parse the Logs
                    let date = dateDirectoryB[self.stringDate] as? Dictionary<String, AnyHashable>
                    let students = date?["Students"] as? [Dictionary<String,String>]
                    for student in students!{
                        let lIn = student["In"]
                        let lOut = student["Out"]
                        let lName = student["Name"]
                        let ldOff = student["Dropped Off By"]
                        let lpUp = student["Picked Up By"]
                        let logA = LogTrack(date: self.stringDate, ins: lIn!, out: lOut!, pickedUp: lpUp!, droppedOff: ldOff!, fullName: lName!)
                        self.logList.append(logA)
                    }
                    print(self.logList.count)
                    print(self.students.count)
                } else { //Date does not Exist
                    print("The Date Does Not Exist")
                    self.createLogs() //Create An Empty Set Of Logs
                }
                
            }
        })
        tableView.reloadData()
        
    }
    
    func droppedOff(studentIndexA: Int, droppedOff: String){
        //Need to create a prevention from opening this if the user accidently flicks on off
        let studentIndex = studentIndexA
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let time = "\(hour):\(minutes)"
        
        logList[studentIndexA].ins = time
        logList[studentIndexA].droppedOff = droppedOff
        
        let post = ["In" : time, "Dropped Off By" : droppedOff, "Name" : students[studentIndex].fullName, "Out": "", "Picked Up By": ""]
        
        let childUpdates = ["/jDates/\(self.stringDate)/Students/\(studentIndex)": post]
        ref.updateChildValues(childUpdates)

        
    }
    
    func pickedUp(studentIndexA: Int, pickedUp: String){
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let time = "\(hour):\(minutes)"
        
        logList[studentIndexA].out = time
        logList[studentIndexA].pickedUp = pickedUp
        
        let post = ["In" : self.logList[studentIndexA].ins, "Dropped Off By" : self.logList[studentIndexA].droppedOff, "Name" : self.logList[studentIndexA].fullName, "Out": time, "Picked Up By": pickedUp]
        
        let childUpdates = ["/jDates/\(self.stringDate)/Students/\(studentIndexA)": post]
        ref.updateChildValues(childUpdates)
        
        
    }

    
    func createLogs(){
        for student in students {
            let logA = LogTrack(date: "", ins: "", out: "", pickedUp: "", droppedOff: "", fullName: student.fullName)
            self.logList.append(logA)
        }
        
        for log in logList {
            var studentDict = Dictionary<String, String>()
            studentDict["In"] = ""
            studentDict["Out"] = ""
            studentDict["Name"] = log.fullName
            studentDict["Picked Up By"] = ""
            studentDict["Dropped Off By"] = ""
            studentList.append(studentDict)
        }
        
        var dateDirectory = Dictionary<String, Any>()
        dateDirectory["Date"] = self.stringDate
        dateDirectory["Students"] = studentList
        

        ref.child("jDates").child(self.stringDate).setValue(dateDirectory)
//        print("Did It!")
        
    }
    
    func checkDate() -> Bool {
        //Seems very inefficient way of doing this though

        //This part of the code never executes... I'm not sure why
        print(self.dateExists)
        print("I like fried Chicken")
        return dateExists
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "attendanceCell", for: indexPath) as? AttendanceTableViewCell {
            cell.nameLbl.text = students[indexPath.row].fullName
            return cell
        } else {
            return AttendanceTableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pickedUp(studentIndexA: indexPath.row, pickedUp: "Jermaine Jackson")
    }
    
    @IBAction func switchChanged(_ sender: Any) {
        print("This Was Pressed")
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
