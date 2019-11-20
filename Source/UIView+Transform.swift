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
    
    var rotationTransform: CGAffineTransform? {
        get {
            return getAssociatedObject(self, associativeKey: &RotationTransformAssociatedKey.viewExtension)
        }
        
        set {
            if let value = newValue {
                setAssociatedObject(self, value: value, associativeKey: &RotationTransformAssociatedKey.viewExtension, policy: objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    var scaleTransform: CGAffineTransform? {
        get {
            return getAssociatedObject(self, associativeKey: &ScaleTransformAssociatedKey.viewExtension)
        }
        
        set {
            if let value = newValue {
                setAssociatedObject(self, value: value, associativeKey: &ScaleTransformAssociatedKey.viewExtension, policy: objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    var translationTransform: CGAffineTransform? {
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

private func lift<T>(_ x: T) -> Lifted<T>  {
    return Lifted(x)
}

private func setAssociatedObject<T>(_ object: AnyObject, value: T, associativeKey: UnsafeRawPointer, policy: objc_AssociationPolicy) {
    objc_setAssociatedObject(object, associativeKey, value,  policy)
}

private func getAssociatedObject<T>(_ object: AnyObject, associativeKey: UnsafeRawPointer) -> T? {
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
