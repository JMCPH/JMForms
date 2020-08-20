//
//  ExampleViewController.swift
//  JMForms
//
//  Created by Jakob Mikkelsen on 07/28/2020.
//  Copyright (c) 2020 Jakob Mikkelsen. All rights reserved.
//

import UIKit
import JMForms

public struct JMFormItemAppearanceTiimo: JMFormItemAppearance {
    
    public var backgroundColor: UIColor = .clear
    
    public var titleColor: UIColor = .black
    
    public var titleInvalidColor: UIColor = .red
    
    public var valueColor: UIColor = .black
    
    public var placeholderColor: UIColor = .lightGray
    
    public var borderColorInActive: UIColor? = UIColor.lightGray
    
    public var borderColorActive: UIColor? = .blue
    
    public var titleFont: UIFont = UIFont.systemFont(ofSize: 15)
    
    public var valueFont: UIFont = UIFont.systemFont(ofSize: 15)
    
    public var placeholderFont: UIFont = UIFont.systemFont(ofSize: 15)
    
    public init() { }
}


class ExampleViewController: JMFormViewController {
    
    private let submitButton: UIButton = {
        let b = UIButton(frame: .zero)
        b.setTitleColor(.white, for: .normal)
        b.backgroundColor = UIColor.blue
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        b.layer.cornerRadius = 25
        b.setTitle("Submit", for: .normal)
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the JMForm.
        setupForm()
        
        // Setup tableview footer view.
        setupFooterView()
        
    }
    
    private func setupForm() {
        
        let firstName = JMFormItem(tag: "firstName", cellType: .textfield(type: .firstName), placeholderText: "Enter your first name", validator: .name)
        let lastName = JMFormItem(tag: "lastName", cellType: .textfield(type: .lastName), placeholderText: "Enter your last name", validator: .name)
        let image = JMFormItem(tag: "image", cellType: .image, titleText: "Select image", value: nil, validator: .image)
        let biography = JMFormItem(tag: "biography", cellType: .textView, placeholderText: "Enter your bio", validator: nil)
        let email = JMFormItem(tag: "email", cellType: .textfield(type: .email), placeholderText: "Enter your email", validator: .email)
        let confirmEmail = JMFormItem(tag: "confirmEmail", cellType: .textfield(type: .email), placeholderText: "Confirm your email", validator: .equalEmail(item: email))
        let password = JMFormItem(tag: "password", cellType: .textfield(type: .newPassword), placeholderText: "Enter your password", validator: .password(minimumCount: 6))
        let age = JMFormItem(tag: "age", cellType: .textfield(type: .age), placeholderText: "Enter your age", validator: .age)
        let termsAndConditions = JMFormItem(tag: "terms", cellType: .switcher, titleText: "I accept the terms and conditions of using the JMForms example project.", validator: nil)
        
        // Setup the sections for the form
        self.setupForm(
            JMFormSection(items: [firstName], title: "First name", isCollapsed: false),
            JMFormSection(items: [lastName], title: "Last name", isCollapsed: false),
            JMFormSection(items: [image], title: "Image", isCollapsed: false),
            JMFormSection(items: [biography], title: "Biography", isCollapsed: false),
            JMFormSection(items: [age], title: "Age", isCollapsed: false),
            JMFormSection(items: [email], title: "Email", isCollapsed: false),
            JMFormSection(items: [confirmEmail], title: "Confirm email", isCollapsed: false),
            JMFormSection(items: [password], title: "Password", isCollapsed: false),
            JMFormSection(items: [termsAndConditions], title: nil, isCollapsed: false)
        )
        
    }
    
    private func setupFooterView() {
        
        // Add subview
        let footerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 100))
        footerView.backgroundColor = .clear
        footerView.addSubview(submitButton)
        tableView.tableFooterView = footerView
        
        // Define layout
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        submitButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
        submitButton.centerXAnchor.constraint(equalTo: footerView.centerXAnchor).isActive = true
        submitButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        
        // Add target
        submitButton.addTarget(self, action: #selector(submitForm), for: .touchUpInside)
        
    }
    
    @objc private func submitForm() {
        
        let destination = ExampleViewController()
        self.navigationController?.pushViewController(destination, animated: true)
        
        view.endEditing(true)

        switch validation {
        case .invalid(let errorString):
            presentSimpleAlert(withTitle: "Error", message: errorString)
        default:
            presentSimpleAlert(withTitle: "Succes", message: "Form was succesfully submitted!\n\n\(values.debugDescription)")
        }

    }
    
    private func presentSimpleAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
