//
//  LoginViewController.swift
//  ionic6
//
//  Created by Jeane Carlos on 7/5/17.
//  Copyright © 2017 ionic6. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var signInMsg: UILabel!
    
    
    var mainColor: UIColor!
    
    
    
    @IBAction func skipPressed(_ sender: Any) {
        //performSegue(withIdentifier: "login", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mainColor = mainView.backgroundColor
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signinPressed(_ sender: UIButton) {
        
        //Data validation here
        if let email = usernameField.text, let pass = passwordField.text {
            
            Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
                if let u = user {
                    print(u)
                    self.performSegue(withIdentifier: "login", sender: self)
                } else {
                    //self.mainView.backgroundColor = UIColor.brown
                    self.signInMsg.alpha = 1.0
                    
                }
            }
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.mainView.backgroundColor = self.mainColor
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
    }
    
}


