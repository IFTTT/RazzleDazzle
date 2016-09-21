//
//  LayerFillColorAnimation.swift
//  RazzleDazzle
//
//  Created by Laura Skelton on 6/24/15.
//  Copyright (c) 2015 IFTTT. All rights reserved.
//

import UIKit

/**
Animates the `fillColor` property of a `CAShapeLayer`.
*/
open class LayerFillColorAnimation : Animation<UIColor>, Animatable {
    fileprivate let layer : CAShapeLayer
    
    public init(layer: CAShapeLayer) {
        self.layer = layer
    }
    
    open func animate(_ time: CGFloat) {
        if !hasKeyframes() {return}
        layer.fillColor = self[time].cgColor
    }
}
