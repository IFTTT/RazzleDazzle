//
//  Filmstrip.swift
//  RazzleDazzle
//
//  Created by Laura Skelton on 6/14/15.
//  Copyright (c) 2015 IFTTT. All rights reserved.
//

import Foundation

private class Keyframe<T: Interpolatable> where T.ValueType == T {
    let time : CGFloat
    let value : T
    let easing : EasingFunction
    
    fileprivate convenience init(time: CGFloat, value: T) {
        self.init(time: time, value: value, easing: EasingFunctionLinear)
    }
    
    fileprivate init(time: CGFloat, value: T, easing: @escaping EasingFunction) {
        self.time = time
        self.value = value
        self.easing = easing
    }
}

/**
Keeps track of the keyframes set, and lazily generates interpolated values between them for the requested time as needed.
*/
open class Filmstrip<T: Interpolatable> where T.ValueType == T {
    
    fileprivate var keyframes = [Keyframe<T>]()
    
    public init() { }
    
    open var isEmpty: Bool {
        get {
            return keyframes.isEmpty
        }
    }
    
    open subscript(time: CGFloat) -> T {
        get {
            return valueAtTime(time)
        }
        set {
            setValue(newValue, atTime: time)
        }
    }
    
    open func setValue(_ value: T, atTime time: CGFloat) {
        let index = indexOfKeyframeAfterTime(time) ?? keyframes.count
        keyframes.insert(Keyframe(time: time, value: value), at: index)
    }
    
    open func setValue(_ value: T, atTime time: CGFloat, easing: @escaping EasingFunction) {
        let index = indexOfKeyframeAfterTime(time) ?? keyframes.count
        keyframes.insert(Keyframe(time: time, value: value, easing: easing), at: index)
    }
    
    open func valueAtTime(_ time: CGFloat) -> T {
        assert(!self.isEmpty, "At least one KeyFrame must be set before animation begins.")
        var value : T
        let indexAfter = (indexOfKeyframeAfterTime(time) ?? keyframes.count)
        switch indexAfter {
        case 0:
            value = keyframes[0].value
        case 1..<keyframes.count:
            let keyframeBefore = keyframes[indexAfter - 1]
            let keyframeAfter = keyframes[indexAfter]
            let progress = progressFromTime(keyframeBefore.time, toTime: keyframeAfter.time, atTime: time, easing: keyframeBefore.easing)
            value = T.interpolateFrom(keyframeBefore.value, to: keyframeAfter.value, withProgress: progress)
        default:
            value = keyframes.last!.value
        }
        return value
    }
    
    fileprivate func indexOfKeyframeAfterTime(_ time: CGFloat) -> Int? {
        var indexAfter : Int?
        for (index, keyframe) in keyframes.enumerated() {
            if time < keyframe.time {
                indexAfter = index
                break
            }
        }
        return indexAfter
    }
    
    fileprivate func progressFromTime(_ fromTime: CGFloat, toTime: CGFloat, atTime: CGFloat, easing: EasingFunction) -> CGFloat {
        let duration = toTime - fromTime
        if duration == 0 {return 0}
        let timeElapsed = atTime - fromTime
        return easing(timeElapsed / duration)
    }
}
