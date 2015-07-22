//
//  Animator.swift
//  RazzleDazzle
//
//  Created by Laura Skelton on 6/11/15.
//  Copyright (c) 2015 IFTTT. All rights reserved.
//

import Foundation

/**
Keeps an array of all of the animations being controlled, and calls the `animate:` function on each.
*/
public class Animator {
    public var animations = [Animatable]()
    
    public init() { }
    
    public func animate(time: CGFloat) {
        for animation in animations {
            animation.animate(time)
        }
    }
    
    public func addAnimation(animation: Animatable) {
        animations.append(animation)
    }
}
