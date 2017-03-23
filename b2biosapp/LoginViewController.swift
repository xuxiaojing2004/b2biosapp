//
//  LoginViewController.swift
//  b2biosapp
//
//  Created by Xiaojing Xu on 3/19/17.
//  Copyright © 2017 jikesai. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginUsername: UITextField!
    
    @IBOutlet weak var loginPassword: UITextField!
    
    @IBOutlet weak var rememberMe: UISwitch!
    
    let authenticationService : AuthenticationService = AuthenticationServiceImpl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let preferences = UserDefaults.standard
        
        
        if let username = (preferences.object(forKey: Constants.DEFAULT_USERNAME)) {
            loginUsername.text = username as? String
            rememberMe.setOn(true, animated: false)
        } else {
            rememberMe.setOn(false,animated: false)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(_ sender: UIButton) {
        print("login through\(loginUsername.text!)/ \(loginPassword.text!)")
        
        self.remember(self.rememberMe)
        
        let appLoginModel = AppLoginModel()
        appLoginModel.username = loginUsername.text!
        appLoginModel.password = loginPassword.text!
        appLoginModel.clientId = Constants.SSO_LOGIN_CLIENT_ID
        appLoginModel.clientSecret = Constants.SSO_LOGIN_CLIENT_SECRET
        
        do {
            try authenticationService.ssoLogin(appLoginModel: appLoginModel) { (result) in
            
                print("auth result: \(result)")
            }
        } catch let error as NSError {
            print("Fail to authenticate. \(error), \(error.userInfo)")
                
        }
    }

    @IBAction func remember(_ sender: UISwitch) {
        let isOn = sender.isOn
        let preferences = UserDefaults.standard
        
        if isOn {
            print("save username \(loginUsername.text!) for future use")
            preferences.set(loginUsername.text!, forKey: Constants.DEFAULT_USERNAME)
        } else {
            print("remove object from preferences")
            preferences.removeObject(forKey: Constants.DEFAULT_USERNAME)
        }
    }
    
    func rememberUsername(isOn: Bool) {
        let preferences = UserDefaults.standard
        
        if isOn {
            preferences.set(loginUsername.text!, forKey: Constants.DEFAULT_USERNAME)
        } else {
            preferences.removeObject(forKey: Constants.DEFAULT_USERNAME)
        }
    }
    
    @IBAction func forgetPassword(_ sender: UIButton) {
        
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
