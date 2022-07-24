//
//  RegistrationViewModelProtocol.swift
//  TestProject
//
//  Created by Andrew Dobrelya on 02.07.2022.
//

import Foundation

protocol RegistrationViewModelProtocol: AnyObject {
 func save(name:String, familyName:String, email: String, password: String)
 func validateData(name:String, familyName:String, email: String, password: String, isToggleEnable: Bool)
}
