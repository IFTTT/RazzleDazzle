//
//  ScrollViewPageConstraintAnimation.swift
//  RazzleDazzle
//
//  Created by Laura Skelton on 6/16/15.
//  Copyright (c) 2015 IFTTT. All rights reserved.
//

import UIKit

public enum HorizontalPositionAttribute {
    case Left
    case Right
    case CenterX
}

/**
Animates the `constant` of an `NSLayoutConstraint` to keep the view on a certain page given the `pageWidth` of the scroll view.
*/
public class ScrollViewPageConstraintAnimation : Animation<CGFloat>, Animatable {
    private let superview : UIView
    private let constraint : NSLayoutConstraint
    private let attribute : HorizontalPositionAttribute
    public var pageWidth : CGFloat
    
    public init(superview: UIView, constraint: NSLayoutConstraint, pageWidth: CGFloat, attribute: HorizontalPositionAttribute) {
        self.superview = superview
        self.constraint = constraint
        self.attribute = attribute
        self.pageWidth = pageWidth
    }
    
    public func animate(time: CGFloat) {
        if !hasKeyframes() {return}
        let page = self[time]
        
        var offset : CGFloat
        switch attribute {
        case .CenterX:
            offset = 0.5
        case .Left:
            offset = 0
        case .Right:
            offset = 1
        }
        
        constraint.constant = (offset + page) * pageWidth
        superview.layoutIfNeeded()
    }
}
