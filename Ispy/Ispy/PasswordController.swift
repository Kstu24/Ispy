//
//  LoginViewController.swift
//  Ispy
//
//  Created by Kevin Stewart on 9/12/20.
//  Copyright © 2020 Kevin Stewart. All rights reserved.
//

import Foundation
import UIKit

enum LoginType {
    case signUp
    case logIn
}
var loginType = LoginType.signUp
var logInViewController: LoginViewController?

// Segmented Items
private let segmentedItems = ["Sign up", "Log In"]

class PasswordField: UIControl {
    enum PasswordStrength {
        case weak
        case medium
        case strong
    }
    // MARK: - Properties
    //    private var stackView = UIStackView()

    private var passwordField = UIView()
    private let maxStrength = 10
    private (set) var passwordStrength: PasswordStrength = .weak {
        didSet {
            showPasswordStrength()
        }
    }
    // Public API - these properties are used to fetch the final password and strength values
    private (set) var password: String = ""
    
    private let standardMargin: CGFloat = 8.0
    private let textFieldContainerHeight: CGFloat = 50.0
    private let textFieldMargin: CGFloat = 6.0
    private let colorViewSize: CGSize = CGSize(width: 60.0, height: 5.0)
    
    private let segmentControllerFrameColor = UIColor.black.cgColor
    private let labelTextColor = UIColor(hue: 233.0/360.0, saturation: 16/100.0, brightness: 41/100.0, alpha: 1)
    private let labelFont = UIFont.systemFont(ofSize: 14.0, weight: .semibold)
    
    private let textFieldBorderColor = UIColor(hue: 208/360.0, saturation: 80/100.0, brightness: 94/100.0, alpha: 1)
    private let bgColor = UIColor(hue: 0, saturation: 0, brightness: 97/100.0, alpha: 1)
    
    // States of the password strength indicators
    private let unusedColor = UIColor(hue: 210/360.0, saturation: 5/100.0, brightness: 86/100.0, alpha: 1)
    private let weakColor = UIColor(hue: 0/360, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let mediumColor = UIColor(hue: 39/360.0, saturation: 60/100.0, brightness: 90/100.0, alpha: 1)
    private let strongColor = UIColor(hue: 132/360.0, saturation: 60/100.0, brightness: 75/100.0, alpha: 1)
    
    private var titleLabel: UILabel = UILabel()
    private var passwordTextField: UITextField = UITextField()
    private var showHideButton: UIButton = UIButton()
    private var weakView: UIView = UIView()
    private var mediumView: UIView = UIView()
    private var strongView: UIView = UIView()
    private var strengthDescriptionLabel: UILabel = UILabel()
    private var loginTextField: UITextField = UITextField()
    private var loginLabel: UILabel = UILabel()
    private var segmentedControl: UISegmentedControl = UISegmentedControl(items: segmentedItems)
    let loginButton: UIButton = UIButton()
    
    
    
    // MARK: - Object C functions
    @objc func openEye() {
        passwordTextField.isSecureTextEntry.toggle()
        if passwordTextField.isSecureTextEntry {
            showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        } else {
            showHideButton.setImage(UIImage(named: "eyes-open"), for: .normal)
        }
    }
    
    @objc func enteredNewPassword() {
        guard let password = passwordTextField.text else {
            self.password = ""
            return }
        self.password = password
        passwordTextField.resignFirstResponder()
        sendActions(for: .valueChanged)
    }
//
//    func segmentChanged() {
//        if segmentedControl.selectedSegmentIndex == 0 {
//            loginType = .signUp
//            logInViewController?.signUpButton.setTitle("Sign Up",
//                                  for: .normal)
//        } else {
//            loginType = .logIn
//            logInViewController?.signUpButton.setTitle("Log in",
//                                  for: .normal)
//        }
//    }

    // MARK: - Set Up
    func setup() {
        backgroundColor = UIColor.darkGray
        
        // Segmented Control set up
        segmentedControl.backgroundColor = UIColor.link
        segmentedControl.selectedSegmentTintColor = UIColor.white
        segmentedControl.layer.borderColor = segmentControllerFrameColor
        segmentedControl.layer.borderWidth = 1
        segmentedControl.layer.cornerRadius = 5
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        addSubview(segmentedControl)
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: topAnchor, constant: textFieldMargin),
            segmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            segmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin)
        ])
//        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .touchUpInside)

        
        
        // Set up title label for username
        loginLabel.text = "Enter Username"
        loginLabel.font = labelFont
        loginLabel.textColor = UIColor.black
        addSubview(loginLabel)
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: textFieldMargin),
            loginLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            loginLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -standardMargin)
        ])
        
        // Set up login text field
        let loginLeftOverlayView = UIView(frame: CGRect(x: 0,
                                                        y: 0,
                                                        width: textFieldMargin,
                                                        height: textFieldContainerHeight))
        loginTextField.leftView = loginLeftOverlayView
        loginTextField.leftViewMode = UITextField.ViewMode.always
        loginTextField.layer.borderColor = textFieldBorderColor.cgColor
        loginTextField.layer.borderWidth = 3.0
        loginTextField.layer.cornerRadius = 12
        loginTextField.backgroundColor = bgColor
        addSubview(loginTextField)
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginTextField.topAnchor.constraint(equalTo: loginLabel.bottomAnchor,
                                                constant: textFieldMargin),
            loginTextField.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                    constant: 0),
            loginTextField.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                     constant: 0),
            loginTextField.heightAnchor.constraint(equalToConstant:50)
        ])
        
        // Setting up title label
        titleLabel.text = "Enter Password"
        titleLabel.font = labelFont
        titleLabel.textColor = UIColor.black
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: loginTextField.bottomAnchor,
                                            constant: textFieldMargin),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                constant: 0),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                 constant: -standardMargin)
        ])
        
        // Set up text field
        passwordTextField.layer.borderColor = textFieldBorderColor.cgColor
        passwordTextField.layer.borderWidth = 3.0
        passwordTextField.layer.cornerRadius = 12
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textContentType = .password
        passwordTextField.delegate = self
        passwordTextField.backgroundColor = bgColor
        addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                                   constant:  textFieldMargin),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                       constant: 0),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                        constant: 0),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        passwordTextField.addTarget(self, action: #selector(enteredNewPassword), for: .valueChanged)
        
        // Set up hide button
        let passwordLeftOverlayView = UIView(frame: CGRect(x: 0, y: 0, width: textFieldMargin, height: textFieldContainerHeight))
        passwordTextField.leftView = passwordLeftOverlayView
        passwordTextField.leftViewMode = UITextField.ViewMode.always
        let passwordRightOverlayView = UIView(frame: CGRect(x: 0, y: 0, width: textFieldMargin, height: textFieldContainerHeight))
        passwordRightOverlayView.addSubview(showHideButton)
        passwordTextField.rightView = passwordRightOverlayView
        passwordTextField.rightViewMode = UITextField.ViewMode.always
        showHideButton.setImage(UIImage(named: "eyes-closed"), for: .normal)
        showHideButton.frame = CGRect(x: 0, y: 0, width: textFieldContainerHeight, height: textFieldContainerHeight)
        showHideButton.imageView?.contentMode = .scaleAspectFit
        showHideButton.translatesAutoresizingMaskIntoConstraints = false
        showHideButton.topAnchor.constraint(equalTo: passwordRightOverlayView.topAnchor).isActive = true
        showHideButton.bottomAnchor.constraint(equalTo: passwordRightOverlayView.bottomAnchor).isActive = true
        showHideButton.leadingAnchor.constraint(equalTo: passwordRightOverlayView.leadingAnchor, constant: textFieldMargin).isActive = true
        showHideButton.trailingAnchor.constraint(equalTo: passwordRightOverlayView.trailingAnchor, constant: -textFieldMargin).isActive = true
        showHideButton.addTarget(self, action: #selector(openEye), for: .touchUpInside)
        
        // Weak view added
        addSubview(weakView)
        weakView.layer.cornerRadius = 5
        weakView.translatesAutoresizingMaskIntoConstraints = false
        weakView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        weakView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -268).isActive = true
        weakView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10).isActive = true
        weakView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        
        // Medium view added
        addSubview(mediumView)
        mediumView.layer.cornerRadius = 5
        mediumView.translatesAutoresizingMaskIntoConstraints = false
        mediumView.leadingAnchor.constraint(equalTo: weakView.trailingAnchor, constant: 2).isActive = true
        mediumView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -200).isActive = true
        mediumView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10).isActive = true
        mediumView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        
        // Strong view added
        addSubview(strongView)
        strongView.layer.cornerRadius = 5
        strongView.translatesAutoresizingMaskIntoConstraints = false
        strongView.leadingAnchor.constraint(equalTo: mediumView.trailingAnchor, constant: 2).isActive = true
        strongView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -130).isActive = true
        strongView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10).isActive = true
        strongView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        
        // Add strength description label
        strengthDescriptionLabel.font = labelFont
        addSubview(strengthDescriptionLabel)
        strengthDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        strengthDescriptionLabel.leadingAnchor.constraint(equalTo: strongView.trailingAnchor, constant: standardMargin).isActive = true
        strengthDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        strengthDescriptionLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 2).isActive = true
        strengthDescriptionLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        // Sets initial strength views to unused until typing begins in the text field
        weakView.backgroundColor = unusedColor
        mediumView.backgroundColor = unusedColor
        strongView.backgroundColor = unusedColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // Updates password strength based on the strength of the password
    private func showPasswordStrength() {
        
        switch passwordStrength {
        case .weak:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = unusedColor
            strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = "Too weak"
            
        case .medium:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = unusedColor
            strengthDescriptionLabel.text = "Could be stronger"
        case .strong:
            weakView.backgroundColor = weakColor
            mediumView.backgroundColor = mediumColor
            strongView.backgroundColor = strongColor
            strengthDescriptionLabel.text = "Strong password"
        }
    }
    
    // Switch statement finding new password strength based on the count of characters in the password
    private func newPasswordStrength(for password: String) {
        let count = password.count
        
        switch count {
        case maxStrength...:
            if passwordStrength != .strong {
                passwordStrength = .strong
            }
        case 6...maxStrength:
            if passwordStrength != .medium {
                passwordStrength = .medium
            }
        default:
            if passwordStrength != .weak {
                passwordStrength = .weak
            }
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 120, height: 120)
    }
}

// MARK: - Extension
extension PasswordField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        // TODO: send new text to the determine strength method
        newPasswordStrength(for: newText)
        return true
    }
    
    // Returns new password and password strength
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        enteredNewPassword()
        return true
    }
    // "Flare view" animation sequence
    func performFlare() {
        func flare()   { transform = CGAffineTransform(scaleX: 1.6, y: 1.6) }
        func unflare() { transform = .identity }
        
        UIView.animate(withDuration: 0.3,
                       animations: { flare() },
                       completion: { _ in UIView.animate(withDuration: 0.1) { unflare() }})
    }
}
