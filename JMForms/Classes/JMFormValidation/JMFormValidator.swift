//
//  JMFormValidator.swift
//  JMForm
//
//  Created by Jakob Mikkelsen on 26/07/2020.
//  Copyright © 2020 Codement. All rights reserved.
//

// Types of validation JMForm can perform
public enum JMFormValidator {
    case email
    case equalEmail(item: JMFormItem)
    case name
    case age
    case password(minimumCount: Int)
    case url
    case numeric
}
