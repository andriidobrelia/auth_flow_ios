//
//  SignInViewDelegateProtocol.swift
//  TestProject
//
//  Created by Andrew Dobrelya on 01.07.2022.
//

import Foundation

public protocol SignInViewModelProtocol {
    func signIn(email: String, password: String, _ completion: @escaping ((Bool) -> Void))
    func validateData(email: String, password: String)
}
