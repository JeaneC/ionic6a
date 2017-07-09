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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
