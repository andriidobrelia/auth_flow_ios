//
//  SignInViewController.swift
//  TestProject
//
//  Created by Andrew Dobrelya on 30.06.2022.
//

import UIKit

open class SignInViewController: UIViewController {
    var viewModel = SignInViewModel()
    
    @IBOutlet var emailField: OneLineTextField!
    
    @IBOutlet var passwordField: OneLineTextField!
    
    @IBOutlet var signInButton: UIButton!
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        viewModel.signIn(email: emailField.text!, password: passwordField.text!, { (isSuccess) in
            if isSuccess { //todo delete
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
                
                if let delegate =   (UIApplication.shared.connectedScenes.first?.delegate) as? SceneDelegate {
                    delegate.changeRootViewController(mainTabBarController)
                }
                
            }
            else {
                self.showErrorDialog()
            }
            
        })
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let registrationViewController = storyboard.instantiateViewController(withIdentifier: "signUp") as! RegistrationViewController
        if let delegate =   (UIApplication.shared.connectedScenes.first?.delegate) as? SceneDelegate {
            delegate.changeRootViewController(registrationViewController)
        }
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        setupAddTargetIsNotEmptyTextFields()
        bindViewModel()
    }
    
    func bindViewModel() {
        viewModel.isButtonEnabled.bind({ (isEnable) in
            DispatchQueue.main.async {
                self.signInButton.isEnabled = isEnable ?? false
            }
        })
    }
    
    func setupAddTargetIsNotEmptyTextFields() {
        
        emailField.addTarget(self, action: #selector(textFieldDidChange),
                             for: .editingChanged)
        passwordField.addTarget(self, action: #selector(textFieldDidChange),
                                for: .editingChanged)
    }
    
    @objc func showErrorDialog() {
        let alert = UIAlertController(title: "Wrong credentials", message: "Access is denied. Check credentials and try again", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func textFieldDidChange() {
        self.viewModel.validateData(email: self.emailField.text ?? "", password: self.passwordField.text ?? "")
    }
    
}

