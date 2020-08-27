//
//  JMFormItemCellType.swift
//  JMForm
//
//  Created by Jakob Mikkelsen on 16/07/2020.
//  Copyright © 2020 Codement. All rights reserved.
//

import UIKit
import Foundation

/// UI Cell Type to be displayed
public enum JMFormCellType {
    case textfield(type: JMFormTextFieldCell.`Type`?)
    case textView
    case switcher(config: JMFormSwitchCell.Config)
    case image
    case datePicker(mode: UIDatePicker.Mode)
    case listSelection
    case actionSheet
    case slider(config: JMFormSliderCell.Config)
    case custom(identifier: String)
    
    /// Registering methods for all forms items cell types
    ///
    /// - Parameter tableView: TableView where apply cells registration
    public static func registerCells(for tableView: UITableView, withCustomCells cells: [JMFormTableViewCell.Type]? = nil) {
        tableView.register(JMFormTextFieldCell.self, forCellReuseIdentifier: "JMFormTextFieldCell")
        tableView.register(JMFormTextViewCell.self, forCellReuseIdentifier: "JMFormTextViewCell")
        tableView.register(JMFormSwitchCell.self, forCellReuseIdentifier: "JMFormSwitchCell")
        tableView.register(JMFormImageCell.self, forCellReuseIdentifier: "JMFormImageCell")
        tableView.register(JMFormDateCell.self, forCellReuseIdentifier: "JMFormDateCell")
        tableView.register(JMFormListSelectionCell.self, forCellReuseIdentifier: "JMFormListSelectionCell")
        tableView.register(JMFormActionSheetCell.self, forCellReuseIdentifier: "JMFormActionSheetCell")
        tableView.register(JMFormSliderCell.self, forCellReuseIdentifier: "JMFormSliderCell")
        
        // Register the custom cells.
        cells?.forEach { tableView.register($0, forCellReuseIdentifier: "\($0.self)") }
        
    }
    
    /// Correctly dequeue the UITableViewCell according to the current cell type
    ///
    /// - Parameters:
    ///   - tableView: TableView where cells previously registered
    ///   - indexPath: indexPath where dequeue
    /// - Returns: a non-nullable UITableViewCell dequeued
    public func dequeueCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        
        switch self {
        case .textfield:
            return tableView.dequeueReusableCell(withIdentifier: "JMFormTextFieldCell", for: indexPath)
        case .textView:
            return tableView.dequeueReusableCell(withIdentifier: "JMFormTextViewCell", for: indexPath)
        case .switcher:
            return tableView.dequeueReusableCell(withIdentifier: "JMFormSwitchCell", for: indexPath)
        case .image:
            return tableView.dequeueReusableCell(withIdentifier: "JMFormImageCell", for: indexPath)
        case .datePicker:
            return tableView.dequeueReusableCell(withIdentifier: "JMFormDateCell", for: indexPath)
        case .listSelection:
            return tableView.dequeueReusableCell(withIdentifier: "JMFormListSelectionCell", for: indexPath)
        case .actionSheet:
            return tableView.dequeueReusableCell(withIdentifier: "JMFormActionSheetCell", for: indexPath)
        case .slider:
            return tableView.dequeueReusableCell(withIdentifier: "JMFormSliderCell", for: indexPath)
        case .custom(let identifier):
            return tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
        
    }
}

