//
//  ConstraintAnimation.swift
//  RazzleDazzle
//
//  Created by Laura Skelton on 6/15/15.
//  Copyright (c) 2015 IFTTT. All rights reserved.
//

import UIKit

/**
Animates the `constant` of an `NSLayoutConstraint` and lays out the given `superview`.
*/
open class ConstraintConstantAnimation : Animation<CGFloat>, Animatable {
    fileprivate let superview : UIView
    fileprivate let constraint : NSLayoutConstraint
    
    public init(superview: UIView, constraint: NSLayoutConstraint) {
        self.superview = superview
        self.constraint = constraint
    }
    
    open func animate(_ time: CGFloat) {
        if !hasKeyframes() {return}
        constraint.constant = self[time]
        superview.layoutIfNeeded()
    }
}
