//
//  JMCustomTableViewCell.swift
//  JMForms_Example
//
//  Created by Jakob Mikkelsen on 26/08/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import JMForms

class JMCustomTableViewCell: JMFormTableViewCell {

    private var titleLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.font = UIFont.systemFont(ofSize: 12)
        l.textColor = UIColor.blue
        l.numberOfLines = 0
        l.textAlignment = .center
        l.text = "This is a custom JMFormCell"
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = .yellow
        
        // Add subviews
        contentView.addSubview(titleLabel)
        
        // Define layout
        defineLayout()

    }
    
    private func defineLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 125).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    override func update(withForm item: JMFormItem) {
        super.update(withForm: item)
        debugPrint("Did set form item")
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
