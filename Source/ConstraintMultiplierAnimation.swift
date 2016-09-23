//
//  ConstraintMultiplierAnimation.swift
//  RazzleDazzle
//
//  Created by Laura Skelton on 6/15/15.
//  Copyright (c) 2015 IFTTT. All rights reserved.
//

import UIKit

public enum LayoutAttribute {
    case originX
    case originY
    case centerX
    case centerY
    case width
    case height
}

/**
Animates the `constant` of an `NSLayoutConstraint` to a multiple of an attribute of another view, and lays out the given `superview`.
*/
open class ConstraintMultiplierAnimation : Animation<CGFloat>, Animatable {
    fileprivate let superview : UIView
    fileprivate let constraint : NSLayoutConstraint
    fileprivate let referenceView : UIView
    fileprivate let attribute : LayoutAttribute
    fileprivate let constant : CGFloat
    
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
    
    open func animate(_ time: CGFloat) {
        if !hasKeyframes() {return}
        let multiplier = self[time]
        var referenceAttributeValue : CGFloat
        switch attribute {
        case .originX:
            referenceAttributeValue = referenceView.frame.minX
        case .originY:
            referenceAttributeValue = referenceView.frame.minY
        case .centerX:
            referenceAttributeValue = referenceView.frame.minX + (referenceView.frame.width / 2.0)
        case .centerY:
            referenceAttributeValue = referenceView.frame.minY + (referenceView.frame.height / 2.0)
        case .width:
            referenceAttributeValue = referenceView.frame.width
        case .height:
            referenceAttributeValue = referenceView.frame.height
        }
        constraint.constant = (multiplier * referenceAttributeValue) + constant
        superview.layoutIfNeeded()
    }
}
