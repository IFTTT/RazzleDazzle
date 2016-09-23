//
//  Animation.swift
//  RazzleDazzle
//
//  Created by Laura Skelton on 6/24/15.
//  Copyright (c) 2015 IFTTT. All rights reserved.
//

import UIKit

open class Animation<T: Interpolatable> where T.ValueType == T {
    fileprivate let filmstrip = Filmstrip<T>()
    
    public init() {}
    
    open subscript(time: CGFloat) -> T {
        get {
            return filmstrip[time]
        }
        set {
            addKeyframe(time, value: newValue)
        }
    }
    
    open func addKeyframe(_ time: CGFloat, value: T) {
        if !checkValidity(value) {return}
        filmstrip[time] = value
    }
    
    open func addKeyframe(_ time: CGFloat, value: T, easing: @escaping EasingFunction) {
        if !checkValidity(value) {return}
        filmstrip.setValue(value, atTime: time, easing: easing)
    }
    
    open func hasKeyframes() -> Bool {
        return !filmstrip.isEmpty
    }
    
    open func validateValue(_ value: T) -> Bool {
        return true
    }
    
    fileprivate func checkValidity(_ value: T) -> Bool {
        let valid = validateValue(value)
        assert(valid, "The keyframe value is invalid for this type of animation.")
        return valid
    }
}
