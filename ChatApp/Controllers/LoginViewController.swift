//
//  LoginViewController.swift
//  ChatApp
//
//  Created by Kenneth Nagata on 5/30/18.
//  Copyright © 2018 Kenneth Nagata. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    
    var signupMode = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func presentAlert(message: String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Okay", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    @IBAction func topButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text,
            let password = passwordTextField.text {
            if signupMode {
                // sign up
                Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                    if let error = error {
                        self.presentAlert(message: error.localizedDescription)
                    } else {
                        if let user = user {
                            Database.database().reference().child("users").child(user.user.uid).child("email").setValue(user.user.email)
                            
                            self.performSegue(withIdentifier: "moveToSnaps", sender: nil)
                        }
                    }
                }
            } else {
                // log in
                Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                    if let error = error {
                        self.presentAlert(message: error.localizedDescription)
                    } else {
                        self.performSegue(withIdentifier: "moveToSnaps", sender: nil)
                    }
                }
            }
        }
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

