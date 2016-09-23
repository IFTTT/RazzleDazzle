//
//  CornerRadiusAnimation.swift
//  RazzleDazzle
//
//  Created by Laura Skelton on 6/15/15.
//  Copyright (c) 2015 IFTTT. All rights reserved.
//

import UIKit

/**
Animates the `cornerRadius` property of a `UIView's` `layer`.
*/
open class CornerRadiusAnimation : Animation<CGFloat>, Animatable {
    fileprivate let view : UIView
    
    public init(view: UIView) {
        self.view = view
    }
    
    open func animate(_ time: CGFloat) {
        if !hasKeyframes() {return}
        view.layer.cornerRadius = self[time]
    }
    
    open override func validateValue(_ value: CGFloat) -> Bool {
        return (value >= 0)
    }
}
