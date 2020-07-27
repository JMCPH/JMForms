//
//  JMFormCell.swift
//  JMForm
//
//  Created by Jakob Mikkelsen on 26/07/2020.
//  Copyright © 2020 Codement. All rights reserved.
//

import UIKit

/// Conform receiver to have a form item property
protocol JMFormCell {
    var indexPath: IndexPath {get set}
    var delegate: JMFormCellDelegate? {get set}
    var item: JMFormItem? {get set}
}

protocol JMFormCellDelegate {
    func didFinishCell(atIndexPath indexPath: IndexPath)
}

class JMFormTableViewCell: UITableViewCell, JMFormCell {
    var indexPath: IndexPath = []
    var delegate: JMFormCellDelegate?
    var item: JMFormItem?
    
//    func setup() {
//
//        selectionStyle = .none
//        contentView.backgroundColor = .clear
//        backgroundColor = .clear
//        backgroundView?.backgroundColor = .clear
//
//    }
}
