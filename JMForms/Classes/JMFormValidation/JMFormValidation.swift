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
        
        // Validate only if the field is required.
        guard isRequired else {
            return .init(isValid: true, errorString: nil)
        }
        
        // Validate the form item.
        switch validator {
            
        case .email(let errorString):
            guard let email: String = getValue() else {
                return .init(isValid: false, errorString: errorString)
            }
            let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            return .init(isValid: validate(string: email, withRegex: regex), errorString: errorString)
            
        case .equalEmail(let item, let errorString):
            guard let email: String = getValue(), let equalItemString: String = item.getValue() else {
                return .init(isValid: false, errorString: errorString)
            }
            return .init(isValid: email == equalItemString, errorString: errorString)
            
        case .password(let minimumCount, let errorString):
            guard let password: String = getValue() else {
                return .init(isValid: false, errorString: errorString)
            }
            
            let isValid = password.count >= minimumCount
            return .init(isValid: isValid, errorString: errorString)
            
        case .name(let errorString):
            guard let name: String = getValue(), name.count > 1 else {
                return .init(isValid: false, errorString: errorString)
            }
            
        case .age(let errorString):
            guard let ageString: String = getValue(), let age = Int(ageString), age > 0, age < 130 else {
                return .init(isValid: false, errorString: errorString)
            }
            
            return .init(isValid: true, errorString: nil)
            
        case .url(let errorString):
            guard let url: String = getValue() else {
                return .init(isValid: false, errorString: errorString)
            }
            let regex = "(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
            return .init(isValid: validate(string: url, withRegex: regex), errorString: errorString)
            
        case .numeric(let errorString):
            guard let numericString: String = getValue() else {
                return .init(isValid: false, errorString: errorString)
            }
            let regex = "[^0-9]"
            return .init(isValid: validate(string: numericString, withRegex: regex), errorString: errorString)
            
            
        case .image(let errorString):
            guard let _: UIImage = getValue() else {
                return .init(isValid: false, errorString: errorString)
            }
            return .init(isValid: true, errorString: nil)
            
        case .none:
            return .init(isValid: true, errorString: nil)
            
        }
        
        return .init(isValid: true, errorString: nil)
    }
    
    private func validate(string: String, withRegex regex: String) -> Bool {
        let predication = NSPredicate(format:"SELF MATCHES %@", regex)
        return predication.evaluate(with: string)
    }
    
}
