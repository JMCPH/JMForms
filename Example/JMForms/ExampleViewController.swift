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
    
    public var shadowRadius: CGFloat = 4.0
    
    public var shadowColor: CGColor = UIColor(red: 224/255.0, green: 224/255.0, blue: 224/255.0, alpha: 0.5).cgColor
    
    public var shadowOffset: CGSize = CGSize(width: 0.0, height: 2.0)
    
    public var backgroundColor: UIColor = .clear
    
    public var titleColor: UIColor = .black
    
    public var titleInvalidColor: UIColor = .red
    
    public var valueColor: UIColor = .black
    
    public var placeholderColor: UIColor = .lightGray
    
    public var borderColorInActive: UIColor? = UIColor(red: 237/255.0, green: 237/255.0, blue: 237/255.0, alpha: 1.0)
    
    public var borderColorActive: UIColor? = .blue
    
    public var titleFont: UIFont = UIFont.systemFont(ofSize: 15)
    
    public var valueFont: UIFont = UIFont.systemFont(ofSize: 15)
    
    public var placeholderFont: UIFont = UIFont.systemFont(ofSize: 15)
    
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
        
        // Custom content inset
        tableView.contentInset.top = 50
        
    }
    
    private func setupForm() {
        
        // Register cells for tableview.
        JMFormCellType.registerCells(for: tableView, withCustomCells: [JMCustomTableViewCell.self])
        
        let firstName = JMFormItem(tag: "firstName", cellType: .textfield(type: .firstName), placeholderText: "Enter your first name", validator: .name(errorString: "Please type in a valid name."))
        let lastName = JMFormItem(tag: "lastName", cellType: .textfield(type: .lastName), placeholderText: "Enter your last name", validator: .name(errorString: "Please type in a valid name."))
        let image = JMFormItem(tag: "image", cellType: .image, titleText: "Select image", value: nil, validator: .image(errorString: "Please add an image"))
        let biography = JMFormItem(tag: "biography", cellType: .textView, placeholderText: "Enter your bio", validator: nil)
        let email = JMFormItem(tag: "email", cellType: .textfield(type: .email), placeholderText: "Enter your email", validator: .email(errorString: ""))
        let confirmEmail = JMFormItem(tag: "confirmEmail", cellType: .textfield(type: .email), placeholderText: "Confirm your email", validator: .equalEmail(item: email, errorString: "Emails does not match."))
        let password = JMFormItem(tag: "password", cellType: .textfield(type: .newPassword), placeholderText: "Enter your password", validator: .password(minimumCount: 6, errorString: "Please type in a valid password"))
        let age = JMFormItem(tag: "age", cellType: .textfield(type: .age), placeholderText: "Enter your age", validator: .age(errorString: "Please type in a valid age."))
        
        let switchConfig = JMFormSwitchCell.Config(tintColor: .lightGray, onTintColor: .blue, backgroundColor: .lightGray)
        let termsAndConditions = JMFormItem(tag: "terms", cellType: .switcher(config: switchConfig), titleText: "I accept the terms and conditions of using the JMForms example project.", validator: nil)
        
        let sliderConfig = JMFormSliderCell.Config(maximumValue: 10, minimumValue: 1, minimumTrackTintColor: .blue, maximumTrackTintColor: .lightGray, valueTextSingle: "Minut", valueTextMultiple: "Minutter")
        let slider = JMFormItem(tag: "slider", cellType: .slider(config: sliderConfig), titleText: "Indstil antal minutter før")
        
        let date = JMFormItem(tag: "date", cellType: .datePicker(mode: .date), titleText: "Select date", isRequired: false)
        let time = JMFormItem(tag: "time", cellType: .datePicker(mode: .time), titleText: "Select time", isRequired: false)
        let dateTime = JMFormItem(tag: "dateTime", cellType: .datePicker(mode: .dateAndTime), titleText: "Select date and time", isRequired: false)
        
        let testCustom = JMFormItem(tag: "custom", cellType: .custom(identifier: "\(JMCustomTableViewCell.self)"))
        let actionSheet = JMFormItem(tag: "actionSheet", cellType: .actionSheet, titleText: "Select your favorite animal")
        actionSheet.setOptions(options: ["🦆", "🐴", "🐒"])
        
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
            JMFormSection(items: [date], title: "Select a day", isCollapsed: false),
            JMFormSection(items: [time], title: "Select a time", isCollapsed: false),
            JMFormSection(items: [dateTime], title: "Select both date and time", isCollapsed: false),
            JMFormSection(items: [testCustom], title: "Test custom", isCollapsed: false),
            JMFormSection(items: [actionSheet], title: "Action sheet", isCollapsed: false),
            JMFormSection(items: [termsAndConditions, slider], title: nil, isCollapsed: true)
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
        
        let destination = ExampleViewController(style: .grouped)
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
