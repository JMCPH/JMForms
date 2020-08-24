//
//  JMFormDateCell.swift
//  JMForms
//
//  Created by Jakob Mikkelsen on 24/08/2020.
//

import UIKit

class JMFormDateCell: JMFormTableViewCell, JMFormExpandable {
    
    private var titleLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.font = UIFont.systemFont(ofSize: 12)
        l.textColor = UIColor(r: 54, g: 54, b: 54)
        l.numberOfLines = 0
        return l
    }()
    
    private var datePickerContainer = UIView()
    private let datePicker = UIDatePicker(frame: .zero)
    private var dateFormatter: DateFormatter!
    
    var expanded = false
    var unexpandedHeight: CGFloat = 50
    private var heightConstraint: NSLayoutConstraint!
    
    deinit {
        gestureRecognizers?.removeAll()
    }
    
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
    
    required init?(coder: NSCoder) {
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
    func getCellHeight() -> CGFloat {
        let expandedHeight = unexpandedHeight + CGFloat(datePicker.frame.size.height)
        return expanded ? expandedHeight : unexpandedHeight
    }
    
}

extension JMFormDateCell: JMFormUpdatable {
    
    func update(withForm item: JMFormItem) {
        self.item = item
        self.titleLabel.text = item.titleText
        
        // Set the correct dateformatter and datepicker mode.
        switch item.cellType {
        case .datePicker(let mode):
            self.datePicker.datePickerMode = mode
            switch mode {
            case .date:
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                self.dateFormatter = dateFormatter
            case .time:
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                self.dateFormatter = dateFormatter
            case .dateAndTime:
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                self.dateFormatter = dateFormatter
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
