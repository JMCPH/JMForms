//
//  JMFormSection.swift
//  JMForm
//
//  Created by Jakob Mikkelsen on 16/07/2020.
//  Copyright © 2020 Codement. All rights reserved.
//

import UIKit

public struct JMFormSection {
    var items: [JMFormItem]
    let title: String?
    var isCollapsed: Bool
    
    public init(items: [JMFormItem], title: String?, isCollapsed: Bool) {
        self.items = items
        self.title = title
        self.isCollapsed = isCollapsed
    }
}
