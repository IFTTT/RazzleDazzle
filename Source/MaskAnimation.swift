//
//  MaskAnimation.swift
//  wingu
//
//  Created by Jakub Mazur on 05/05/2017.
//  Copyright © 2017 Kettu Jakub Mazur. All rights reserved.
//

import UIKit

public enum MaskAttribute {
    case revealFromTop
    case revealFromLeft
    case revealFromBottom
    case revealFromRight
    case revealFromCenterToCircle
    case revealFromCenterToBounds
}

public class MaskAnimation: Animation<CGFloat>, Animatable {
    private var maskedView: UIView
    private var maskAttribute: MaskAttribute
    
    public init(view: UIView, effect: MaskAttribute) {
        self.maskedView = view
        self.maskAttribute = effect
    }
    
    public func animate(_ time: CGFloat) {
        if !hasKeyframes() {return}
        let visibilityPercent: CGFloat = self[time]
        var maskPath: UIBezierPath = UIBezierPath()
        var maskedRect: CGRect = self.maskedView.bounds
        switch self.maskAttribute {
        case .revealFromTop:
            maskedRect.size.height *= visibilityPercent
            maskPath = UIBezierPath(rect: maskedRect)
        case .revealFromLeft:
            maskedRect.size.width *= visibilityPercent
            maskPath = UIBezierPath(rect: maskedRect)
        case .revealFromBottom:
            maskedRect.size.height *= visibilityPercent
            maskedRect.origin.y = self.maskedView.bounds.maxY - maskedRect.height
            maskPath = UIBezierPath(rect: maskedRect)
        case .revealFromRight:
            maskedRect.size.width *= visibilityPercent
            maskedRect.origin.x = self.maskedView.bounds.maxX - maskedRect.width
            maskPath = UIBezierPath(rect: maskedRect)
        case .revealFromCenterToCircle:
            let center = CGPoint(x: self.maskedView.frame.size.width/2, y: self.maskedView.frame.size.height/2)
            let radius = min(center.x, center.y)
            maskPath = UIBezierPath(arcCenter: center, radius: radius*visibilityPercent, startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: true)
        case .revealFromCenterToBounds:
            let center = CGPoint(x: maskedRect.width/2, y: maskedRect.height/2)
            let radius = sqrt(pow(center.x, 2) + pow(center.y, 2))
            maskPath = UIBezierPath(arcCenter: center, radius: radius*visibilityPercent, startAngle: 0, endAngle: CGFloat(Double.pi*2), clockwise: true)
        }
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        self.maskedView.layer.mask = maskLayer
    }
}
