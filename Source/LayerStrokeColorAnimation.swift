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
public class LayerStrokeColorAnimation : Animation<UIColor>, Animatable {
    private let layer : CAShapeLayer
    
    public init(layer: CAShapeLayer) {
        self.layer = layer
    }
    
    public func animate(time: CGFloat) {
        if !hasKeyframes() {return}
        layer.strokeColor = self[time].CGColor
    }
}
