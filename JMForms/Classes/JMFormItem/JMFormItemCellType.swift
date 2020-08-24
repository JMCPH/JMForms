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
    case textfield(type: JMFormItemTextFieldType?)
    case textView
    case switcher
    case image
    case datePicker(mode: UIDatePicker.Mode)
    case listSelection
    
    /// Registering methods for all forms items cell types
    ///
    /// - Parameter tableView: TableView where apply cells registration
    static func registerCells(for tableView: UITableView) {
        tableView.register(JMFormTextFieldCell.self, forCellReuseIdentifier: "JMFormTextFieldCell")
        tableView.register(JMFormTextViewCell.self, forCellReuseIdentifier: "JMFormTextViewCell")
        tableView.register(JMFormSwitchCell.self, forCellReuseIdentifier: "JMFormSwitchCell")
        tableView.register(JMFormImageCell.self, forCellReuseIdentifier: "JMFormImageCell")
        tableView.register(JMFormDateCell.self, forCellReuseIdentifier: "JMFormDateCell")
        tableView.register(JMFormListSelectionCell.self, forCellReuseIdentifier: "JMFormListSelectionCell")
    }
    
    /// Correctly dequeue the UITableViewCell according to the current cell type
    ///
    /// - Parameters:
    ///   - tableView: TableView where cells previously registered
    ///   - indexPath: indexPath where dequeue
    /// - Returns: a non-nullable UITableViewCell dequeued
    func dequeueCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        
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
            
        }
        
    }
}

