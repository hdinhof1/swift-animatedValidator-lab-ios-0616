//
//  ValidatorViewController.swift
//  animated-validator-swift
//
//  Created by Flatiron School on 6/27/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ValidatorViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailConfirmationTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    
    @IBOutlet var userEntryFields: [UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.submitButton.accessibilityLabel = Constants.SUBMITBUTTON
        self.emailTextField.accessibilityLabel = Constants.EMAILTEXTFIELD
        self.emailConfirmationTextField.accessibilityLabel = Constants.EMAILCONFIRMTEXTFIELD
        self.phoneTextField.accessibilityLabel = Constants.PHONETEXTFIELD
        self.passwordTextField.accessibilityLabel = Constants.PASSWORDTEXTFIELD
        self.passwordConfirmTextField.accessibilityLabel = Constants.PASSWORDCONFIRMTEXTFIELD
        
        self.submitButton.enabled = false
    }
    
    
    
    @IBAction func emailEntered(sender: AnyObject) {
        if let hasAtSign = self.emailTextField.text?.containsString("@") {
            if let hasAPeriod = self.emailTextField.text?.containsString(".") {
                
                if hasAtSign && hasAPeriod {
                    //is good!
                }else {
                    //bad
                    makeInvalidTextFieldPulse(self.emailTextField)
                }
            }
        }
        
    }
    @IBAction func confirmEmailFieldEntered(sender: AnyObject) {
        guard let emailText = self.emailTextField.text else { return }
        guard let emailConfirmText = self.emailTextField.text else {return }
        
        if emailText == emailConfirmText {
            //good
        }else {
            //bad
            makeInvalidTextFieldPulse(self.emailConfirmationTextField)
        }
    }
    @IBAction func phoneNumberEntered(sender: AnyObject) {
        guard let phoneNumber = self.phoneTextField.text else { return }
        let hasAtLeastSixCharacters = phoneNumber.characters.count >= 7
        
        
        if let isOnlyNumbers = phoneNumber.isStringANumber() {
            if hasAtLeastSixCharacters && isOnlyNumbers {
                //good
            }else {
                //bad
                makeInvalidTextFieldPulse(self.phoneTextField)
            }
        }
    }
    @IBAction func passwordEntered(sender: AnyObject) {
        guard let passwordText = self.passwordTextField.text else { return }
        if passwordText.characters.count >= 6 {
            //good
        }else {
            //bad
            makeInvalidTextFieldPulse(self.passwordTextField)
        }
    }
    @IBAction func confirmPasswordFieldEntered(sender: AnyObject) {
        guard let passwordText = passwordTextField.text else { return }
        guard let confirmPassword = passwordConfirmTextField.text else { return }
        if passwordText == confirmPassword {
            //good
            if isAllUserInputCorrect() {
                self.submitButton.enabled = true
            }
        }else {
            //bad
            makeInvalidTextFieldPulse(self.passwordConfirmTextField)
        }
    }
    func makeInvalidTextFieldPulse(textField: UITextField) {
        UIView.animateWithDuration(0.25, delay: 0, options: [.Autoreverse, .Repeat], animations: {
            
            UIView.setAnimationRepeatCount(3.0)
            
            // This transform will cause the textField to pulse between its original dimensions and 95% of its x and y dimensions.
            
            textField.transform = CGAffineTransformMakeScale(0.90, 0.90)
            
            textField.backgroundColor = UIColor.redColor()
            
            self.view.layoutIfNeeded()
            
            
            // This is a completion clause that says the textField should return to its original dimensions when the animation is done.
            
        }) { (true) in
            
            textField.transform = CGAffineTransformMakeScale(1.0, 1.0)
        }
    }
    
    func isAllUserInputCorrect() -> Bool {
        var inputIsCorrect = true
        for field in self.userEntryFields {
            if field.backgroundColor == UIColor.redColor() {
                inputIsCorrect = false
            }
         }
        return inputIsCorrect
    }
}
extension String {
    func isStringANumber() -> Bool? {
        let number = Int(self)
        return number != nil
    }
}

