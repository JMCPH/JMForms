//
//  JMFormValidation.swift
//  JMForms
//
//  Created by Jakob Mikkelsen on 10/07/2020.
//  Copyright © 2020 Codement. All rights reserved.
//

import UIKit
import CoreLocation

/// Conform receiver to have data validation behavior
public protocol JMFormValidable {
    var validator: JMFormValidator? {get}
    func validate() -> JMFormValidation
}

extension JMFormItem: JMFormValidable {
    
    public func validate() -> JMFormValidation {
        
        switch validator {
        case .email:
            guard let email: String = getValue() else {
                return .init(isValid: false, errorString: "Please type in an e-mail.")
            }
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            let isValid = emailPred.evaluate(with: email)
            return .init(isValid: isValid, errorString: "Please type in a valid email.")
            
        case .password(let minimumCount):
            guard let password: String = getValue() else {
                return .init(isValid: false, errorString: "Please type in a valid password.")
            }
            
            let isValid = password.count >= minimumCount
            return .init(isValid: isValid, errorString: "Password needs to be at least 6 characters.")
            
        case .name:
            guard let name: String = getValue(), name.count > 1 else {
                return .init(isValid: false, errorString: "Please type in a valid name.")
            }
            
        case .age:
            guard let ageString: String = getValue(), let age = Int(ageString), age > 0, age < 130 else {
                return .init(isValid: false, errorString: "Please type in a valid age.")
            }
            
            return .init(isValid: true, errorString: nil)
            
        case .none:
            return .init(isValid: true, errorString: nil)
            
        }
        
        return .init(isValid: true, errorString: nil)
    }
    
}
