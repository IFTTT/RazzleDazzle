//
//  CubicBezier.swift
//  RazzleDazzle
//
//  Created by Laura Skelton on 6/15/15.
//  Copyright (c) 2015 IFTTT. All rights reserved.
//

// Ported to Swift from Robert Böhnke's RBBAnimation, original available here:
// <https://github.com/robb/RBBAnimation/blob/a29cafe2fa91e62573cc9967990b0ad2a6b17a76/RBBAnimation/RBBCubicBezier.m>

import Foundation

public func CubicBezier(_ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat) -> EasingFunction {
    if (x1 == y1) && (x2 == y2) { return EasingFunctionLinear }
    return { x in
        let t = CubicBezierBinarySubdivide(x, x1: x1, x2: x2)
        return CubicBezierCalculate(t, a1: y1, a2: y2)
    }
}

private func A(_ a1: CGFloat, a2: CGFloat) -> CGFloat {
    return 1.0 - (3.0 * a2) + (3.0 * a1)
}

private func B(_ a1: CGFloat, a2: CGFloat) -> CGFloat {
    return (3.0 * a2) - (6.0 * a1)
}

private func C(_ a1: CGFloat) -> CGFloat {
    return (3.0 * a1)
}

private func CubicBezierCalculate(_ t: CGFloat, a1: CGFloat, a2: CGFloat) -> CGFloat {
    return ((((A(a1, a2: a2) * t) + B(a1, a2: a2)) * t) + C(a1)) * t
}

private func CubicBezierSlope(_ t: CGFloat, a1: CGFloat, a2: CGFloat) -> CGFloat {
    return (3.0 * A(a1, a2: a2) * t * t) + (2.0 * B(a1, a2: a2) * t) + C(a1)
}

private func CubicBezierBinarySubdivide(_ x: CGFloat, x1: CGFloat, x2: CGFloat) -> CGFloat {
    let epsilon : CGFloat = 0.0000001
    let maxIterations = 10
    
    var start : CGFloat = 0
    var end : CGFloat = 1
    
    var currentX : CGFloat
    var currentT : CGFloat
    
    var i = 0
    repeat {
        currentT = start + (end - start) / 2.0
        currentX = CubicBezierCalculate(currentT, a1: x1, a2: x2) - x
        
        if (currentX > 0) {
            end = currentT
        } else {
            start = currentT
        }
        i += 1
    } while (abs(currentX) > epsilon && i < maxIterations)
    
    return currentT
}
