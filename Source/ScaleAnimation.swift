//
//  ScaleAnimation.swift
//  RazzleDazzle
//
//  Created by Laura Skelton on 6/13/15.
//  Copyright (c) 2015 IFTTT. All rights reserved.
//

import UIKit

/**
Animates the scale of the `transform` of a `UIView`.
*/
open class ScaleAnimation : Animation<CGFloat>, Animatable {
    fileprivate let view : UIView
    
    public init(view: UIView) {
        self.view = view
    }
    
    open func animate(_ time: CGFloat) {
        if !hasKeyframes() {return}
        let scale = self[time]
        let scaleTransform = CGAffineTransform(scaleX: scale, y: scale)
        view.scaleTransform = scaleTransform
        var newTransform = scaleTransform
        if let rotationTransform = view.rotationTransform {
            newTransform = newTransform.concatenating(rotationTransform)
        }
        if let translationTransform = view.translationTransform {
            newTransform = newTransform.concatenating(translationTransform)
        }
        view.transform = newTransform
    }
    
    open override func validateValue(_ value: CGFloat) -> Bool {
        return (value >= 0)
    }
}
