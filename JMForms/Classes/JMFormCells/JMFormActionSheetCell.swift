//
//  JMFormActionSheetCell.swift
//  JMForms
//
//  Created by Jakob Mikkelsen on 26/08/2020.
//

import UIKit

class JMFormActionSheetCell: JMFormTableViewCell {

    public let titleLabel: UILabel = {
        let l = UILabel(frame: .zero)
        return l
    }()

    private let recurrentImageView: UIImageView = {
        let i = UIImageView(image: UIImage(named: "repeatIcon"))
        i.isHidden = true
        return i
    }()
    
    public let valueLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.textAlignment = .right
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Add subviews
        contentView.addSubview(titleLabel)
        contentView.addSubview(recurrentImageView)
        contentView.addSubview(valueLabel)
        
        // Define layout
        defineLayout()
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapCell)))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func defineLayout() {
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: recurrentImageView.leadingAnchor, constant: -10).isActive = true
        
        recurrentImageView.translatesAutoresizingMaskIntoConstraints = false
        recurrentImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        recurrentImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        recurrentImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        recurrentImageView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10).isActive = true
        
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        valueLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        valueLabel.leadingAnchor.constraint(equalTo: recurrentImageView.trailingAnchor, constant: 20).isActive = true
        valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true

        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        valueLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
    }
    
    @objc private func didTapCell() {
        delegate?.didTapCell(atIndexPath: indexPath)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        valueLabel.text = nil
    }
    
    override func update(withForm item: JMFormItem) {
        super.update(withForm: item)
        titleLabel.text = item.titleText
        valueLabel.text = item.getValue()
        
        // Update the UI based on Appearence
        titleLabel.font = item.appearance.titleFont
        titleLabel.textColor = item.appearance.titleColor
        valueLabel.font = item.appearance.valueFont
        valueLabel.textColor = item.appearance.valueColor
        
    }

}
