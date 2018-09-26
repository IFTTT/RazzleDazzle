//
//  AnimationSpec.swift
//  RazzleDazzle
//
//  Created by Laura Skelton on 6/17/15.
//  Copyright (c) 2015 IFTTT. All rights reserved.
//

import RazzleDazzle

import Nimble
import Quick

class AnimationSpec: QuickSpec {
    override func spec() {
        var view: UIView!
        
        beforeEach {
            view = UIView()
        }
        describe("Animations should apply all types of animation to the same view correctly") {
            var mixedTransform : CGAffineTransform!
            
            beforeEach {
                let animator = Animator()
                let alphaAnimation = AlphaAnimation(view: view)
                let colorAnimation = BackgroundColorAnimation(view: view)
                let scaleAnimation = ScaleAnimation(view: view)
                let rotationAnimation = RotationAnimation(view: view)
                let translationAnimation = TranslationAnimation(view: view)
                
                alphaAnimation[2] = 0.5
                colorAnimation[2] = UIColor.red
                scaleAnimation[2] = 3
                rotationAnimation[2] = 90
                translationAnimation[2] = CGPoint(x: 5, y: 15)
                
                animator.addAnimation(alphaAnimation)
                animator.addAnimation(colorAnimation)
                animator.addAnimation(scaleAnimation)
                animator.addAnimation(rotationAnimation)
                animator.addAnimation(translationAnimation)
                
                let scaleTransform = CGAffineTransform(scaleX: 3, y: 3)
                let rotationTransform = CGAffineTransform(rotationAngle: 90 * CGFloat(Double.pi / -180.0))
                let translationTransform = CGAffineTransform(translationX: 5, y: 15)
                mixedTransform = translationTransform.concatenating(scaleTransform.concatenating(rotationTransform))
                
                animator.animate(2)
            }
            it("should apply the correct alpha to the view") {
                expect(view.alpha).to(beCloseTo(0.5))
            }
            it("should apply the correct background color to the view") {
                expect(view.backgroundColor).to(equal(UIColor.red))
            }
            it("should apply the correct transform to the view") {
                expect(view.transform == mixedTransform).to(beTruthy())
            }
        }
    }
}
