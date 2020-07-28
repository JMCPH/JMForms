//
//  JMFormTextViewCell.swift
//  JMForm
//
//  Created by Jakob Mikkelsen on 28/07/2020.
//  Copyright © 2020 Codement. All rights reserved.
//

import UIKit

class JMFormTextViewCell: JMFormTableViewCell, UITextViewDelegate {
    
    let textView: UITextView = {
        let t = UITextView(frame: .zero)
        t.backgroundColor = .clear
        t.textContainerInset = .zero
        t.textContainer.lineFragmentPadding = 0
        t.textColor = UIColor(r: 54, g: 54, b: 54)
        t.isScrollEnabled = false
        t.layer.cornerRadius = 3.0
        t.layer.borderWidth = 1.0
        t.layer.borderColor = UIColor(r: 243, g: 243, b: 243).cgColor
        t.textContainerInset = UIEdgeInsets(top: 8, left: 13, bottom: 8, right: 13)
        t.textContainer.maximumNumberOfLines = 3
        return t
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Add subview
        contentView.addSubview(textView)
        
        // Define layout
        defineLayout()
        
        textView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func defineLayout() {
        contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 70).isActive = true
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        textView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        textView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        textView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        textView.heightAnchor.constraint(greaterThanOrEqualToConstant: 70).isActive = true
    }
    
    override func draw(_ rect: CGRect) {
        // textView.setLeftPaddingPoints(12) - Only for textfields
        
        textView.layer.masksToBounds = false
        textView.layer.shadowRadius = 4.0
        textView.layer.shadowColor = UIColor(r: 224, g: 224, b: 224, a: 0.5).cgColor
        textView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        textView.layer.shadowOpacity = 1.0
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.alpha != 1.0 else { return }
        textView.text = nil
        textView.alpha = 1.0
        
        // Add active border color
        guard let uiProperties = item?.uiProperties else { return }
        textView.layer.borderColor = uiProperties.borderColorActive?.cgColor
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        // Check for StringValue
        if let text = textView.text {
            self.item?.setValue(value: text)
        }
        
        // Show placeholder if empty
        guard textView.text.isEmpty else { return }
        guard let uiProperties = item?.uiProperties else { return }
        textView.text = uiProperties.placeholderText
        textView.alpha = 0.999
        
        // Add inactive border color
        textView.layer.borderColor = uiProperties.borderColorInActive?.cgColor
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard text == "\n" else {
            
            // Limit text input to be 130 characters.
            var newText = textView.text!
            newText.removeAll { (character) -> Bool in
                return character == " " || character == "\n"
            }
            
            return (newText.count + text.count) <= 135
        }
        
        textView.resignFirstResponder()
        return false
    }
    
}


extension JMFormTextViewCell: JMFormItemDelegate {
    
    func setAsFirstResponder() {
        textView.becomeFirstResponder()
    }
    
}

extension JMFormTextViewCell: JMFormUpdatable {
    
    func update(withForm item: JMFormItem) {
        self.item = item
        self.item?.delegate = self
        
        // Show value
        if let value: String = self.item?.getValue(), !value.isEmpty {
            self.textView.text = value
            self.textView.alpha = 1.0
        }
        // Show placeholder
        else {
            guard let uiProperties = self.item?.uiProperties else { return }
            textView.text = uiProperties.placeholderText
            textView.alpha = 0.999
        }
        
    }
    
}

