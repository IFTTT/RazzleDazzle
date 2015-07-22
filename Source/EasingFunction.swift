//
//  EasingFunction.swift
//  RazzleDazzle
//
//  Created by Laura Skelton on 6/15/15.
//  Copyright (c) 2015 IFTTT. All rights reserved.
//

// Ported to Swift from Robert Böhnke's RBBAnimation, original available here:
// <https://github.com/robb/RBBAnimation/blob/a29cafe2fa91e62573cc9967990b0ad2a6b17a76/RBBAnimation/RBBEasingFunction.m>

import Foundation

public typealias EasingFunction = (CGFloat) -> (CGFloat)

public let EasingFunctionLinear: EasingFunction = { t in
    return t
}

public let EasingFunctionEaseInQuad: EasingFunction = { t in
    return t * t
}

public let EasingFunctionEaseOutQuad: EasingFunction = { t in
    return t * (2 - t)
}

public let EasingFunctionEaseInOutQuad: EasingFunction = { t in
    if (t < 0.5) { return 2 * t * t }
    return -1 + ((4 - (2 * t)) * t)
}

public let EasingFunctionEaseInCubic: EasingFunction = { t in
    return t * t * t
}

public let EasingFunctionEaseOutCubic: EasingFunction = { t in
    return pow(t - 1, 3) + 1
}

public let EasingFunctionEaseInOutCubic: EasingFunction = { t in
    if (t < 0.5) { return 4 * pow(t, 3) }
    return ((t - 1) * pow((2 * t) - 2, 2)) + 1
}

public let EasingFunctionEaseInBounce: EasingFunction = { t in
    return 1 - EasingFunctionEaseOutBounce(1 - t)
}

public let EasingFunctionEaseOutBounce: EasingFunction = { t in
    if (t < (4.0 / 11.0)) {
        return pow((11.0 / 4.0), 2) * pow(t, 2)
    }
    
    if (t < (8.0 / 11.0)) {
        return (3.0 / 4.0) + (pow((11.0 / 4.0), 2) * pow(t - (6.0 / 11.0), 2))
    }
    
    if (t < (10.0 / 11.0)) {
        return (15.0 / 16.0) + (pow((11.0 / 4.0), 2) * pow(t - (9.0 / 11.0), 2))
    }
    
    return (63.0 / 64.0) + (pow((11.0 / 4.0), 2) * pow(t - (21.0 / 22.0), 2))
}
