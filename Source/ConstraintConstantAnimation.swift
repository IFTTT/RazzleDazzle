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
public class ConstraintConstantAnimation : Animation<CGFloat>, Animatable {
    private let superview : UIView
    private let constraint : NSLayoutConstraint
    
    public init(superview: UIView, constraint: NSLayoutConstraint) {
        self.superview = superview
        self.constraint = constraint
    }
    
    public func animate(time: CGFloat) {
        if !hasKeyframes() {return}
        constraint.constant = self[time]
        superview.layoutIfNeeded()
    }
}
