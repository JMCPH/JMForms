//
//  CALayer+Extensions.swift
//  tiimo
//
//  Created by Jakob Mikkelsen on 15/08/2019.
//  Copyright © 2019 Codement. All rights reserved.
//

extension CALayer {
    
    func addBorder(_ edge: UIRectEdge, color: UIColor, thickness: CGFloat, edgeInset: UIEdgeInsets = .zero) {
        
        sublayers?.removeAll(where: { $0.name == "custom_border_layer" })
        
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.name = "custom_border_layer"
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness)
        case UIRectEdge.bottom:
            border.frame = CGRect(x: edgeInset.left, y: self.frame.height - thickness, width: self.frame.width - edgeInset.right, height: thickness)
        case UIRectEdge.left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
        case UIRectEdge.right:
            border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)
        default:
            break
        }
        
        self.addSublayer(border)
    }
    
}
