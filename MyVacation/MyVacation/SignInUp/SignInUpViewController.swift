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
    @IBOutlet private weak var SignInUpSegment: UISegmentedControl!
    @IBOutlet private weak var SignInStackView: UIStackView!
    @IBOutlet private weak var SignUpStackView: UIStackView!
    
    // Sign In Outlets:
    @IBOutlet private weak var SignIn_EmailTF: UITextField!
    @IBOutlet private weak var SignIn_PasswordTF: UITextField!
    @IBOutlet private weak var SignIn_Button: UIButton!
    
    // Sign Up Outlets:
    @IBOutlet private weak var SignUp_EmailTF: UITextField!
    @IBOutlet private weak var SignUp_UsernameTF: UITextField!
    @IBOutlet private weak var SignUp_PasswordTF: UITextField!
    @IBOutlet private weak var SignUp_ConfirmPasswordTF: UITextField!
    @IBOutlet private weak var SignUp_Button: UIButton!
    
    private var selectedProcess: Process = .signIn
    private var signInTextFields: [UITextField]?
    private var signUpTextFields: [UITextField]?
    
    //MARK: - View Did Load:
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpComponents()
    }
    
    // MARK: - init
    static func loadController() -> SignInUpViewController {
        let viewController = SignInUpViewController.loadFromStoryboard()
        return viewController
    }
    
    private func setUpComponents() {
        // sign in
        // Define textfields tags and delegates
        signInTextFields = [SignIn_EmailTF,SignIn_PasswordTF]
        signInTextFields?.forEach({ $0.delegate = self })

        // sign up
        // Define textfields tags and delegates
        signUpTextFields = [SignUp_EmailTF,SignUp_UsernameTF, SignUp_PasswordTF, SignUp_ConfirmPasswordTF]
        signUpTextFields?.forEach({ $0.delegate = self })
        
        // Hide the sign up stack view and display sign in stack view:
        SignInStackView.isHidden = false
        SignUpStackView.isHidden = true
        
        // Disable the buttons:
        SignIn_Button.isEnabled = false
        SignUp_Button.isEnabled = false
    }
    
    //MARK: - Sign In/Up Segment Changed:
    @IBAction func SignInUpSegmentChanged(_ sender: UISegmentedControl) {
        selectedProcess = SignInUpSegment.selectedSegmentIndex == 0 ? .signIn : .signUp
        // Disable the buttons:
        SignIn_Button.isEnabled = false
        SignUp_Button.isEnabled = false
        
        // Actions based on the selected segment:
        if(selectedProcess == .signIn){
            SignIn_EmailTF.becomeFirstResponder()
            SignInStackView.isHidden = false
            SignUpStackView.isHidden = true
            signUpTextFields?.forEach({ $0.text?.removeAll() })
        } else {
            SignUp_EmailTF.becomeFirstResponder()
            SignInStackView.isHidden = true
            SignUpStackView.isHidden = false
            signInTextFields?.forEach({ $0.text?.removeAll() })
        }
    }

    //MARK: - Sign In Button Action:
    @IBAction func SignIn_ButtonPressed(_ sender: UIButton) {
        if let username = SignIn_EmailTF.text,
           let password = SignIn_PasswordTF.text {
            signInUser(username: username, password: password)
        } else {
            print("fill text fills")
        }
    }
    
    private func signInUser(username: String, password: String) {
        UserServices.signIn(username: username, password: password,
                            completion: { [weak self] success in
            if success {
                self?.moveToTabBar()
            } else {
                print("could not log in")
            }
        })
    }
    
    //MARK: - Sign Up Button Action:
    @IBAction func SignUP_ButtonPressed(_ sender: UIButton) {
        if SignUp_PasswordTF.text == SignUp_ConfirmPasswordTF.text {
            signUp()
        } else {
            print("Password and password confirmation doesn't match!")
        }
    }
    
    private func signUp() {
        if let newUsername = SignUp_UsernameTF.text,
           let newPassword = SignUp_PasswordTF.text,
           let newEmail = SignUp_EmailTF.text {
            UserServices.signUp(username: newUsername,
                                password: newPassword,
                                email: newEmail,
                                completion: { [weak self] success in
                if success {
                    self?.signInUser(username: newUsername, password: newPassword)
                } else {
                    print("something went wrong")
                }
            })
        } else {
            print("fill empty fields")
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
    
    private func moveToTabBar() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let delegate = windowScene.delegate as? SceneDelegate else { return }
        delegate.window?.rootViewController = TabBarController()
    }
    
    //MARK: - Keyboard Helper Functions:
    
    // Hide keyboard when touch any area out side the textField:
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true);
        super.touchesBegan(touches, with: event);
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        selectedProcess == .signIn ? SignIn_Validation() : SignUp_Validation()
    }
}

extension SignInUpViewController {
    enum Process: Int {
        case signIn = 0
        case signUp = 1
    }
}
