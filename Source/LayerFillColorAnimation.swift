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
public class LayerFillColorAnimation : Animation<UIColor>, Animatable {
    private let layer : CAShapeLayer
    
    public init(layer: CAShapeLayer) {
        self.layer = layer
    }
    
    public func animate(time: CGFloat) {
        if !hasKeyframes() {return}
        layer.fillColor = self[time].CGColor
    }
}
