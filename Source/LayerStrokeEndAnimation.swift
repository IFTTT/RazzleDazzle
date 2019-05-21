//
//  LayerStrokeEndAnimation.swift
//  RazzleDazzle
//
//  Created by Laura Skelton on 6/24/15.
//  Copyright (c) 2015 IFTTT. All rights reserved.
//

import UIKit

/**
Animates the `strokeEnd` property of a `CAShapeLayer`.
*/
public class LayerStrokeEndAnimation : Animation<CGFloat>, Animatable {
    private let layer : CAShapeLayer
    private let animationKey = "StrokeEnd"
    
    public init(layer: CAShapeLayer) {
        self.layer = layer
        self.layer.speed = 0
        super.init()
        createStrokeEndAnimation()
        
        // CAAnimations are lost when application enters the background, so re-add them
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(LayerStrokeEndAnimation.createStrokeEndAnimation),
            name: UIApplication.didBecomeActiveNotification,
            object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    public func animate(_ time: CGFloat) {
        if !hasKeyframes() {return}
        layer.timeOffset = CFTimeInterval(self[time])
    }
    
    public override func validateValue(_ value: CGFloat) -> Bool {
        return (value >= 0) && (value <= 1)
    }
    
    @objc private func createStrokeEndAnimation() {
        // Set up a CABasicAnimation to change the stroke end
        layer.add(strokeEndAnimation(), forKey: animationKey)
        layer.speed = 0
        layer.timeOffset = 0
    }
    
    private func strokeEndAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 1
        animation.fromValue = 0
        animation.toValue = 1
        animation.fillMode = CAMediaTimingFillMode.both
        animation.isRemovedOnCompletion = false
        return animation
    }
}
