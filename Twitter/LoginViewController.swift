//
//  LoginViewController.swift
//  Twitter
//
//  Created by Dorothy on 2022/9/29.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "userloggedin")==true{
            self.performSegue(withIdentifier: "logintohome", sender: self)
        }
        
    }

    @IBAction func OnLoginButton(_ sender: Any) {
        
        let myurl = "https://api.twitter.com/oauth/request_token"
        
        TwitterAPICaller.client?.login(url: myurl, success: {
            UserDefaults.standard.set(true, forKey: "userloggedin")
            self.performSegue(withIdentifier: "logintohome", sender: self)
        }, failure: {_ in
            print("Could not login")
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
