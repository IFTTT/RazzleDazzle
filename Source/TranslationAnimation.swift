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
open class TranslationAnimation : Animation<CGPoint>, Animatable {
    fileprivate let view : UIView
    
    public init(view: UIView) {
        self.view = view
    }
    
    open func animate(_ time: CGFloat) {
        if !hasKeyframes() {return}
        let translation = self[time]
        let translationTransform = CGAffineTransform(translationX: translation.x, y: translation.y)
        view.translationTransform = translationTransform
        var newTransform = translationTransform
        if let scaleTransform = view.scaleTransform {
            newTransform = newTransform.concatenating(scaleTransform)
        }
        if let rotationTransform = view.rotationTransform {
            newTransform = newTransform.concatenating(rotationTransform)
        }
        view.transform = newTransform
    }
}
