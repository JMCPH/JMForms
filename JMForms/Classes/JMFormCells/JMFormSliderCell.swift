//
//  JMFormSliderCell.swift
//  JMForms
//
//  Created by Jakob Mikkelsen on 26/08/2020.
//

import UIKit

open class JMFormSliderCell: JMFormTableViewCell {
    
    public struct Config {
        let minimumValue: Float
        let maximumValue: Float
        let minimumTrackTintColor: UIColor
        let maximumTrackTintColor: UIColor
        let valueTextSingle: String
        let valueTextMultiple: String
        public init(maximumValue: Float, minimumValue: Float, minimumTrackTintColor: UIColor, maximumTrackTintColor: UIColor, valueTextSingle: String, valueTextMultiple: String) {
            self.maximumValue = maximumValue
            self.minimumValue = minimumValue
            self.minimumTrackTintColor = minimumTrackTintColor
            self.maximumTrackTintColor = maximumTrackTintColor
            self.valueTextSingle = valueTextSingle
            self.valueTextMultiple = valueTextMultiple
        }
    }
    
    public let titleLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.textAlignment = .left
        return l
    }()
    
    public let valueLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.textAlignment = .right
        return l
    }()
    
    public let slider: UISlider = {
        let s = UISlider(frame: .zero)
        return s
    }()
    
    private var config: Config?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Add subviews
        contentView.addSubview(titleLabel)
        contentView.addSubview(valueLabel)
        contentView.addSubview(slider)
        
        // Define layout
        defineLayout()
        
        slider.addTarget(self, action: #selector(didUpdateValue), for: .valueChanged)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func defineLayout() {
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: valueLabel.leadingAnchor, constant: -10).isActive = true
        
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        valueLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        valueLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10).isActive = true
        valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25).isActive = true
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 1).isActive = true
        slider.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        slider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25).isActive = true
        slider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25).isActive = true
        
    }
    
    @objc private func didUpdateValue() {
        item?.setValue(value: slider.value)
        
        let roundedValue = Int(round(slider.value / 1) * 1)
        let valueString = "\(roundedValue == 1 ? config?.valueTextSingle ?? "" : config?.valueTextMultiple ?? "")"
        valueLabel.text = "\(roundedValue) \(valueString)"
    }
    
}

extension JMFormSliderCell: JMFormUpdatable {
  
    public func update(withForm item: JMFormItem) {
        
        self.item = item
        titleLabel.text = item.titleText
        
        // Update the UI based on Appearence
        titleLabel.font = item.appearance.titleFont
        titleLabel.textColor = item.appearance.titleColor
        valueLabel.font = item.appearance.valueFont
        valueLabel.textColor = item.appearance.valueColor
        
        if let value: Float = self.item?.getValue() {
            slider.setValue(value, animated: false)
        }
        
        switch item.cellType {
        case .slider(let config):
            self.config = config
            slider.minimumTrackTintColor =  config.minimumTrackTintColor
            slider.maximumTrackTintColor = config.maximumTrackTintColor
            slider.maximumValue = config.maximumValue
            slider.minimumValue = config.minimumValue
            let roundedValue = Int(round(slider.value / 1) * 1)
            valueLabel.text = "\(roundedValue) \(roundedValue == 1 ? config.valueTextSingle : config.valueTextMultiple)"
        default: break
        }
        
    }
}

//    func update(withForm item: JMFormItem) {
//        self.item = item
//        self.titleLabel.text = item.titleText
//
//        guard let value = self.item?.value as? Float else { return }
//        slider.setValue(value, animated: false)
//        let roundedValue = Int(round(slider.value / 1) * 1)
//        valueLabel.text = "\(roundedValue) \(roundedValue == 1 ? Localized("minute") : Localized("minutes"))"
//    }
//
//    func setExpanded(bool: Bool) {
//        UIView.animate(withDuration: bool ? 0.25 : 0.0, animations: { [weak self] in
//            self?.titleLabel.alpha = bool ? 1.0 : 0.0
//            self?.valueLabel.alpha = bool ? 1.0 : 0.0
//            self?.slider.alpha = bool ? 1.0 : 0.0
//        }, completion: nil)
//    }

