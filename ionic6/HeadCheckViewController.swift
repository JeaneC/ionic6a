//
//  HeadCheckViewController.swift
//  ionic6
//
//  Created by Jeane Carlos on 7/9/17.
//  Copyright © 2017 ionic6. All rights reserved.
//

import UIKit

class HeadCheckViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var students = [Student]()
    var reset = false

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func refreshPressed(_ sender: Any) {
        reset = true
        tableView.reloadData()


    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 90
        // Do any additional setup after loading the view.
    }



    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "attendanceCellB", for: indexPath) as? AttendanceTableViewCell {
            cell.nameLbl.text = students[indexPath.row].fullName
            
            if reset == true {
            cell.switchA.setOn(false, animated: true)
                if indexPath.row == students.count {
                            reset = false
                }

            }
            
            
            return cell
        } else {
            return AttendanceTableViewCell()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
