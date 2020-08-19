//
//  JMFormViewController.swift
//  JMForm
//
//  Created by Jakob Mikkelsen on 16/07/2020.
//  Copyright © 2020 Codement. All rights reserved.
//

import UIKit

open class JMFormViewController: UITableViewController {
    
    public enum ValidationState {
        case valid
        case invalid(String)
    }
    
    private var form: JMForm? = JMForm()
    
    public var validation: ValidationState {
        guard let validation = form?.validate() else { return .invalid("") }
        return validation.isValid ? .valid : .invalid(validation.errorString ?? "")
    }

    public var values: [String: Any]? {
        return form?.value
    }
    
    deinit {
        form = nil
    }

    private var imagePicker: JMImagePicker?
    private var selectionPicker: JMListSelectionController?
    
    // MARK: - Setup the JMFormViewController
    
    public func setupForm(_ sections: JMFormSection...) {
        
        // JMForm - Register all the form cells for this tableview
        JMFormCellType.registerCells(for: tableView)
        
        // Setup keyboard observers
        setupKeyboardObservers()
        
        // Set the sections for this form.
        form?.setup(withSections: sections)
        
        // Setup the UI of the tableView
        setupTableView()
        
        // Reload the tableview
        tableView.reloadData()
        
        // Setup image picker
        imagePicker = JMImagePicker(presentationController: self)
        
    }
    
    public func didFinishItem(withTag tag: String) {
        form?.didFinishItem(withTag: tag)
    }
    
    private func setupTableView() {
        tableView.register(JMFormSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.contentInset.top = 50
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
        return form?.sections.count ?? 0
    }

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (form?.sections[section].isCollapsed ?? false) ? 0 : form?.sections[section].items.count ?? 0
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get the _item_ in the section and set the indexpath, to be able to reload this specific item.
        guard let item = form?.sections[indexPath.section].items[indexPath.row] else { return UITableViewCell() }
        
        guard let cellType = item.cellType else { return UITableViewCell() }
        guard let cell = cellType.dequeueCell(for: tableView, at: indexPath) as? JMFormTableViewCell else { fatalError() }
        cell.indexPath = indexPath
        cell.delegate = self
        
        guard let formUpdatableCell = cell as? JMFormUpdatable else { fatalError() }
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
        guard let headerTitle = form?.sections[section].title else { return UIView() }
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? JMFormSectionHeaderView else { return nil }
        header.titleLabel.text = headerTitle
        return header
    }
    
    public override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard form?.sections[section].title != nil else { return 1 }
        return 20
    }
    
    public override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
}

extension JMFormViewController: JMFormCellDelegate {
    
    func didFinishCell(atIndexPath indexPath: IndexPath) {
        guard let item = form?.sections[indexPath.section].items[indexPath.row] else { return }
        form?.didFinishItem(withTag: item.tag)
    }
    
    func didTapCell(atIndexPath indexPath: IndexPath) {
        
        guard let imageItem = form?.sections[indexPath.section].items[indexPath.row] else { return }
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        switch imageItem.cellType {
        case .image:
            
            // Display the JMImagePicker and set the image as value
            imagePicker?.present(from: cell)
            imagePicker?.didSelectImage = { [weak self] (image) in
                imageItem.setValue(value: image)
                self?.tableView.reloadData()
            }
            
        // TODO
        case .listSelection: break
            
            // Display the selection view controller
            
            
        default: break
        }
        
    }
    
}
