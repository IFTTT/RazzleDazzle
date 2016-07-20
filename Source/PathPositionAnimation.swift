//
//  PathPositionAnimation.swift
//  RazzleDazzle
//
//  Created by Laura Skelton on 6/30/15.
//  Copyright © 2015 IFTTT. All rights reserved.
//

import UIKit

/**
Animates the view's position along the given path.
*/
public class PathPositionAnimation : Animation<CGFloat>, Animatable {
    private let view : UIView
    public var path : CGPath? {
        didSet {
            createKeyframeAnimation()
        }
    }
    private let animationKey = "PathPosition"
    public var rotationMode : String? = kCAAnimationRotateAuto {
        didSet {
            createKeyframeAnimation()
        }
    }
    
    public init(view: UIView, path: CGPath?) {
        self.view = view
        self.path = path
        super.init()
        createKeyframeAnimation()
        
        // CAAnimations are lost when application enters the background, so re-add them
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(PathPositionAnimation.createKeyframeAnimation),
            name: NSNotification.Name.UIApplicationDidBecomeActive,
            object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    public func animate(_ time: CGFloat) {
        if !hasKeyframes() {return}
        view.layer.timeOffset = CFTimeInterval(self[time])
    }
    
    public override func validateValue(_ value: CGFloat) -> Bool {
        return (value >= 0) && (value <= 1)
    }
    
    @objc private func createKeyframeAnimation() {
        // Set up a CAKeyframeAnimation to move the view along the path
        view.layer.add(pathAnimation(), forKey: animationKey)
        view.layer.speed = 0
        view.layer.timeOffset = 0
    }
    
    private func pathAnimation() -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position"
        animation.path = path
        animation.duration = 1
        animation.isAdditive = true
        animation.repeatCount = Float.infinity
        animation.calculationMode = kCAAnimationPaced
        animation.rotationMode = rotationMode
        animation.fillMode = kCAFillModeBoth
        animation.isRemovedOnCompletion = false
        return animation
    }
}
