//
//  ProfileViewModel.swift
//  TestProject
//
//  Created by Andrew Dobrelya on 02.07.2022.
//

import Foundation

class ProfilewModel {
    internal init() {
        loadData()
    }

    let prefs = UserDefaults.standard
    var user = Observable<User?>(nil)
    var isButtonEnabled = Observable(false)
    
    func loadData() {
        let name = prefs.string(forKey: DefaultsVariablesKey.nameKey)
        let mail = prefs.string(forKey: DefaultsVariablesKey.emailKey)
        let familyName = prefs.string(forKey: DefaultsVariablesKey.familyNameKey)
        let bio = prefs.string(forKey: DefaultsVariablesKey.bioKey)
        self.user.value = User(name: name ?? "", familyName: familyName ?? "", email: mail ?? "", bio: bio ?? "")
    }
    
    public func validateData(name:String, familyName:String, email: String) {
        self.user.value??.email = email
        self.user.value??.name = name
        self.user.value??.familyName = familyName
     }
    
    func clearUserFromPref() {
        prefs.removeObject(forKey:DefaultsVariablesKey.nameKey)
        prefs.removeObject(forKey:DefaultsVariablesKey.emailKey)
        prefs.removeObject(forKey:DefaultsVariablesKey.familyNameKey)
        prefs.removeObject(forKey:DefaultsVariablesKey.bioKey)
    }
    
    func saveUserToPref() {
        let defaults = UserDefaults.standard
        prefs.set(self.user.value??.name, forKey: DefaultsVariablesKey.nameKey)
        prefs.set(self.user.value??.familyName, forKey: DefaultsVariablesKey.familyNameKey)
        prefs.set(self.user.value??.email, forKey: DefaultsVariablesKey.emailKey)
        prefs.set(self.user.value??.bio, forKey: DefaultsVariablesKey.bioKey)
    }
}
