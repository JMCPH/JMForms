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
    
    // Border layer
//    public var borderType: UIRectEdge? = nil
//    public var borderWidth: CGFloat? = nil
    
    
    // MARK: - Fonts
    
    var titleFont: UIFont { get set }
    var valueFont: UIFont { get set }
    var placeholderFont: UIFont { get set }
    
}

public struct JMFormItemAppearanceDefault: JMFormItemAppearance {
    
    public var backgroundColor: UIColor = .clear
    
    public var titleColor: UIColor = .black
    
    public var titleInvalidColor: UIColor = .red
    
    public var valueColor: UIColor = .black
    
    public var placeholderColor: UIColor = .lightGray
    
    public var borderColorInActive: UIColor? = UIColor(r: 237, g: 237, b: 237)
    
    public var borderColorActive: UIColor? = .blue
    
    public var titleFont: UIFont = UIFont.systemFont(ofSize: 15)
    
    public var valueFont: UIFont = UIFont.systemFont(ofSize: 15)
    
    public var placeholderFont: UIFont = UIFont.systemFont(ofSize: 15)
    
    
    public init() { }
}
