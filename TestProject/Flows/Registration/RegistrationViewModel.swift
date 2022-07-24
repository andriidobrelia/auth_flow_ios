//
//  RegistrationViewModel.swift
//  TestProject
//
//  Created by Andrew Dobrelya on 02.07.2022.
//

import Foundation

class RegistrationViewModel : RegistrationViewModelProtocol {
    var name = ""
    var familyName = ""
    var email = ""
    var password = ""
    var isButtonEnabled = Observable(false)
    var isToggleEnabled = false
    
    public func save(name:String, familyName:String, email: String, password: String) {
        do {
           try KeychainHelper.saveData(password: password.data(using: .utf8) ?? Data(), service: "test", account: email)
        }
        catch {
            print("error")
        }
        let defaults = UserDefaults.standard
        defaults.set(name, forKey: DefaultsVariablesKey.nameKey)
        defaults.set(familyName, forKey: DefaultsVariablesKey.familyNameKey)
    }
    
    public func validateData(name:String, familyName:String, email: String, password: String, isToggleEnable: Bool) {
        self.email = email
        self.password = password
        self.name = name
        self.familyName = familyName
        self.isToggleEnabled = isToggleEnable
        self.isButtonEnabled.value = !self.name.isEmpty && !self.familyName.isEmpty && !self.email.isEmpty && !self.password.isEmpty && self.isToggleEnabled
     }
}


struct DefaultsVariablesKey {
    static var nameKey = "nameKey"
    static var familyNameKey = "familyNameKey"
    static var emailKey = "emailKey"
    static var bioKey = "boiKey"
}

