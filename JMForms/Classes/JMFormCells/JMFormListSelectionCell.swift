//
//  JMFormListSelectionCell.swift
//  JMForms
//
//  Created by Jakob Mikkelsen on 19/08/2020.
//

import UIKit

open class JMFormListSelectionCell: JMFormTableViewCell {

    private var titleLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.numberOfLines = 0
        return l
    }()
    
    private var valueLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.numberOfLines = 0
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Add subviews
        contentView.addSubview(titleLabel)
        contentView.addSubview(valueLabel)
        
        // Define layout
        defineLayout()
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapCell)))
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func defineLayout() {
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 31).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: valueLabel.leadingAnchor, constant: -10).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        valueLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
        valueLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 31).isActive = true
        valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25).isActive = true
        
    }

    @objc private func didTapCell() {
        delegate?.didTapCell(atIndexPath: indexPath)
    }
    
}

extension JMFormListSelectionCell: JMFormUpdatable {
    
    public func update(withForm item: JMFormItem) {
        self.item = item
        titleLabel.text = item.titleText
        valueLabel.text = item.getValue()
        
        // Update the UI based on Appearence
        titleLabel.font = item.appearance.titleFont
        titleLabel.textColor = item.appearance.titleColor
        valueLabel.font = item.appearance.valueFont
        valueLabel.textColor = item.appearance.valueColor
        
    }
    
}
