//
//  Animatable.swift
//  RazzleDazzle
//
//  Created by Laura Skelton on 6/14/15.
//  Copyright (c) 2015 IFTTT. All rights reserved.
//

import UIKit

/**
Protocol for types that can animate a view for a given time.
*/
public protocol Animatable {
    /**
    Animate the view for a certain point in time.
    
    - parameter time:    The point in time for which to animate the view
    */
    func animate(time: CGFloat)
}
