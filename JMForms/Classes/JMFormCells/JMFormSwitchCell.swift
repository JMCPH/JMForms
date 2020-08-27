//
//  JMFormSwitchCell.swift
//  JMForm
//
//  Created by Jakob Mikkelsen on 27/07/2020.
//  Copyright © 2020 Codement. All rights reserved.
//

import UIKit

open class JMFormSwitchCell: JMFormTableViewCell {
    
    public struct Config {
        let tintColor: UIColor
        let onTintColor: UIColor
        let backgroundColor: UIColor
        public init(tintColor: UIColor, onTintColor: UIColor, backgroundColor: UIColor) {
            self.tintColor = tintColor
            self.onTintColor = onTintColor
            self.backgroundColor = backgroundColor
        }
    }

    private var titleLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.numberOfLines = 0
        return l
    }()
    
    private let switcher: UISwitch = {
        let s = UISwitch(frame: .zero)
        s.layer.cornerRadius = 16
        s.backgroundColor = .clear
        return s
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Add subviews
        contentView.addSubview(titleLabel)
        contentView.addSubview(switcher)
        
        // Define layout
        defineLayout()
        
        switcher.addTarget(self, action: #selector(didSwitch), for: .valueChanged)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func defineLayout() {
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 31).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: switcher.leadingAnchor, constant: -10).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        
        switcher.translatesAutoresizingMaskIntoConstraints = false
        switcher.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        switcher.widthAnchor.constraint(equalToConstant: 49).isActive = true
        switcher.heightAnchor.constraint(equalToConstant: 31).isActive = true
        switcher.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25).isActive = true
        
    }
    
    @objc private func didSwitch() {
        item?.setValue(value: switcher.isOn)
    }
    
}

extension JMFormSwitchCell: JMFormUpdatable {
    
    public func update(withForm item: JMFormItem) {
        self.item = item
        titleLabel.text = item.titleText
        
        // Update the UI based on Appearence
        titleLabel.font = item.appearance.titleFont
        titleLabel.textColor = item.appearance.titleColor
        
        // Setup the text to be the value of the item
        let isOn: Bool = item.getValue() ?? false
        switcher.setOn(isOn, animated: false)
        
        switch item.cellType {
        case .switcher(let config):
            switcher.tintColor = config.tintColor
            switcher.onTintColor = config.onTintColor
            switcher.backgroundColor = config.backgroundColor
        default: break
        }
        
    }
    
}
