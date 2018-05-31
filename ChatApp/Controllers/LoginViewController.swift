//
//  LoginViewController.swift
//  ChatApp
//
//  Created by Kenneth Nagata on 5/30/18.
//  Copyright © 2018 Kenneth Nagata. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    
    var signupMode = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func topButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func bottomButtonPressed(_ sender: UIButton) {
        if signupMode {
            // Switch to login
            signupMode = false
            topButton.setTitle("Log In", for: .normal)
            bottomButton.setTitle("Switch To Sign Up", for: .normal)
        } else {
            // Switch to sign up
            signupMode = true
            topButton.setTitle("Sign Up", for: .normal)
            bottomButton.setTitle("Switch To Login", for: .normal)
        }
    }
    


}

