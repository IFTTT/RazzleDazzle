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
public class AlphaAnimation : Animation<CGFloat>, Animatable {
    private let view : UIView
    
    public init(view: UIView) {
        self.view = view
    }
    
    public func animate(time: CGFloat) {
        if !hasKeyframes() {return}
        view.alpha = self[time]
    }
    
    public override func validateValue(value: CGFloat) -> Bool {
        return (value >= 0) && (value <= 1)
    }
}
