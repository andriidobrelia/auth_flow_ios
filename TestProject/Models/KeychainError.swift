//
//  KeychainError.swift
//  TestProject
//
//  Created by Andrew Dobrelya on 02.07.2022.
//

import Foundation

enum KeychainError: Error {
       case itemNotFound
       
       case duplicateItem
       
       case invalidItemFormat
       
       case unexpectedStatus(OSStatus)
   }

