//
//  JMFormItem.swift
//  JMForm
//
//  Created by Jakob Mikkelsen on 16/07/2020.
//  Copyright © 2020 Codement. All rights reserved.
//

import UIKit

/// Conform the view receiver to be updated with a form item
protocol JMFormUpdatable {
    func update(withForm item: JMFormItem)
}

public protocol JMFormItemDelegate {
    func setAsFirstResponder()
}

/// Different types of items supported by JMForm
public enum JMFormItemType {
    case firstName
    case lastName
    case email
    case password
    case newPassword
    case age
    case postalCode
    case phone
}

/// ViewModel to display and react to text events, to update data
public class JMFormItem {
    
    public var validator: JMFormValidator?
    
    /// The tag of the item - use it to get the value of this JMFormItem
    public var tag: String
    
    /// The type of cell this form item should use
    public let cellType: JMFormCellType?
    
    /// The value of the item - is calling valueCompletion() with the new value - important to be
    private var value: Any? {
        didSet {
            self.valueCompletion?(value)
        }
    }
    
    // Text of the item
    private(set) var titleText: String?
    private(set) var detailText: String?
    private(set) var placeholderText: String?
    
    var isExpanded: Bool = false
    
    /// This list of options when selecting
    private(set) var options: [Any]?
    
    /// The ValueCompletion block is executed everytime the 'value' variable is being set.
    var valueCompletion: ((_ value: Any?) -> Void)?
    
    /// The DidTapCell block is executed to tell if the UITableViewCell is being tapped, to e.g. expand the cell. This is used in the JMFormDatePickerCell.
    var didTapCell: ((Bool) -> Void)?
    
    /// ViewController is used to display a e.g. options UITableViewController with the 'options' values to be selected.
    weak var viewController: UIViewController?
    
    /// Delegate is used to set the item to becomeFirstResponder e.g. for a UITextField or UITextView.
    public var delegate: JMFormItemDelegate?
    
    /// Validation of the item
    private(set) var isRequired: Bool
    
    /// UI Appearance of the item
    public var appearance: JMFormItemAppearance
    
    // Initalization of the JMFormItem
    public init(tag: String, cellType: JMFormCellType, appearance: JMFormItemAppearance = JMFormItemAppearanceDefault(), titleText: String? = nil, detailText: String? = nil, placeholderText: String? = nil, value: Any? = nil, validator: JMFormValidator? = nil, isRequired: Bool = true) {
        self.tag = tag
        self.cellType = cellType
        self.appearance = appearance
        self.titleText = titleText
        self.detailText = detailText
        self.placeholderText = placeholderText
        self.value = value
        self.validator = validator
        self.isRequired = true
    }
    
    public func setOptions(options: [Any]?) {
        self.options = options
    }
    
    public func setValue(value: Any?) {
        self.value = value
    }
    
    public func getValue<T>() -> T? {
        return value as? T
    }
}

