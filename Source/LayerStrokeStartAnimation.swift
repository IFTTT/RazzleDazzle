//
//  LayerStrokeStartAnimation.swift
//  RazzleDazzle
//
//  Created by Laura Skelton on 6/24/15.
//  Copyright (c) 2015 IFTTT. All rights reserved.
//

import UIKit

/**
Animates the `strokeStart` property of a `CAShapeLayer`.
*/
open class LayerStrokeStartAnimation : Animation<CGFloat>, Animatable {
    fileprivate let layer : CAShapeLayer
    fileprivate let animationKey = "StrokeStart"
    
    public init(layer: CAShapeLayer) {
        self.layer = layer
        super.init()
        createStrokeStartAnimation()
        
        // CAAnimations are lost when application enters the background, so re-add them
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(LayerStrokeStartAnimation.createStrokeStartAnimation),
            name: NSNotification.Name.UIApplicationDidBecomeActive,
            object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    open func animate(_ time: CGFloat) {
        if !hasKeyframes() {return}
        layer.timeOffset = CFTimeInterval(self[time])
    }
    
    open override func validateValue(_ value: CGFloat) -> Bool {
        return (value >= 0) && (value <= 1)
    }
    
    @objc fileprivate func createStrokeStartAnimation() {
        // Set up a CABasicAnimation to change the stroke start
        layer.add(strokeStartAnimation(), forKey: animationKey)
        layer.speed = 0
        layer.timeOffset = 0
    }
    
    fileprivate func strokeStartAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "strokeStart")
        animation.duration = 1
        animation.fromValue = 0
        animation.toValue = 1
        animation.fillMode = kCAFillModeBoth
        animation.isRemovedOnCompletion = false
        return animation
    }
}
