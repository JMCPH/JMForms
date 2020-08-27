//
//  JMFormImageCell.swift
//  JMForms
//
//  Created by Jakob Mikkelsen on 18/08/2020.
//

import UIKit

open class JMFormImageCell: JMFormTableViewCell {

    private var titleLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.font = UIFont.systemFont(ofSize: 12)
        l.textColor = UIColor(r: 54, g: 54, b: 54)
        l.numberOfLines = 0
        return l
    }()
    
    private let imageV: UIImageView = {
        let s = UIImageView(frame: .zero)
        s.layer.cornerRadius = 65 / 2
        s.clipsToBounds = true
        return s
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Add subviews
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageV)
        
        // Define layout
        defineLayout()
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapCell)))
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func defineLayout() {
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 31).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: imageV.leadingAnchor, constant: -10).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        imageV.translatesAutoresizingMaskIntoConstraints = false
        imageV.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        imageV.widthAnchor.constraint(equalToConstant: 65).isActive = true
        imageV.heightAnchor.constraint(equalToConstant: 65).isActive = true
        imageV.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25).isActive = true
        imageV.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        
    }
    
    @objc private func didTapCell() {
        delegate?.didTapCell(atIndexPath: indexPath)
    }
    
}

extension JMFormImageCell: JMFormUpdatable {
    
    public func update(withForm item: JMFormItem) {
        self.item = item
        titleLabel.text = item.titleText
        
        // Update the UI based on Appearence
        titleLabel.font = item.appearance.titleFont
        titleLabel.textColor = item.appearance.titleColor
        
        // Set the imageV view
        if let image = item.getAnyValue() as? UIImage {
            imageV.image = image
            imageV.backgroundColor = nil
        } else {
            imageV.backgroundColor = .lightGray
        }
        
    }
    
}
