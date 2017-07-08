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
    var gList: Dictionary<String, Dictionary<String,String>>!
    var parentList = [String]()
    var numberList = [String]()
    
    
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var siteLocation: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstName.text = student.firstName
        self.lastName.text = student.lastName
        self.siteLocation.text = student.siteLocation
        tableView.dataSource = self
        tableView.delegate = self
        gList = student.gList
        tableView.rowHeight = 80
        
        for (_,gNumber) in gList {
            let p = gNumber["Full Name"]
            let n = gNumber["Phone Number"]
            numberList.append(n!)
            parentList.append(p!)
//            if let g = gNumber as? Dictionary<String,String>{
//                let p = g["Phone Number"]!
//                let n = g["Full Name"]!
//                numberList.append(p!)
//                parentList.append(n!)
//            }
            
        }

        tableView.reloadData()

        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let p = parentList[indexPath.row]
        let n = numberList[indexPath.row]
        let nameNumber = "\(p): \(n)"
        cell.textLabel?.text = nameNumber
        cell.textLabel?.font = UIFont.init(name: "Avenir Next", size: 34)
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
