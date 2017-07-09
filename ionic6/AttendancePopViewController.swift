//
//  AttendancePopViewController.swift
//  ionic6
//
//  Created by Jeane Carlos on 7/8/17.
//  Copyright © 2017 ionic6. All rights reserved.
//

import UIKit

protocol MyProtocol {
    func setResult(trackingNumber: Int, completed: Bool, selectedParent: String, droppedOffTrue: Bool)
}

class AttendancePopViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{

    var complete = false
    var student: Student!
    var log: LogTrack!
    var trackingNumber: Int!
    var parentValue: String!
    var gList: [String]!

    var delegate: MyProtocol?
    var droppedOff: Bool!


    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var dropText: UILabel!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var studentName: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.layer.cornerRadius = 15
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        studentName.text = student.fullName
        if log.ins == "" {
            dropText.text = "Dropped Off By"
            droppedOff = true
        } else {
            dropText.text = "Picked Up By"
            droppedOff = false
        }
        
        gList = student.guardians
        
        if student.leaveAlone {
            gList.append("Self")
            
        }
        parentValue = student.guardians[0] //Set a default value
        
        pickerView.reloadAllComponents()

        
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gList.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        parentValue = gList[row]
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    @IBAction func cancelPressed(_ sender: Any) {
        delegate?.setResult(trackingNumber: trackingNumber, completed: false, selectedParent: parentValue, droppedOffTrue: droppedOff)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func confirmPressed(_ sender: Any) {
        delegate?.setResult(trackingNumber: trackingNumber, completed: true, selectedParent: parentValue, droppedOffTrue: droppedOff)
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
