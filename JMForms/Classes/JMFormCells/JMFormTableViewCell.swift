//
//  JMFormCell.swift
//  JMForm
//
//  Created by Jakob Mikkelsen on 26/07/2020.
//  Copyright © 2020 Codement. All rights reserved.
//

import UIKit

public protocol JMFormCellExpandable {
    var expanded: Bool {get}
    var unexpandedHeight: CGFloat {get}
    func getCellHeight() -> CGFloat
}

/// Conform receiver to have a form item property
protocol JMFormCell {
    var indexPath: IndexPath {get set}
    var delegate: JMFormCellDelegate? {get set}
    var item: JMFormItem? {get set}
}

protocol JMFormCellDelegate: class {
    func didFinishCell(atIndexPath indexPath: IndexPath)
    func didTapCell(atIndexPath indexPath: IndexPath)
}

open class JMFormTableViewCell: UITableViewCell, JMFormCell, JMFormUpdatable {
    
    public var indexPath: IndexPath = []
    weak var delegate: JMFormCellDelegate?
    public weak var item: JMFormItem?
    
    
    open func update(withForm item: JMFormItem) {
        self.item = item
        backgroundColor = item.appearance.contentBackgroundColor
    }
    
    deinit {
        item = nil
        delegate = nil
        gestureRecognizers?.removeAll()
    }

}
