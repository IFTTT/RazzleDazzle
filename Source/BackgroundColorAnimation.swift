//
//  ColorAnimation.swift
//  RazzleDazzle
//
//  Created by Laura Skelton on 6/13/15.
//  Copyright (c) 2015 IFTTT. All rights reserved.
//

import UIKit

/**
Animates the `backgroundColor` property of a `UIView`.
*/
public class BackgroundColorAnimation : Animation<UIColor>, Animatable {
    private let view : UIView
    
    public init(view: UIView) {
        self.view = view
    }
    
    public func animate(time: CGFloat) {
        if !hasKeyframes() {return}
        view.backgroundColor = self[time]
    }
}
