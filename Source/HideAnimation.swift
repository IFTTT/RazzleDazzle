//
//  HideAnimation.swift
//  RazzleDazzle
//
//  Created by Laura Skelton on 6/27/15.
//  Copyright © 2015 IFTTT. All rights reserved.
//

import UIKit

/**
Animates the `hidden` property of a `UIView`.
*/
open class HideAnimation : Animatable {
    fileprivate let filmstrip = Filmstrip<Bool>()
    fileprivate let view : UIView
    
    public init(view: UIView, hideAt: CGFloat) {
        self.view = view
        filmstrip[hideAt] = false
        filmstrip[hideAt + 0.00001] = true
    }
    
    public init(view: UIView, showAt: CGFloat) {
        self.view = view
        filmstrip[showAt] = true
        filmstrip[showAt + 0.00001] = false
    }
    
    open func animate(_ time: CGFloat) {
        if filmstrip.isEmpty {return}
        view.isHidden = filmstrip[time]
    }
}
