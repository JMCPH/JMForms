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
public enum JMFormItemCellType {
    case email
    case password
    case name
    case int
    
    /// Registering methods for all forms items cell types
    ///
    /// - Parameter tableView: TableView where apply cells registration
    static func registerCells(for tableView: UITableView) {
        tableView.register(JMFormItemEmailCell.self, forCellReuseIdentifier: "JMFormItemEmailCell")
        tableView.register(JMFormItemNameCell.self, forCellReuseIdentifier: "JMFormItemNameCell")
        tableView.register(JMFormItemIntCell.self, forCellReuseIdentifier: "JMFormItemIntCell")
        tableView.register(JMFormItemPasswordCell.self, forCellReuseIdentifier: "JMFormItemPasswordCell")
    }
    
    /// Correctly dequeue the UITableViewCell according to the current cell type
    ///
    /// - Parameters:
    ///   - tableView: TableView where cells previously registered
    ///   - indexPath: indexPath where dequeue
    /// - Returns: a non-nullable UITableViewCell dequeued
    func dequeueCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        
        switch self {
        case .email:
            return tableView.dequeueReusableCell(withIdentifier: "JMFormItemEmailCell", for: indexPath)
            
        case .name:
            return tableView.dequeueReusableCell(withIdentifier: "JMFormItemNameCell", for: indexPath)

        case .int:
            return tableView.dequeueReusableCell(withIdentifier: "JMFormItemIntCell", for: indexPath)
            
        case .password:
            return tableView.dequeueReusableCell(withIdentifier: "JMFormItemPasswordCell", for: indexPath)
        
        }
        
    }
}

