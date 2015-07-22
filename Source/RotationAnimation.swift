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
public class RotationAnimation : Animation<CGFloat>, Animatable {
    private let view : UIView
    
    public init(view: UIView) {
        self.view = view
    }
    
    public func animate(time: CGFloat) {
        if !hasKeyframes() {return}
        let degrees = self[time]
        let radians = degrees * CGFloat(M_PI / -180.0)
        let rotationTransform = CGAffineTransformMakeRotation(radians)
        view.rotationTransform = rotationTransform
        var newTransform = rotationTransform
        if let scaleTransform = view.scaleTransform {
            newTransform = CGAffineTransformConcat(newTransform, scaleTransform)
        }
        if let translationTransform = view.translationTransform {
            newTransform = CGAffineTransformConcat(newTransform, translationTransform)
        }
        view.transform = newTransform
    }
}
