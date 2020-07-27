//
//  ViewController.swift
//  JMForms
//
//  Created by Jakob Mikkelsen on 25/07/2020.
//  Copyright © 2020 Codement Aps. All rights reserved.
//

import UIKit
import JMForm

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

        // First name
        let firstNameForm = JMFormItem(tag: "name", cellType: .name, placeholderText: "Enter your name", validator: .name)

        // Email
        let emailFormItem = JMFormItem(tag: "email", cellType: .email, placeholderText: "Enter your email", validator: .email)

        // Password
        let passwordFormItem = JMFormItem(tag: "password", cellType: .password, placeholderText: "Enter your password", validator: .password(minimumCount: 6))
        
        // Age
        let ageFormItem = JMFormItem(tag: "age", cellType: .int, placeholderText: "Enter your age", validator: .age)

        // Setup the sections for the form
        let sections = [JMFormSection(items: [firstNameForm, emailFormItem, passwordFormItem, ageFormItem], title: "User information", isCollapsed: false)]
        
        setupForm(withSections: sections)
        
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

