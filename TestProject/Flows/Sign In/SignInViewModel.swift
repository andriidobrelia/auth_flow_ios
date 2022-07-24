//
//  SignInViewModel.swift
//  TestProject
//
//  Created by Andrew Dobrelya on 02.07.2022.
//

import Foundation

class SignInViewModel : SignInViewModelProtocol {
    var email = ""
    var password = ""
    var isButtonEnabled = Observable(false)
    
    public func signIn(email: String, password: String,   _ completion: @escaping ((Bool) -> Void)) {
        var data: Data = Data()
        do {
            data = try KeychainHelper.readPassword(service: "test", account: email) ?? Data()
        }
        catch {
            completion(false)
        }
        
        let storedPassword = String(decoding: data, as: UTF8.self)
        if (storedPassword == password) {
            let defaults = UserDefaults.standard
            defaults.set(email, forKey: DefaultsVariablesKey.emailKey)
            completion(true)
        }
        else {
            completion(false)
        }
    }
    
    public func validateData(email: String, password: String) {
        self.email = email
        self.password = password
        self.isButtonEnabled.value = !self.email.isEmpty && !self.password.isEmpty
    }
    
}
