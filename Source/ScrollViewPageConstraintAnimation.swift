//
//  ScrollViewPageConstraintAnimation.swift
//  RazzleDazzle
//
//  Created by Laura Skelton on 6/16/15.
//  Copyright (c) 2015 IFTTT. All rights reserved.
//

import UIKit

public enum HorizontalPositionAttribute {
    case left
    case right
    case centerX
}

/**
Animates the `constant` of an `NSLayoutConstraint` to keep the view on a certain page given the `pageWidth` of the scroll view.
*/
open class ScrollViewPageConstraintAnimation : Animation<CGFloat>, Animatable {
    fileprivate let superview : UIView
    fileprivate let constraint : NSLayoutConstraint
    fileprivate let attribute : HorizontalPositionAttribute
    open var pageWidth : CGFloat
    
    public init(superview: UIView, constraint: NSLayoutConstraint, pageWidth: CGFloat, attribute: HorizontalPositionAttribute) {
        self.superview = superview
        self.constraint = constraint
        self.attribute = attribute
        self.pageWidth = pageWidth
    }
    
    open func animate(_ time: CGFloat) {
        if !hasKeyframes() {return}
        let page = self[time]
        
        var offset : CGFloat
        switch attribute {
        case .centerX:
            offset = 0.5
        case .left:
            offset = 0
        case .right:
            offset = 1
        }
        
        constraint.constant = (offset + page) * pageWidth
        superview.layoutIfNeeded()
    }
}
