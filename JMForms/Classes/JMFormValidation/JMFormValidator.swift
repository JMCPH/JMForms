//
//  JMFormValidator.swift
//  JMForm
//
//  Created by Jakob Mikkelsen on 26/07/2020.
//  Copyright © 2020 Codement. All rights reserved.
//

// Types of validation JMForm can perform
public enum JMFormValidator {
    case email(errorString: String)
    case equalEmail(item: JMFormItem, errorString: String)
    case name(errorString: String)
    case age(errorString: String)
    case password(minimumCount: Int, errorString: String)
    case url(errorString: String)
    case numeric(errorString: String)
    case image(errorString: String)
}
