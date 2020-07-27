//
//  JMFormItemPhoneCell.swift
//  JMForm
//
//  Created by Jakob Mikkelsen on 27/07/2020.
//  Copyright © 2020 Codement. All rights reserved.
//

import UIKit

class JMFormItemPhoneCell: JMFormTextFieldCell {

    override func setup() {
        super.setup()
        textField.keyboardType = .phonePad
        textField.textContentType = .telephoneNumber
        
        addToolbarToTextField()
    }
    
    private func addToolbarToTextField() {
        let numberToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        numberToolbar.barStyle = .default
        numberToolbar.tintColor = .blue
        numberToolbar.barTintColor = .white
        numberToolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(doneWithKeyboard))]
        numberToolbar.sizeToFit()
        self.textField.inputAccessoryView = numberToolbar
    }

    @objc private func doneWithKeyboard() {
        textField.resignFirstResponder()
        textField.delegate?.textFieldDidEndEditing!(textField)
    }
    
    
}
