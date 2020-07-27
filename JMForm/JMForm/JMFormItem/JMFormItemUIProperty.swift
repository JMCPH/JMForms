//
//  JMForm.swift
//  JMForm
//
//  Created by Jakob Mikkelsen on 16/07/2020.
//  Copyright © 2020 Codement. All rights reserved.
//

import UIKit

public struct JMFormItemUIProperties {
    
    // Texts
    var titleText: String?
    var descriptionText: String?
    var placeholderText: String?
    
    public var backgroundColor: UIColor? = nil
    
    // Title properties
    public var titleColor = UIColor.black
    public var titleInvalidColor = UIColor.red
    
    // Text properties
    public var textColor = UIColor.black
    
    // Placeholder properties
    public var placeholderColor = UIColor.lightGray
    
    // Border layer
    public var borderType: UIRectEdge? = nil
    public var borderColorInActive: UIColor? = UIColor(r: 237, g: 237, b: 237)
    public var borderColorActive: UIColor? = UIColor.blue
    public var borderWidth: CGFloat? = nil
    
}
