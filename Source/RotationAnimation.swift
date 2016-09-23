//
//  RotationAnimation.swift
//  RazzleDazzle
//
//  Created by Laura Skelton on 6/13/15.
//  Copyright (c) 2015 IFTTT. All rights reserved.
//

import UIKit

/**
Animates the rotation of the `transform` of a `UIView`.
*/
open class RotationAnimation : Animation<CGFloat>, Animatable {
    fileprivate let view : UIView
    
    public init(view: UIView) {
        self.view = view
    }
    
    open func animate(_ time: CGFloat) {
        if !hasKeyframes() {return}
        let degrees = self[time]
        let radians = degrees * CGFloat(M_PI / -180.0)
        let rotationTransform = CGAffineTransform(rotationAngle: radians)
        view.rotationTransform = rotationTransform
        var newTransform = rotationTransform
        if let scaleTransform = view.scaleTransform {
            newTransform = newTransform.concatenating(scaleTransform)
        }
        if let translationTransform = view.translationTransform {
            newTransform = newTransform.concatenating(translationTransform)
        }
        view.transform = newTransform
    }
}
