//
//  SiteViewController.swift
//  ionic6
//
//  Created by Jeane Carlos on 7/8/17.
//  Copyright © 2017 ionic6. All rights reserved.
//

import UIKit
import FirebaseAuth

var userName = ""

class SiteViewController: UIViewController {
    
    var siteLocation = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser != nil {
            let user = Auth.auth().currentUser
            if let user = user {
                // The user's ID, unique to the Firebase project.
                // Do NOT use this value to authenticate with your backend server,
                // if you have one. Use getTokenWithCompletion:completion: instead.
                
                userName = user.email!
                let endIndex = userName.index(userName.endIndex, offsetBy: -11)
                userName = userName.substring(to: endIndex).capitalized
 
            }
        } else {
            // No user is signed in.
            // ...
        }

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func jerseyBtn(_ sender: UIButton) {
        self.siteLocation = "Jersey City"
        performSegue(withIdentifier: "siteLocation", sender: self)
    }
    @IBAction func brooklynBtn(_ sender: UIButton) {
        self.siteLocation = "Brooklyn"
        performSegue(withIdentifier: "siteLocation", sender: self)
    }
    @IBAction func queensBtn(_ sender: UIButton) {
        self.siteLocation = "Queens"
        performSegue(withIdentifier: "siteLocation", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let MainViewContoller = segue.destination as? MainViewController
            MainViewContoller?.siteLocation = self.siteLocation

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
