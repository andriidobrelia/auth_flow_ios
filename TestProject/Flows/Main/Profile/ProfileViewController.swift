//
//  ProfileViewController.swift
//  TestProject
//
//  Created by Andrew Dobrelya on 02.07.2022.
//

import UIKit

class ProfileViewController: UIViewController, UITextViewDelegate {
    var viewModel = ProfilewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.user.bind({ (user) in
            self.emailField.text = user??.email
            self.nameField.text = user??.name
            self.familyNameField.text = user??.familyName
            self.bioTextView.text = user??.bio
        })
        bioTextView.delegate = self
        setupAddTargetIsNotEmptyTextFields()
        initAndDisplayLocation()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initAndDisplayLocation()
    }
    
    func initAndDisplayLocation() {
        if let lastUserLocation = locationManager.lastUserLocation {
            let latitude: String = String(format: "%.2f", lastUserLocation.coordinate.latitude)
            let longitude: String =
            String(format: "%.2f", lastUserLocation.coordinate.longitude)
    
            locationLabel.text = "Last user Location: \(latitude), \(longitude)"
        } else {
            locationManager.requestAuthorization() {
                self.locationManager.startLacationUdpates()
            }
        }
    }

    var isEditingMode: Bool = false
    
    private let locationManager = LocationManager()
    
    @IBAction func signOutButton(_ sender: Any) {
        showErrorDialog()
    }

    @IBOutlet var editButton: UIBarButtonItem!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var nameField: UITextField!
    @IBOutlet var familyNameField: UITextField!
    @IBOutlet var bioTextView: UITextView!
    @IBOutlet var locationLabel: UILabel!
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        if (isEditingMode) {
            editButton.title = "Edit"
            emailField.isUserInteractionEnabled = false
            nameField.isUserInteractionEnabled = false
            familyNameField.isUserInteractionEnabled = false
            bioTextView.isUserInteractionEnabled = false
            isEditingMode = false
            self.viewModel.saveUserToPref()
        }
        else {
            editButton.title = "Save"
            emailField.isUserInteractionEnabled = true
            nameField.isUserInteractionEnabled = true
            familyNameField.isUserInteractionEnabled = true
            bioTextView.isUserInteractionEnabled = true
            isEditingMode = true
        }

    }

    
    @objc func showErrorDialog() {
        // create the alert
            let alert = UIAlertController(title: "Log out", message: "Are you sure you want to log out?", preferredStyle: UIAlertController.Style.alert)

            // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.destructive, handler: {( _) in
            
            self.viewModel.clearUserFromPref()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainTabBarController = storyboard.instantiateViewController(identifier: "AuthNavigationController")
          
            if let delegate =   (UIApplication.shared.connectedScenes.first?.delegate) as? SceneDelegate {
                delegate.changeRootViewController(mainTabBarController)
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil))

            // show the alert
            self.present(alert, animated: true, completion: nil)
    }
    
    func setupAddTargetIsNotEmptyTextFields() {
        editButton.title = "Edit"
        nameField?.addTarget(self, action: #selector(textFieldDidChange),
                            for: .editingChanged)
        familyNameField?.addTarget(self, action: #selector(textFieldDidChange),
                                  for: .editingChanged)
        emailField?.addTarget(self, action: #selector(textFieldDidChange),
                             for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.viewModel.validateData(name:self.nameField.text ?? "", familyName: self.familyNameField.text ?? "", email: self.emailField.text ?? "")
    }
    
    func textViewDidChange(textView: UITextView) {
        viewModel.user.value??.bio = bioTextView.text;
    }
}
