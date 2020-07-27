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
        textField.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        textField.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textField.text = nil
        textField.attributedPlaceholder = nil
        textField.layer.shadowColor = UIColor(r: 224, g: 224, b: 224, a: 0.5).cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        delegate?.didFinishCell(atIndexPath: indexPath)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        // Remove placeholder if begin editing
        textField.placeholder = nil
        
        // Add inactive border color
        textField.layer.borderColor = item?.uiProperties.borderColorActive?.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let uiProperties = item?.uiProperties else { return }
        
        // Add inactive border color
        textField.layer.borderColor = uiProperties.borderColorInActive?.cgColor
        
        // Add placeholder if end editing
        textField.attributedPlaceholder = NSAttributedString(string: uiProperties.placeholderText ?? "", attributes: [
            .foregroundColor: uiProperties.placeholderColor,
        ])
        
        item?.setValue(value: textField.text)
        
    }
    
    private func setupTextFieldUI() {
        guard let properties = item?.uiProperties else { return }
        textField.textColor = properties.textColor
        textField.attributedPlaceholder = NSAttributedString(string: properties.placeholderText ?? "",
                                                             attributes: [.foregroundColor: properties.placeholderColor])
        textField.layer.borderColor = textField.isFirstResponder ? properties.borderColorActive?.cgColor : properties.borderColorInActive?.cgColor
        
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
        self.setup()
        
    }
    
}

extension JMFormTextFieldCell: JMFormItemDelegate {
    
    func setAsFirstResponder() {
        textField.becomeFirstResponder()
    }
    
}
