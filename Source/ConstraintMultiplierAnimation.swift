//
//  ConstraintMultiplierAnimation.swift
//  RazzleDazzle
//
//  Created by Laura Skelton on 6/15/15.
//  Copyright (c) 2015 IFTTT. All rights reserved.
//

import UIKit

public enum LayoutAttribute {
    case OriginX
    case OriginY
    case CenterX
    case CenterY
    case Width
    case Height
}

/**
Animates the `constant` of an `NSLayoutConstraint` to a multiple of an attribute of another view, and lays out the given `superview`.
*/
public class ConstraintMultiplierAnimation : Animation<CGFloat>, Animatable {
    private let superview : UIView
    private let constraint : NSLayoutConstraint
    private let referenceView : UIView
    private let attribute : LayoutAttribute
    private let constant : CGFloat
    
    public convenience init(superview: UIView, constraint: NSLayoutConstraint, attribute: LayoutAttribute, referenceView: UIView) {
        self.init(superview: superview, constraint: constraint, attribute: attribute, referenceView: referenceView, constant: 0)
    }
    
    public init(superview: UIView, constraint: NSLayoutConstraint, attribute: LayoutAttribute, referenceView: UIView, constant: CGFloat) {
        self.superview = superview
        self.constraint = constraint
        self.referenceView = referenceView
        self.attribute = attribute
        self.constant = constant
    }
    
    public func animate(time: CGFloat) {
        if !hasKeyframes() {return}
        let multiplier = self[time]
        var referenceAttributeValue : CGFloat
        switch attribute {
        case .OriginX:
            referenceAttributeValue = CGRectGetMinX(referenceView.frame)
        case .OriginY:
            referenceAttributeValue = CGRectGetMinY(referenceView.frame)
        case .CenterX:
            referenceAttributeValue = CGRectGetMinX(referenceView.frame) + (CGRectGetWidth(referenceView.frame) / 2.0)
        case .CenterY:
            referenceAttributeValue = CGRectGetMinY(referenceView.frame) + (CGRectGetHeight(referenceView.frame) / 2.0)
        case .Width:
            referenceAttributeValue = CGRectGetWidth(referenceView.frame)
        case .Height:
            referenceAttributeValue = CGRectGetHeight(referenceView.frame)
        }
        constraint.constant = (multiplier * referenceAttributeValue) + constant
        superview.layoutIfNeeded()
    }
}
