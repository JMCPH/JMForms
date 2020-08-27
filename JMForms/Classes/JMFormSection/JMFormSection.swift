//
//  JMFormSection.swift
//  JMForm
//
//  Created by Jakob Mikkelsen on 16/07/2020.
//  Copyright © 2020 Codement. All rights reserved.
//

import UIKit

public class JMFormSection: Equatable {
    
    var items: [JMFormItem]
    let title: String?
    let titleColor: UIColor
    let titleFont: UIFont
    var isVisible: Bool
    var headerHeight: CGFloat
    var footerHeight: CGFloat
    
    public init(items: [JMFormItem], title: String?, titleColor: UIColor = .black, titleFont: UIFont = UIFont.boldSystemFont(ofSize: 12), isVisible: Bool, headerHeight: CGFloat = 15.0, footerHeight: CGFloat = 14.0) {
        self.items = items
        self.title = title
        self.titleColor = titleColor
        self.titleFont = titleFont
        self.isVisible = isVisible
        self.headerHeight = headerHeight
        self.footerHeight = footerHeight
    }
    
    public static func == (lhs: JMFormSection, rhs: JMFormSection) -> Bool {
        return lhs === rhs
    }
    
}
