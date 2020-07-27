//
//  JMFormItemEmailCell.swift
//  JMForm
//
//  Created by Jakob Mikkelsen on 26/07/2020.
//  Copyright © 2020 Codement. All rights reserved.
//

import UIKit

class JMFormItemEmailCell: JMFormTextFieldCell {

    override func setup() {
        super.setup()
        
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        textField.textContentType = .emailAddress
        
    }
    
}
