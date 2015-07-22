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
public class CornerRadiusAnimation : Animation<CGFloat>, Animatable {
    private let view : UIView
    
    public init(view: UIView) {
        self.view = view
    }
    
    public func animate(time: CGFloat) {
        if !hasKeyframes() {return}
        view.layer.cornerRadius = self[time]
    }
    
    public override func validateValue(value: CGFloat) -> Bool {
        return (value >= 0)
    }
}
