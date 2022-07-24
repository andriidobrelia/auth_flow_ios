//
//  OneLineTextField.swift
//  TestProject
//
//  Created by Andrew Dobrelya on 02.07.2022.
//

import UIKit

class OneLineTextField: UITextField {

    override func awakeFromNib() {
            super.awakeFromNib()
        initView()
        
    }

    
    func initView() {
        let underLineView = UIView()
        underLineView.translatesAutoresizingMaskIntoConstraints = false
        underLineView.backgroundColor = .black
        addSubview(underLineView)
        
        NSLayoutConstraint.activate([
            underLineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            underLineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            underLineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            underLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    
}

extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {return self.placeHolderColor}
        set {self.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil
                                                             ? self.placeholder! : "", attributes: [NSAttributedString.Key.foregroundColor : newValue!]
        )}
    }
}
