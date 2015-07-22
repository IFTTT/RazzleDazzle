//
//  Animation.swift
//  RazzleDazzle
//
//  Created by Laura Skelton on 6/24/15.
//  Copyright (c) 2015 IFTTT. All rights reserved.
//

import UIKit

public class Animation<T: Interpolatable where T.ValueType == T> {
    private let filmstrip = Filmstrip<T>()
    
    public init() {}
    
    public subscript(time: CGFloat) -> T {
        get {
            return filmstrip[time]
        }
        set {
            addKeyframe(time, value: newValue)
        }
    }
    
    public func addKeyframe(time: CGFloat, value: T) {
        if !checkValidity(value) {return}
        filmstrip[time] = value
    }
    
    public func addKeyframe(time: CGFloat, value: T, easing: EasingFunction) {
        if !checkValidity(value) {return}
        filmstrip.setValue(value, atTime: time, easing: easing)
    }
    
    public func hasKeyframes() -> Bool {
        return !filmstrip.isEmpty
    }
    
    public func validateValue(value: T) -> Bool {
        return true
    }
    
    private func checkValidity(value: T) -> Bool {
        let valid = validateValue(value)
        assert(valid, "The keyframe value is invalid for this type of animation.")
        return valid
    }
}
