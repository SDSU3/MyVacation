//
//  SignInViewController.swift
//  MyVacation
//
//  Created by Dhiaa Bantan on 3/12/22.
//  Last update by Dhiaa Bantan on 3/13/22.
//

import UIKit

class SignInUpViewController: MainViewController {
    
    //MARK: - Outlets:
    
    @IBOutlet weak var SignInUpSegment: UISegmentedControl!
    @IBOutlet weak var SignInStackView: UIStackView!
    @IBOutlet weak var SignUpStackView: UIStackView!
    
    // Sign In Outlets:
    @IBOutlet weak var SignIn_EmailTF: UITextField!
    @IBOutlet weak var SignIn_PasswordTF: UITextField!
    @IBOutlet weak var SignIn_Button: UIButton!
    
    // Sign Up Outlets:
    @IBOutlet weak var SignUp_EmailTF: UITextField!
    @IBOutlet weak var SignUp_UsernameTF: UITextField!
    @IBOutlet weak var SignUp_PasswordTF: UITextField!
    @IBOutlet weak var SignUp_ConfirmPasswordTF: UITextField!
    @IBOutlet weak var SignUp_Button: UIButton!
    
    //MARK: - Initial Values:
    
    // Sign In Info:
    var Email_SignIn: String? = nil
    var Password_SignIn: String? = nil
    
    // Sign Up Info:
    var Email_SignUp: String? = nil
    var Username_SignUp: String? = nil
    var Password_SignUp: String? = nil
    var ConfirmPassword_SignUp: String? = nil
    
    //MARK: - View Did Load:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Define textfields tags and delegates:
        SignIn_EmailTF.delegate = self
        SignIn_PasswordTF.delegate = self
        SignIn_EmailTF.tag = 0
        SignIn_PasswordTF.tag = 1
        
        SignUp_EmailTF.delegate = self
        SignUp_UsernameTF.delegate = self
        SignUp_PasswordTF.delegate = self
        SignUp_ConfirmPasswordTF.delegate = self
        SignUp_EmailTF.tag = 0
        SignUp_UsernameTF.tag = 1
        SignUp_PasswordTF.tag = 2
        SignUp_ConfirmPasswordTF.tag = 3
        
        // Hide the sign up stack view and display sign in stack view:
        SignInStackView.isHidden = false
        SignUpStackView.isHidden = true
        
        // Disable the buttons:
        SignIn_Button.isEnabled = false
        SignUp_Button.isEnabled = false
    
    }
    
    //MARK: - Sign In/Up Segment Changed:
    
    @IBAction func SignInUpSegmentChanged(_ sender: UISegmentedControl) {
        
        // Disable the buttons:
        SignIn_Button.isEnabled = false
        SignUp_Button.isEnabled = false
        
        // Clear the information:
        Email_SignIn = nil
        Password_SignIn = nil
        Email_SignUp = nil
        Username_SignUp = nil
        Password_SignUp = nil
        ConfirmPassword_SignUp = nil
        
        // Actions based on the selected segment:
        if(SignInUpSegment.selectedSegmentIndex == 0){
            
            SignIn_EmailTF.becomeFirstResponder()
            
            SignInStackView.isHidden = false
            SignUpStackView.isHidden = true
            
            SignUp_EmailTF.text?.removeAll()
            SignUp_UsernameTF.text?.removeAll()
            SignUp_PasswordTF.text?.removeAll()
            SignUp_ConfirmPasswordTF.text?.removeAll()
            
        } else {
            
            SignUp_EmailTF.becomeFirstResponder()
            
            SignInStackView.isHidden = true
            SignUpStackView.isHidden = false
            
            SignIn_EmailTF.text?.removeAll()
            SignIn_PasswordTF.text?.removeAll()
        }
    }
    
    //MARK: - Get Sign In Info:
    
    @IBAction func SignIn_Email(_ sender: UITextField) {
        Email_SignIn = SignIn_EmailTF.text
        SignIn_Validation()
    }
    
    @IBAction func SignIn_Password(_ sender: UITextField) {
        Password_SignIn = SignIn_PasswordTF.text
        SignIn_Validation()
    }
    
    //MARK: - Sign In Button Action:
    
    @IBAction func SignIn_ButtonPressed(_ sender: UIButton) {
        
        print("\(Email_SignIn) should be signed in..")
    }
    
    //MARK: - Get Sign Up Info:
    @IBAction func SignUp_Email(_ sender: UITextField) {
        Email_SignUp = SignUp_EmailTF.text
        SignUp_Validation()
    }
    
    @IBAction func SignUp_Username(_ sender: UITextField) {
        Username_SignUp = SignUp_UsernameTF.text
        SignUp_Validation()
    }
    
    @IBAction func SignUp_Password(_ sender: UITextField) {
        Password_SignUp = SignUp_PasswordTF.text
        SignUp_Validation()
    }
    
    @IBAction func SignUp_ConfirmPassword(_ sender: UITextField) {
        ConfirmPassword_SignUp = SignUp_ConfirmPasswordTF.text
        SignUp_Validation()
    }
    
    //MARK: - Sign Up Button Action:
    
    @IBAction func SignUP_ButtonPressed(_ sender: UIButton) {
        if(SignUp_PasswordTF.text == SignUp_ConfirmPasswordTF.text){
            print("Create a \(Username_SignUp) account..")
        }
        else {
            print("Password and password confirmation doesn't match!")
        }
    }
    
    //MARK: - Validations:
    
    // Sign In Validation:
    func SignIn_Validation(){
        if((SignIn_EmailTF.text == nil) || (SignIn_PasswordTF.text == nil) || (SignIn_EmailTF.text == "") || (SignIn_PasswordTF.text == "")){
            SignIn_Button.isEnabled = false
        } else {
            SignIn_Button.isEnabled = true
        }
    }
    
    // Sign Up Validation:
    func SignUp_Validation(){
        if((SignUp_EmailTF.text == nil) || (SignUp_UsernameTF.text == nil) || (SignUp_PasswordTF.text == nil) || (SignUp_ConfirmPasswordTF.text == nil) || (SignUp_EmailTF.text == "") || (SignUp_UsernameTF.text == "") || (SignUp_PasswordTF.text == "") || (SignUp_ConfirmPasswordTF.text == "")){
            SignUp_Button.isEnabled = false
        } else {
            SignUp_Button.isEnabled = true
        }
    }
    
    //MARK: - Keyboard Helper Functions:
    
    // Hide keyboard when touch any area out side the textField:
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true);
        super.touchesBegan(touches, with: event);
    }
    
    
    
    
    static func load(with input: String) -> SignInUpViewController {
        let viewController = SignInUpViewController.loadFromStoryboard()
        return viewController
    }
    
}


//MARK: - Extension to manage the keyboard:
extension SignInUpViewController: UITextFieldDelegate {
    
    // Move to the next text field or hide the keyboard when click on return (Done/Continue/Go) button:
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Try to find next textField:
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
            
        } else {
            // Not found, so hide keyboard:
            textField.resignFirstResponder()
            
        }
        
        return false
    }
    
}
