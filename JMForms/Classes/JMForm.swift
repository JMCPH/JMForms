//
//  JMForm.swift
//  JMForm
//
//  Created by Jakob Mikkelsen on 16/07/2020.
//  Copyright © 2020 Codement. All rights reserved.
//

import UIKit

//
// The Form class contains all the ordered JMFormItem objects, in an array.
// In our example we want a form that displays 3 fields: username, mail and phone number of a user.
//

public struct JMFormValidation {
    let isValid: Bool
    let errorString: String?
}

class JMForm {
    
    private(set) var sections = [JMFormSection]()
    private(set) var previouslyVisibleSections = [JMFormSection]()
    public var visibleSections: [JMFormSection] {
        return sections.filter { $0.isVisible }
    }
    
    public func setup(withSections sections: [JMFormSection]) {
        self.sections = sections
        self.previouslyVisibleSections = visibleSections
    }
    
    public func reload() {
        
    }
    
    var value: [String: Any] {
        var valuesDictionary = [String: Any]()
        sections.forEach {
            $0.items.forEach {
                valuesDictionary[$0.tag] = $0.getValue()
            }
        }
        return valuesDictionary
    }
    
    // MARK: Form Validation
    @discardableResult
    func validate() -> JMFormValidation {
        
        let items = self.sections.flatMap { $0.items }
        let validations = items.compactMap { $0.validate() }
        
        guard let invalidItem = validations.first(where: { !$0.isValid }) else {
            return JMFormValidation(isValid: true, errorString: nil)
        }
        
        debugPrint("⚠️ JMFormItem is invalid: \(invalidItem.errorString ?? "") ⚠️")
        return invalidItem
        
    }

    func didFinishItem(withTag tag: String) {
        
        let items = self.sections.flatMap { $0.items }
        guard let indexOfFinishedItem = items.firstIndex(where: { $0.tag == tag }) else { return }
        guard let nextItem = items.suffix(from: Int(indexOfFinishedItem) + 1).first else { return }
        nextItem.delegate?.setAsFirstResponder()
        
    }
    
    func reloadSections() {
        UIView.setAnimationsEnabled(false)
        tableView.beginUpdates()
        for index in sections.indices {
            let section = sections[index]
            let newIndex = visibleSections.index(of: section)
            let oldIndex = previouslyVisibleSections.index(of: section)
            switch (newIndex, oldIndex) {
            case (nil, nil), (.some, .some): break
            case let (newIndex?, nil):
                tableView.insertSections([newIndex], with: .automatic)
            case let (nil, oldIndex?):
                tableView.deleteSections([oldIndex], with: .automatic)
            }
            if let i = newIndex {
                let footer = tableView.footerView(forSection: i)
                footer?.textLabel?.text = tableView(tableView, titleForFooterInSection: i)
                footer?.setNeedsLayout()
            }
            
        }
        tableView.endUpdates()
        UIView.setAnimationsEnabled(true)
        previouslyVisibleSections = visibleSections
    }
    

}
