//
//  AlphaAnimation.swift
//  RazzleDazzle
//
//  Created by Laura Skelton on 6/13/15.
//  Copyright (c) 2015 IFTTT. All rights reserved.
//

import UIKit

/**
Animates the `alpha` property of a `UIView`.
*/
open class AlphaAnimation : Animation<CGFloat>, Animatable {
    fileprivate let view : UIView
    
    public init(view: UIView) {
        self.view = view
    }
    
    open func animate(_ time: CGFloat) {
        if !hasKeyframes() {return}
        view.alpha = self[time]
    }
    
    open override func validateValue(_ value: CGFloat) -> Bool {
        return (value >= 0) && (value <= 1)
    }
}
