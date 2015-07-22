//
//  TranslationAnimation.swift
//  RazzleDazzle
//
//  Created by Laura Skelton on 6/14/15.
//  Copyright (c) 2015 IFTTT. All rights reserved.
//

import UIKit

/**
Animates the translation of the `transform` of a `UIView`.
*/
public class TranslationAnimation : Animation<CGPoint>, Animatable {
    private let view : UIView
    
    public init(view: UIView) {
        self.view = view
    }
    
    public func animate(time: CGFloat) {
        if !hasKeyframes() {return}
        let translation = self[time]
        let translationTransform = CGAffineTransformMakeTranslation(translation.x, translation.y)
        view.translationTransform = translationTransform
        var newTransform = translationTransform
        if let scaleTransform = view.scaleTransform {
            newTransform = CGAffineTransformConcat(newTransform, scaleTransform)
        }
        if let rotationTransform = view.rotationTransform {
            newTransform = CGAffineTransformConcat(newTransform, rotationTransform)
        }
        view.transform = newTransform
    }
}
