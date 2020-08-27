//
//  JMFormItemAppearance.swift
//  JMForms
//
//  Created by Jakob Mikkelsen on 30/07/2020.
//

import UIKit

public protocol JMFormItemAppearance {
    
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
    
    // Shadows
    var shadowRadius: CGFloat { get set }
    var shadowColor: CGColor { get set }
    var shadowOffset: CGSize { get set }
    
    // MARK: - Fonts
    
    var titleFont: UIFont { get set }
    var valueFont: UIFont { get set }
    var placeholderFont: UIFont { get set }
    
}


// MARK: Default appearence for JMFormItem

public struct JMFormItemAppearanceDefault: JMFormItemAppearance {
    
    public var backgroundColor: UIColor = .clear
    
    public var titleColor: UIColor = .black
    
    public var titleInvalidColor: UIColor = .red
    
    public var valueColor: UIColor = .black
    
    public var placeholderColor: UIColor = .lightGray
    
    public var borderColorInActive: UIColor? = UIColor(r: 237, g: 237, b: 237)
    
    public var borderColorActive: UIColor? = .blue
    
    public var shadowRadius: CGFloat = 4.0
    
    public var shadowColor: CGColor = UIColor(r: 224, g: 224, b: 224, a: 0.5).cgColor
    
    public var shadowOffset: CGSize = CGSize(width: 0.0, height: 2.0)
    
    public var titleFont: UIFont = UIFont.systemFont(ofSize: 15)
    
    public var valueFont: UIFont = UIFont.systemFont(ofSize: 15)
    
    public var placeholderFont: UIFont = UIFont.systemFont(ofSize: 15)
    
    public init() { }
}
