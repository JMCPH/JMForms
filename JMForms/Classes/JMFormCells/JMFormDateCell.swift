//
//  JMFormDateCell.swift
//  JMForms
//
//  Created by Jakob Mikkelsen on 24/08/2020.
//

import UIKit

open class JMFormDateCell: JMFormTableViewCell, JMFormCellExpandable {
    
    private var titleLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.font = UIFont.systemFont(ofSize: 12)
        l.textColor = UIColor(r: 54, g: 54, b: 54)
        l.numberOfLines = 0
        return l
    }()
    
    private var datePickerContainer = UIView()
    private let datePicker = UIDatePicker(frame: .zero)
    private lazy var dateFormatter = DateFormatter()
    
    public var expanded = false
    public var unexpandedHeight: CGFloat = 50
    private var heightConstraint: NSLayoutConstraint!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        clipsToBounds = true
        contentView.clipsToBounds = true
        
        // Add subviews
        contentView.addSubview(titleLabel)
        contentView.addSubview(datePickerContainer)
        
        datePickerContainer.clipsToBounds = true
        datePickerContainer.addSubview(datePicker)
        
        // Define layout
        defineLayout()
        
        // Add target
        datePicker.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapCell)))
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func defineLayout() {
        
        heightConstraint = contentView.heightAnchor.constraint(equalToConstant: 50)
        heightConstraint.isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 31).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25).isActive = true
        
        if #available(iOS 14.0, *) {
            datePicker.translatesAutoresizingMaskIntoConstraints = false
            datePicker.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
            datePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25).isActive = true
            datePicker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        } else {
            datePickerContainer.translatesAutoresizingMaskIntoConstraints = false
            datePickerContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
            datePickerContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
            datePickerContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
            datePickerContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 1).isActive = true
            
            datePicker.translatesAutoresizingMaskIntoConstraints = false
            datePicker.leadingAnchor.constraint(equalTo: datePickerContainer.leadingAnchor).isActive = true
            datePicker.trailingAnchor.constraint(equalTo: datePickerContainer.trailingAnchor).isActive = true
            datePicker.topAnchor.constraint(equalTo: datePickerContainer.topAnchor).isActive = true
        }
        
    }
    
    @objc private func datePickerChanged(sender: UIDatePicker) {
        item?.setValue(value: sender.date)
        
        if #available(iOS 14.0, *) {
            datePicker.translatesAutoresizingMaskIntoConstraints = false
            datePicker.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
            datePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25).isActive = true
            datePicker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        } else {
            titleLabel.text = dateFormatter.string(from: sender.date)
        }
        
    }
    
    @objc private func didTapCell() {
        expanded = !expanded
        
        UIView.transition(with: titleLabel, duration: 0.25, options:UIView.AnimationOptions.transitionCrossDissolve, animations: { () -> Void in
            self.titleLabel.textColor = self.expanded ? self.tintColor : self.item?.appearance.titleColor ?? .lightGray
        }, completion: nil)
        
        // Update the tableView
        guard let tableView = superview as? UITableView else { return }
        heightConstraint.constant = getCellHeight()
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
    
    // Only for expandable cells
    public func getCellHeight() -> CGFloat {
        let expandedHeight = unexpandedHeight + CGFloat(datePicker.frame.size.height)
        return expanded ? expandedHeight : unexpandedHeight
    }
    
}

extension JMFormDateCell: JMFormUpdatable {
    
    public func update(withForm item: JMFormItem) {
        self.item = item
        titleLabel.text = item.titleText
        
        // Update the UI based on Appearence
        titleLabel.font = item.appearance.titleFont
        titleLabel.textColor = item.appearance.titleColor
        
        // Set the correct dateformatter and datepicker mode.
        switch item.cellType {
        case .datePicker(let mode):
            datePicker.datePickerMode = mode
            datePicker.timeZone = TimeZone(abbreviation: "UTC")
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            switch mode {
            case .date:
                dateFormatter.dateFormat = "yyyy-MM-dd"
            case .time:
                dateFormatter.dateFormat = "HH:mm"
            case .dateAndTime:
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            case .countDownTimer: break
            @unknown default: break
            }
        default: break
        }
        
        // Setup the date to be the value of the item
        if let date: Date = item.getValue() {
            titleLabel.text = dateFormatter.string(from: date)
            datePicker.setDate(date, animated: false)
        } else {
            datePicker.setDate(Date(), animated: false)
        }
        
    }
    
}
