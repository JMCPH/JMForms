//
//  JMFormItemAppearence.swift
//  JMForms
//
//  Created by Jakob Mikkelsen on 30/07/2020.
//

import UIKit

public protocol JMFormItemAppearence {
    
    // MARK: - Colors
    
    // Background color of the view
    var backgroundColor: UIColor { get set }
    
    // Color of the titleLabel - valid and invalid
    var titleColor: UIColor { get set }
    var titleInvalidColor: UIColor { get set }
    
    // Color of the valueLabel
    var valueColor: UIColor { get set }
    
    // Color of the placeholder
    var placeholderColor: UIColor { get set }
    
    // Border colors - mainly used for UITextFields and UITextView
    var borderColorInActive: UIColor? { get set }
    var borderColorActive: UIColor? { get set }
    
    
    // MARK: - Fonts
    
    var titleFont: UIFont { get set }
    var valueFont: UIFont { get set }
    var placeholderFont: UIFont { get set }
    
}

struct JMFormItemAppearenceDefault: JMFormItemAppearence {
    
    var backgroundColor: UIColor = .clear
    
    var titleColor: UIColor = .black
    
    var titleInvalidColor: UIColor = .red
    
    var valueColor: UIColor = .black
    
    var placeholderColor: UIColor = .lightGray
    
    var borderColorInActive: UIColor? = UIColor(r: 237, g: 237, b: 237)
    
    var borderColorActive: UIColor? = .blue
    
    var titleFont: UIFont = UIFont.systemFont(ofSize: 15)
    
    var valueFont: UIFont = UIFont.systemFont(ofSize: 15)
    
    var placeholderFont: UIFont = UIFont.systemFont(ofSize: 15)
    
}
