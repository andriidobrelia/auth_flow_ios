//
//  RegistrationViewController.swift
//  TestProject
//
//  Created by Andrew Dobrelya on 02.07.2022.
//

import UIKit

open class RegistrationViewController: UIViewController {
    var viewModel = RegistrationViewModel()
    
    @IBOutlet var nameField: OneLineTextField!
    
    @IBOutlet var familyNameField: OneLineTextField!
    
    @IBOutlet var emailField: OneLineTextField!
    
    @IBOutlet var passwordField: OneLineTextField!
    
    @IBOutlet var termsAndConditionToggle: UISwitch!
    
    @IBOutlet var saveButton: UIButton!
    
    @IBAction func toggleChange(_ sender: UISwitch) {
        if sender.isOn {
            checkScreen()
            termsAndConditionToggle.isOn = true
        }
        else {
            checkScreen()
            termsAndConditionToggle.isOn = false
        }
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        setupAddTargetIsNotEmptyTextFields()
        bindViewModel()
    }
    
    func setupAddTargetIsNotEmptyTextFields() {
        nameField?.addTarget(self, action: #selector(textFieldDidChange),
                            for: .editingChanged)
        familyNameField?.addTarget(self, action: #selector(textFieldDidChange),
                                  for: .editingChanged)
        emailField?.addTarget(self, action: #selector(textFieldDidChange),
                             for: .editingChanged)
        passwordField?.addTarget(self, action: #selector(textFieldDidChange),
                                for: .editingChanged)
    }
    
    func bindViewModel() {
        viewModel.isButtonEnabled.bind({ (isEnable) in
            DispatchQueue.main.async {
                self.saveButton?.isEnabled = isEnable ?? false
            }
        })
    }
    
    @IBAction func saveButtonPressed() {
        viewModel.save(name:self.nameField.text!, familyName: self.familyNameField.text!, email: self.emailField.text!, password: self.passwordField.text!)
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let signInViewController = storyboard.instantiateViewController(withIdentifier: "signIn") as! SignInViewController
        if let delegate =   (UIApplication.shared.connectedScenes.first?.delegate) as? SceneDelegate {
            delegate.changeRootViewController(signInViewController)
        }
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        checkScreen()
    }
    
    func checkScreen() {
        self.viewModel.validateData(name:self.nameField.text ?? "", familyName: self.familyNameField.text ?? "", email: self.emailField.text ?? "", password: self.passwordField.text ?? "", isToggleEnable: self.termsAndConditionToggle.isOn)
    }
}

