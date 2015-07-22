//
//  Interpolatable.swift
//  RazzleDazzle
//
//  Created by Laura Skelton on 6/14/15.
//  Copyright (c) 2015 IFTTT. All rights reserved.
//

import UIKit

/**
Protocol for types that can return smoothly incremented values between two given values.
*/
public protocol Interpolatable {
    typealias ValueType
    /**
    Find a value at a certain progress point (from 0 to 1) between two values of the same type.
    
    - parameter toValue:   The ending value
    - parameter progress:  The progress (from 0 to 1) from the starting value to the end value for this value
    
    - returns: The value at the given progress point between the given starting and ending values
    */
    static func interpolateFrom(fromValue: ValueType, to toValue: ValueType, withProgress progress: CGFloat) -> ValueType
}

extension CGFloat : Interpolatable {
    /**
    Find a CGFloat at a certain progress point (from 0 to 1) between two other CGFloats.
    
    - parameter fromValue: The starting CGFloat
    - parameter toValue:   The ending CGFloat
    - parameter progress:  The progress (from 0 to 1) from the starting CGFloat to the end CGFloat for this CGFloat
    
    - returns: The CGFloat at the given progress point between the given starting and ending CGFloats
    */
    public static func interpolateFrom(fromValue: CGFloat, to toValue: CGFloat, withProgress progress: CGFloat) -> CGFloat {
        assert((0 <= progress) && (progress <= 1), "Progress must be between 0 and 1")
        let totalChange = toValue - fromValue
        let currentChange = totalChange * progress
        return fromValue + currentChange
    }
}

extension CGPoint : Interpolatable {
    /**
    Find a CGPoint at a certain progress point (from 0 to 1) between two other CGPoints.
    
    - parameter fromValue: The starting CGPoint
    - parameter toValue:   The ending CGPoint
    - parameter progress:  The progress (from 0 to 1) from the starting CGPoint to the end CGPoint for this CGPoint
    
    - returns: The CGPoint at the given progress point between the given starting and ending CGPoints
    */
    public static func interpolateFrom(fromValue: CGPoint, to toValue: CGPoint, withProgress progress: CGFloat) -> CGPoint {
        assert((0 <= progress) && (progress <= 1), "Progress must be between 0 and 1")
        let interpolatedX = CGFloat.interpolateFrom(fromValue.x, to: toValue.x, withProgress: progress)
        let interpolatedY = CGFloat.interpolateFrom(fromValue.y, to: toValue.y, withProgress: progress)
        return CGPointMake(interpolatedX, interpolatedY)
    }
}

extension CGSize : Interpolatable {
    /**
    Find a CGSize at a certain progress point (from 0 to 1) between two other CGSizes.
    
    - parameter fromValue: The starting CGSize
    - parameter toValue:   The ending CGSize
    - parameter progress:  The progress (from 0 to 1) from the starting CGSize to the end CGSize for this CGSize
    
    - returns: The CGSize at the given progress point between the given starting and ending CGSizes
    */
    public static func interpolateFrom(fromValue: CGSize, to toValue: CGSize, withProgress progress: CGFloat) -> CGSize {
        assert((0 <= progress) && (progress <= 1), "Progress must be between 0 and 1")
        let interpolatedWidth = CGFloat.interpolateFrom(fromValue.width, to: toValue.width, withProgress: progress)
        let interpolatedHeight = CGFloat.interpolateFrom(fromValue.height, to: toValue.height, withProgress: progress)
        return CGSizeMake(interpolatedWidth, interpolatedHeight)
    }
}

extension CGRect : Interpolatable {
    /**
    Find a CGRect at a certain progress point (from 0 to 1) between two other CGRects.
    
    - parameter fromValue: The starting CGRect
    - parameter toValue:   The ending CGRect
    - parameter progress:  The progress (from 0 to 1) from the starting CGRect to the end CGRect for this CGRect
    
    - returns: The CGRect at the given progress point between the given starting and ending CGRects
    */
    public static func interpolateFrom(fromValue: CGRect, to toValue: CGRect, withProgress progress: CGFloat) -> CGRect {
        assert((0 <= progress) && (progress <= 1), "Progress must be between 0 and 1")
        let interpolatedOrigin = CGPoint.interpolateFrom(fromValue.origin, to: toValue.origin, withProgress: progress)
        let interpolatedSize = CGSize.interpolateFrom(fromValue.size, to: toValue.size, withProgress: progress)
        return CGRectMake(interpolatedOrigin.x, interpolatedOrigin.y, interpolatedSize.width, interpolatedSize.height)
    }
}

extension UIColor : Interpolatable {
    /**
    Find a UIColor at a certain progress point (from 0 to 1) between two other UIColors.
    
    - parameter fromValue: The starting UIColor
    - parameter toValue:   The ending UIColor
    - parameter progress:  The progress (from 0 to 1) from the starting UIColor to the end UIColor for this UIColor
    
    - returns: The UIColor at the given progress point between the given starting and ending UIColors
    */
    public static func interpolateFrom(fromValue: UIColor, to toValue: UIColor, withProgress progress: CGFloat) -> UIColor {
        assert((0 <= progress) && (progress <= 1), "Progress must be between 0 and 1")
        var fromRed : CGFloat = 0
        var fromGreen : CGFloat = 0
        var fromBlue : CGFloat = 0
        var fromAlpha : CGFloat = 0
        
        var toRed : CGFloat = 0
        var toGreen : CGFloat = 0
        var toBlue : CGFloat = 0
        var toAlpha : CGFloat = 0
        
        let hasStartColor = razGetRed(&fromRed, green: &fromGreen, blue: &fromBlue, alpha: &fromAlpha, fromColor: fromValue)
        let hasEndColor = razGetRed(&toRed, green: &toGreen, blue: &toBlue, alpha: &toAlpha, fromColor: toValue)
        
        if hasStartColor && hasEndColor {
            let red = CGFloat.interpolateFrom(fromRed, to: toRed, withProgress: progress)
            let green = CGFloat.interpolateFrom(fromGreen, to: toGreen, withProgress: progress)
            let blue = CGFloat.interpolateFrom(fromBlue, to: toBlue, withProgress: progress)
            let alpha = CGFloat.interpolateFrom(fromAlpha, to: toAlpha, withProgress: progress)
            return UIColor(red: red, green: green, blue: blue, alpha: alpha)
        }
        return fromValue
    }
    
    private static func razGetRed(red: UnsafeMutablePointer<CGFloat>, green: UnsafeMutablePointer<CGFloat>, blue: UnsafeMutablePointer<CGFloat>, alpha: UnsafeMutablePointer<CGFloat>, fromColor color: UIColor) -> Bool {
        if color.getRed(red, green: green, blue: blue, alpha: alpha) {return true}
        var white : CGFloat = 0.0
        if color.getWhite(&white, alpha: alpha) {
            red.memory = white
            green.memory = white
            blue.memory = white
            return true
        }
        return false
    }
}

extension Bool : Interpolatable {
    public static func interpolateFrom(fromValue: Bool, to toValue: Bool, withProgress progress: CGFloat) -> Bool {
        assert((0 <= progress) && (progress <= 1), "Progress must be between 0 and 1")
        if progress == 0 {
            return fromValue
        }
        return toValue
    }
}
