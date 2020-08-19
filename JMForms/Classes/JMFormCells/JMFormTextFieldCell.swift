//
//  JMFormTextFieldCell.swift
//  JMForm
//
//  Created by Jakob Mikkelsen on 16/07/2020.
//  Copyright © 2020 Codement. All rights reserved.
//

import UIKit

class JMFormTextFieldCell: JMFormTableViewCell, UITextFieldDelegate {
    
    public let textField: UITextField = {
        let t = UITextField(frame: .zero)
        t.backgroundColor = .white
        t.clipsToBounds = true
        t.borderStyle = .none
        t.layer.cornerRadius = 3.0
        t.layer.borderWidth = 1.0
        t.font = UIFont.systemFont(ofSize: 15)
        return t
    }()
    
    deinit {
        textField.delegate = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Add subviews
        contentView.addSubview(textField)
        
        // Define layout
        defineLayout()
        
        textField.delegate = self
        
    }
    
    override func draw(_ rect: CGRect) {
        textField.setLeftPaddingPoints(12)
        
        textField.layer.masksToBounds = false
        textField.layer.shadowRadius = 4.0
        textField.layer.shadowColor = UIColor(r: 224, g: 224, b: 224, a: 0.5).cgColor
        textField.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        textField.layer.shadowOpacity = 1.0
    }
    
    public func defineLayout() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        textField.heightAnchor.constraint(greaterThanOrEqualToConstant: 45).isActive = true
        textField.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        textField.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textField.text = nil
        textField.attributedPlaceholder = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        delegate?.didFinishCell(atIndexPath: indexPath)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        // Remove placeholder if begin editing
        textField.placeholder = nil
        
        // Add active border color
        textField.layer.borderColor = item?.appearance.borderColorActive?.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let appearance = item?.appearance else { return }
        
        // Add inactive border color
        textField.layer.borderColor = appearance.borderColorInActive?.cgColor
        
        // Add placeholder if end editing
        textField.attributedPlaceholder = NSAttributedString(string: item?.placeholderText ?? "", attributes: [
            .foregroundColor: appearance.placeholderColor,
        ])
        
        let trimmedString = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        item?.setValue(value: trimmedString)
        
    }
    
    private func setupTextFieldUI() {
        guard let appearance = item?.appearance else { return }
        textField.textColor = appearance.titleColor
        textField.attributedPlaceholder = NSAttributedString(string: item?.placeholderText ?? "",
                                                             attributes: [.foregroundColor: appearance.placeholderColor])
        textField.layer.borderColor = textField.isFirstResponder ? appearance.borderColorActive?.cgColor : appearance.borderColorInActive?.cgColor
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension JMFormTextFieldCell: JMFormUpdatable {
    
    func update(withForm item: JMFormItem) {
        self.item = item
        self.item?.delegate = self
        
        // Setup the text to be the value of the item
        self.textField.text = item.getValue()
        
        // Setup the UI of the textfield
        self.setupTextFieldUI()
        
        // Setup the subclass cell
        switch item.cellType {
            case .textfield(let type):
                self.setupTextField(withType: type)
            
            default: break
        }
        
    }
    
}

extension JMFormTextFieldCell: JMFormItemDelegate {
    
    func setAsFirstResponder() {
        textField.becomeFirstResponder()
    }
    
}


// MARK: - Setup e-mail textfield

extension JMFormTextFieldCell {
    
    private func setupTextField(withType type: JMFormItemType?) {
        guard let type = type else { return }
        
        switch type {
        
        case .firstName:
            textField.autocorrectionType = .no
            textField.autocapitalizationType = .words
            textField.keyboardType = .asciiCapable
            textField.textContentType = .givenName
            
        case .lastName:
            textField.autocorrectionType = .no
            textField.autocapitalizationType = .words
            textField.keyboardType = .asciiCapable
            textField.textContentType = .familyName
            
        case .email:
            textField.autocorrectionType = .no
            textField.autocapitalizationType = .none
            textField.keyboardType = .emailAddress
            textField.textContentType = .emailAddress
            
        case .password:
            textField.autocorrectionType = .no
            textField.autocapitalizationType = .none
            textField.keyboardType = .asciiCapable
            textField.isSecureTextEntry = true
            textField.textContentType = .password
            
        case .newPassword:
            textField.autocorrectionType = .no
            textField.autocapitalizationType = .none
            textField.keyboardType = .asciiCapable
            textField.isSecureTextEntry = true
            textField.textContentType = .newPassword
            
        case .phone:
            textField.keyboardType = .phonePad
            textField.textContentType = .telephoneNumber
            
        case .postalCode:
            textField.autocorrectionType = .no
            textField.autocapitalizationType = .allCharacters
            textField.keyboardType = .numbersAndPunctuation
            textField.textContentType = .postalCode
            
        default: break
        }
        
    }
    
//
// NOT USED AT THE  MOMENT - These functions are used to add a toolbar on top of the keyboard without a return button
//
    
//    private func addToolbarToTextField() {
//        let numberToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
//        numberToolbar.barStyle = .default
//        numberToolbar.tintColor = .blue
//        numberToolbar.barTintColor = .white
//        numberToolbar.items = [
//            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
//            UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(doneWithKeyboard))]
//        numberToolbar.sizeToFit()
//        self.textField.inputAccessoryView = numberToolbar
//    }
//
//    @objc private func doneWithKeyboard() {
//        textField.resignFirstResponder()
//        textField.delegate?.textFieldDidEndEditing!(textField)
//    }
    
}

