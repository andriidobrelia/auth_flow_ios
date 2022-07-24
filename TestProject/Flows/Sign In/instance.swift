//
//  instance.swift
//  TestProject
//
//  Created by Andrew Dobrelya on 01.07.2022.
//

import Foundation
import UIKit

extension SignInViewController {
    
    public static var storyboard: UIStoryboard {
        return UIStoryboard.init(name: "SignInScreen", bundle: Bundle.init(for: self))
    }
    
    public static func instance(delegate: SignInViewDelegateProtocol) -> SignInViewController? {
        let vc = storyboard.instantiateInitialViewController() as? SignInViewController
        vc?.delegate = delegate
        return vc
    }
    
    public var inNavigationController: UINavigationController {
        let nav = UINavigationController.init(rootViewController: self)
        return nav
    }
}
 
