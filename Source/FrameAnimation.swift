//
//  FrameAnimation.swift
//  RazzleDazzle
//
//  Created by Kaan Dedeoglu on 3/3/16.
//  Copyright © 2016 IFTTT. All rights reserved.
//

import Foundation

/**
Animates the `frame` of a `UIView`.
*/
public class FrameAnimation : Animation<CGRect>, Animatable {
    private let view : UIView
    
    public init(view: UIView) {
        self.view = view
    }
    
    public func animate(time: CGFloat) {
        if !hasKeyframes() {return}
        view.frame = self[time]
    }
}