//
//  ProfileViewController.swift
//  ionic6
//
//  Created by Jeane Carlos on 7/6/17.
//  Copyright © 2017 ionic6. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var student: Student!

    var parentList = [String]()
//    var numberList = [String]()
    
    
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var siteLocation: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fullName.text = student.fullName
        self.siteLocation.text = student.siteLocation
        self.parentList = student.guardians
        
        tableView.dataSource = self
        tableView.delegate = self

        
        tableView.rowHeight = 60
        tableView.reloadData()

        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let p = parentList[indexPath.row]
        cell.textLabel?.text = p
        cell.textLabel?.font = UIFont.init(name: "Avenir Next", size: 22)
        cell.textLabel?.textAlignment = NSTextAlignment.center
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parentList.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
