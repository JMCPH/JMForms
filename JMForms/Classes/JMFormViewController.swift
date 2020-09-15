//
//  JMFormViewController.swift
//  JMForm
//
//  Created by Jakob Mikkelsen on 16/07/2020.
//  Copyright © 2020 Codement. All rights reserved.
//

import UIKit

// MARK: Internal note:
// Use this to show/hide a section
//            guard let string = value as? String else { return }
//            profileNameSection.isVisible = string.count > 0
//            self?.reloadForm()

open class JMFormViewController: UITableViewController {
    
    public enum ValidationState {
        case valid
        case invalid(String)
    }
    
    private let form = JMForm()
    
    public var validation: ValidationState {
        let validation = form.validate()
        return validation.isValid ? .valid : .invalid(validation.errorString ?? "")
    }

    public var values: [String: Any]? {
        return form.value
    }
    
    // MARK: - Setup the JMFormViewController
    
    public func setupForm(_ sections: JMFormSection...) {//, withAppearence appearence: JMFormItemAppearance) {
        
        // JMForm - Register all the form cells for this tableview
        JMFormCellType.registerCells(for: tableView)
        
        // Setup keyboard observers
        setupKeyboardObservers()
        
        // Set the appearence to the items in the section
        // sections.forEach { $0.items.forEach { $0.appearance = appearence }}
        
        // Set the sections for this form.
        form.setup(withSections: sections)
        
        // Setup the UI of the tableView
        setupTableView()
        
        // Reload the tableview
        tableView.reloadData()
        
    }
    
    public func reloadData() {
        tableView.reloadData()
    }
    
    public func reloadForm() {
        
        for index in form.sections.indices {
            let section = form.sections[index]
            let newIndex = form.visibleSections.firstIndex(of: section)
            let oldIndex = form.previouslyVisibleSections.firstIndex(of: section)
            switch (newIndex, oldIndex) {
            case (nil, nil), (.some, .some): break
            case let (newIndex?, nil):
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) { [weak self] in
                    UIView.setAnimationsEnabled(false)
                    self?.tableView.beginUpdates()
                    self?.tableView.insertSections([newIndex], with: .automatic)
                    self?.tableView.endUpdates()
                    UIView.setAnimationsEnabled(true)
                }
            case let (nil, oldIndex?):
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) { [weak self] in
                    UIView.setAnimationsEnabled(false)
                    self?.tableView.beginUpdates()
                    self?.tableView.deleteSections([oldIndex], with: .automatic)
                    self?.tableView.endUpdates()
                    UIView.setAnimationsEnabled(true)
                }
            }

        }
        form.previouslyVisibleSections = form.visibleSections
        
    }
    
    private func setupTableView() {
        tableView.register(JMFormSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
    }
    
    private func setupKeyboardObservers() {

        // Setup the tap gesture to close keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        view.addGestureRecognizer(tapGesture)
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
    }

    @objc private func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc private func adjustForKeyboard(notification: NSNotification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            tableView.contentInset = .init(top: 65, left: 0, bottom: 15, right: 0)
        } else {
            tableView.contentInset = .init(top: 50, left: 0, bottom: (keyboardViewEndFrame.height / 2) - view.safeAreaInsets.bottom, right: 0)
        }

        tableView.scrollIndicatorInsets = tableView.contentInset

    }
    
    
    // MARK: - Table view data source

    public override func numberOfSections(in tableView: UITableView) -> Int {
        return form.visibleSections.count
    }

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return form.visibleSections[section].items.count
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get the _item_ in the section and set the indexpath, to be able to reload this specific item.
        let item = form.visibleSections[indexPath.section].items[indexPath.row]
        
        guard let cellType = item.cellType else { return UITableViewCell() }
        guard let cell = cellType.dequeueCell(for: tableView, at: indexPath) as? JMFormTableViewCell else { fatalError() }
        cell.indexPath = indexPath
        cell.delegate = self
        
        guard let formUpdatableCell = cell as? JMFormUpdatable else { return cell } // fatalError() }
        formUpdatableCell.update(withForm: item)
        
        return cell
    }

    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    public override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 15))
    }
    
    public override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? JMFormSectionHeaderView else { return nil }
        let sectionItem = form.visibleSections[section]
        header.titleLabel.text = sectionItem.title
        header.titleLabel.textColor = sectionItem.titleColor
        header.titleLabel.font = sectionItem.titleFont
        return header
    }
    
    public override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard form.visibleSections[section].title != nil else { return 0 }
        return form.visibleSections[section].headerHeight
    }
    
    public override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return form.visibleSections[section].footerHeight
    }
    
}

extension JMFormViewController: JMFormCellDelegate {
    
    func didFinishCell(atIndexPath indexPath: IndexPath) {
        let item = form.visibleSections[indexPath.section].items[indexPath.row]
        form.didFinishItem(withTag: item.tag)
    }
    
    func didTapCell(atIndexPath indexPath: IndexPath) {
        
        let formItem = form.visibleSections[indexPath.section].items[indexPath.row]
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        switch formItem.cellType {
        case .image:
            
            // Display the JMImagePicker and set the image as value
            let imagePicker = JMImagePicker(presentationController: self)
            imagePicker.present(from: cell)
            imagePicker.didSelectImage = { [weak self] (image) in
                formItem.setValue(value: image)
                self?.tableView.reloadData()
            }
            
        case .actionSheet:
            guard let options = formItem.options as? [String] else {
                debugPrint("[ERROR] - The options are not strings.")
                return
            }
            
            // Display the JMActionSheet and set the string as value
            let actionSheet = JMActionSheet(presentationController: self, title: formItem.titleText, message: formItem.placeholderText, options: options)
            actionSheet.present(from: cell)
            actionSheet.didSelectValue = { [weak self] (string) in
                formItem.setValue(value: string)
                self?.tableView.reloadData()
            }
            
        // TODO
        case .listSelection: break
            
            // Display the selection view controller
            
            
        default: break
        }
        
    }
    
}
