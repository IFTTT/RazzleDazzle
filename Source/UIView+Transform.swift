//
//  UIView+Transform.swift
//  RazzleDazzle
//
//  Created by Laura Skelton on 6/13/15.
//  Copyright (c) 2015 IFTTT. All rights reserved.
//

import ObjectiveC

internal extension UIView {
    
    private struct RotationTransformAssociatedKey {
        static var viewExtension = "ViewRotationExtension"
    }
    
    private struct ScaleTransformAssociatedKey {
        static var viewExtension = "ViewScaleExtension"
    }
    
    private struct TranslationTransformAssociatedKey {
        static var viewExtension = "ViewTranslationExtension"
    }
    
    internal var rotationTransform: CGAffineTransform? {
        get {
            return getAssociatedObject(self, associativeKey: &RotationTransformAssociatedKey.viewExtension)
        }
        
        set {
            if let value = newValue {
                setAssociatedObject(self, value: value, associativeKey: &RotationTransformAssociatedKey.viewExtension, policy: objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    internal var scaleTransform: CGAffineTransform? {
        get {
            return getAssociatedObject(self, associativeKey: &ScaleTransformAssociatedKey.viewExtension)
        }
        
        set {
            if let value = newValue {
                setAssociatedObject(self, value: value, associativeKey: &ScaleTransformAssociatedKey.viewExtension, policy: objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    internal var translationTransform: CGAffineTransform? {
        get {
            return getAssociatedObject(self, associativeKey: &TranslationTransformAssociatedKey.viewExtension)
        }
        
        set {
            if let value = newValue {
                setAssociatedObject(self, value: value, associativeKey: &TranslationTransformAssociatedKey.viewExtension, policy: objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}

private final class Lifted<T> {
    let value: T
    init(_ x: T) {
        value = x
    }
}

private func lift<T>(x: T) -> Lifted<T>  {
    return Lifted(x)
}

private func setAssociatedObject<T>(object: AnyObject, value: T, associativeKey: UnsafePointer<Void>, policy: objc_AssociationPolicy) {
    if let v: AnyObject = value as? AnyObject {
        objc_setAssociatedObject(object, associativeKey, v,  policy)
    }
    else {
        objc_setAssociatedObject(object, associativeKey, lift(value),  policy)
    }
}

private func getAssociatedObject<T>(object: AnyObject, associativeKey: UnsafePointer<Void>) -> T? {
    if let v = objc_getAssociatedObject(object, associativeKey) as? T {
        return v
    }
    else if let v = objc_getAssociatedObject(object, associativeKey) as? Lifted<T> {
        return v.value
    }
    else {
        return nil
    }
}
