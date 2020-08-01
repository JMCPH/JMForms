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
        t.textColor = UIColor(r: 54, g: 54, b: 54)
        t.isScrollEnabled = false
        t.layer.cornerRadius = 3.0
        t.layer.borderWidth = 1.0
        t.textContainerInset = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        t.textContainer.maximumNumberOfLines = 3
        t.textContainer.lineFragmentPadding = 0
        t.font = UIFont.systemFont(ofSize: 15)
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
        textView.layer.masksToBounds = false
        textView.layer.shadowRadius = 4.0
        textView.layer.shadowColor = UIColor(r: 224, g: 224, b: 224, a: 0.5).cgColor
        textView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        textView.layer.shadowOpacity = 1.0
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor != .black else { return }
        textView.text = nil
        textView.textColor = .black
        
        // Add active border color
        textView.layer.borderColor = item?.appearance.borderColorActive?.cgColor
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        // Check for StringValue
        if let text = textView.text {
            self.item?.setValue(value: text)
        }
        
        // Add inactive border color
        textView.layer.borderColor = item?.appearance.borderColorInActive?.cgColor
        
        // Show placeholder text and color if empty
        guard textView.text.isEmpty else { return }
        textView.text = item?.placeholderText
        textView.textColor = .lightGray
        
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
        delegate?.didFinishCell(atIndexPath: indexPath)
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
        
        guard let appearance = self.item?.appearance else { return }
        
        // Show value
        if let value: String = self.item?.getValue(), !value.isEmpty {
            textView.text = value
            textView.textColor = .black
        }
        // Show placeholder
        else {
            textView.text = item.placeholderText
            textView.textColor = .lightGray
        }
        
        textView.layer.borderColor = textView.isFirstResponder ? appearance.borderColorActive?.cgColor : appearance.borderColorInActive?.cgColor
        
        
    }
    
}

