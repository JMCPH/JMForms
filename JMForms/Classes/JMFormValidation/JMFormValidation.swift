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
            
        case .email:
            guard let email: String = getValue() else {
                return .init(isValid: false, errorString: "Please type in an e-mail.")
            }
            let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            return .init(isValid: validate(string: email, withRegex: regex), errorString: "Please type in a valid email.")
            
        case .equalEmail(let item):
            guard let email: String = getValue(), let equalItemString: String = item.getValue() else {
                return .init(isValid: false, errorString: "Emails does not match.")
            }
            return .init(isValid: email == equalItemString, errorString: "Emails does not match.")
            
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
            
        case .url:
            guard let url: String = getValue() else {
                return .init(isValid: false, errorString: "Please type in a valid url.")
            }
            let regex = "(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
            return .init(isValid: validate(string: url, withRegex: regex), errorString: "Please type in a valid url.")
            
        case .numeric:
            guard let numericString: String = getValue() else {
                return .init(isValid: false, errorString: "Please type in a valid numeric for \(titleText ?? "")")
            }
            let regex = "[^0-9]"
            return .init(isValid: validate(string: numericString, withRegex: regex), errorString: "Please type in a valid numeric for \(titleText ?? "")")
            
            
        case .image:
            guard let _: UIImage = getValue() else {
                return .init(isValid: false, errorString: "Please add an image")
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
