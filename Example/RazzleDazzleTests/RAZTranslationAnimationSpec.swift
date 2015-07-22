//
//  TranslationAnimationSpec.swift
//  RazzleDazzle
//
//  Created by Laura Skelton on 6/17/15.
//  Copyright (c) 2015 IFTTT. All rights reserved.
//

import RazzleDazzle

import Nimble
import Quick

class TranslationAnimationSpec: QuickSpec {
    override func spec() {
        var view: UIView!
        var animation: TranslationAnimation!
        
        beforeEach {
            view = UIView()
            animation = TranslationAnimation(view: view)
        }
        describe("TranslationAnimation") {
            it("should add and retrieve keyframes") {
                animation[2] = CGPointMake(1, 2)
                expect(CGPointEqualToPoint(animation[2], CGPointMake(1, 2))).to(beTruthy())
            }
            it("should add and retrieve negative keyframes") {
                animation[-2] = CGPointMake(1, 2)
                expect(CGPointEqualToPoint(animation[-2], CGPointMake(1, 2))).to(beTruthy())
            }
            it("should add and retrieve multiple keyframes") {
                animation[-2] = CGPointMake(1, 2)
                animation[2] = CGPointMake(3, 4)
                expect(CGPointEqualToPoint(animation[-2], CGPointMake(1, 2))).to(beTruthy())
                expect(CGPointEqualToPoint(animation[2], CGPointMake(3, 4))).to(beTruthy())
            }
            it("should return the first value for times before the start time") {
                animation[2] = CGPointMake(1, 2)
                animation[4] = CGPointMake(3, 4)
                expect(CGPointEqualToPoint(animation[1], CGPointMake(1, 2))).to(beTruthy())
                expect(CGPointEqualToPoint(animation[0], CGPointMake(1, 2))).to(beTruthy())
            }
            it("should return the last value for times after the end time") {
                animation[2] = CGPointMake(1, 2)
                animation[4] = CGPointMake(3, 4)
                expect(CGPointEqualToPoint(animation[5], CGPointMake(3, 4))).to(beTruthy())
                expect(CGPointEqualToPoint(animation[6], CGPointMake(3, 4))).to(beTruthy())
            }
            it("should apply changes to the view's translation transform") {
                animation[2] = CGPointMake(1, 2)
                animation[4] = CGPointMake(3, 4)
                animation.animate(2)
                expect(CGAffineTransformEqualToTransform(view.transform, CGAffineTransformMakeTranslation(1, 2))).to(beTruthy())
                animation.animate(4)
                expect(CGAffineTransformEqualToTransform(view.transform, CGAffineTransformMakeTranslation(3, 4))).to(beTruthy())
            }
            it("should do nothing if no keyframes have been set") {
                animation.animate(5)
                expect(CGAffineTransformEqualToTransform(view.transform, CGAffineTransformIdentity)).to(beTruthy())
            }
        }
    }
}
