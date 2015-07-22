//
//  LabelTextColorAnimation.swift
//  RazzleDazzle
//
//  Created by Laura Skelton on 6/24/15.
//  Copyright (c) 2015 IFTTT. All rights reserved.
//

import UIKit

/**
Animates the `textColor` property of a `UILabel`.
*/
public class LabelTextColorAnimation: Animation<UIColor>, Animatable {
    private let label : UILabel
    
    public init(label : UILabel) {
        self.label = label
    }
    
    public func animate(time: CGFloat) {
        if !hasKeyframes() {return}
        label.textColor = self[time]
    }
}
