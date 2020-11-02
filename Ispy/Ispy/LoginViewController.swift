//
//  LoginViewController.swift
//  Ispy
//
//  Created by Kevin Stewart on 9/12/20.
//  Copyright © 2020 Kevin Stewart. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    var passwordField: PasswordField?
    
    // MARK: - Outlets
    @IBOutlet var signUpButton: UIButton!
    
    // MARK: - Actions
    @IBAction func signUpButton(_ sender: UIButton) {
    }
    
    // MARK: - Methods
    func setUp(){
        signUpButton.layer.cornerRadius = 12
        signUpButton.setTitle("Continue", for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
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
