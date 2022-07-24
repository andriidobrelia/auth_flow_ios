//
//  Observer.swift
//  TestProject
//
//  Created by Andrew Dobrelya on 02.07.2022.
//

import Foundation

class Observable<T> {
    private var listener: ((T?) -> Void)?
    
    func bind(_ listener: @escaping (T?)-> Void) {
        listener(value)
        self.listener = listener
    }
    
    var value: T? {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T?) {
        self.value = value
    }
}
