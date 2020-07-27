//
//  JMFormSwitchCell.swift
//  JMForm
//
//  Created by Jakob Mikkelsen on 27/07/2020.
//  Copyright © 2020 Codement. All rights reserved.
//

import UIKit

class JMFormSwitchCell: JMFormTableViewCell {

    private let titleLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.font = UIFont.systemFont(ofSize: 15)
        l.textColor = UIColor(r: 54, g: 54, b: 54)
        l.numberOfLines = 0
        return l
    }()
    
    private let switcher: UISwitch = {
        let s = UISwitch(frame: .zero)
        s.layer.cornerRadius = 16
        s.tintColor = UIColor(r: 233, g: 233, b: 233)
        s.backgroundColor = UIColor(r: 233, g: 233, b: 233)
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func defineLayout() {
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: switcher.leadingAnchor, constant: -10).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
        
        switcher.translatesAutoresizingMaskIntoConstraints = false
        switcher.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        switcher.widthAnchor.constraint(equalToConstant: 50).isActive = true
        switcher.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        
    }
    
    @objc private func didSwitch() {
        item?.setValue(value: switcher.isOn)
    }
    
}

extension JMFormSwitchCell: JMFormUpdatable {
    
    func update(withForm item: JMFormItem) {
        self.item = item
        
        // Setup the text to be the value of the item
        let isOn: Bool = item.getValue()
        self.switcher.setOn(isOn, animated: false)
        
        // Setup the subclass cell
        self.setup()
        
    }
    
}
