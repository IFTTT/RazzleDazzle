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
public class HideAnimation : Animatable {
    private let filmstrip = Filmstrip<Bool>()
    private let view : UIView
    
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
    
    public func animate(time: CGFloat) {
        if filmstrip.isEmpty {return}
        view.hidden = filmstrip[time]
    }
}
