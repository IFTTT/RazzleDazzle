//
//  LayerStrokeColorAnimation.swift
//  RazzleDazzle
//
//  Created by Laura Skelton on 6/24/15.
//  Copyright (c) 2015 IFTTT. All rights reserved.
//

import UIKit

/**
Animates the `strokeColor` property of a `CAShapeLayer`.
*/
open class LayerStrokeColorAnimation : Animation<UIColor>, Animatable {
    fileprivate let layer : CAShapeLayer
    
    public init(layer: CAShapeLayer) {
        self.layer = layer
    }
    
    open func animate(_ time: CGFloat) {
        if !hasKeyframes() {return}
        layer.strokeColor = self[time].cgColor
    }
}
