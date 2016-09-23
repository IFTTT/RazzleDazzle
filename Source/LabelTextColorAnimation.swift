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
open class LabelTextColorAnimation: Animation<UIColor>, Animatable {
    fileprivate let label : UILabel
    
    public init(label : UILabel) {
        self.label = label
    }
    
    open func animate(_ time: CGFloat) {
        if !hasKeyframes() {return}
        label.textColor = self[time]
    }
}
