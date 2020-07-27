//
//
//  JMFormSectionHeaderView.swift
//  JMForm
//
//  Created by Jakob Mikkelsen on 25/07/2020.
//  Copyright © 2020 Codement. All rights reserved.
//

import UIKit

class JMFormSectionHeaderView: UITableViewHeaderFooterView {

    public let titleLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.font = UIFont.systemFont(ofSize: 12)
        l.textColor = UIColor.black
        return l
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        // Setup UI
        contentView.backgroundColor = .clear
        
        // Add subviews
        contentView.addSubview(titleLabel)
        
        // Define layout
        defineLayout()
        
    }

    private func defineLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
