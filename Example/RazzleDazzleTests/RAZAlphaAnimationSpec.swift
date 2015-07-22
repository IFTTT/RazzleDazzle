//
//  AlphaAnimationSpec.swift
//  RazzleDazzle
//
//  Created by Laura Skelton on 6/17/15.
//  Copyright (c) 2015 IFTTT. All rights reserved.
//

import RazzleDazzle

import Nimble
import Quick

class AlphaAnimationSpec: QuickSpec {
    override func spec() {
        var view: UIView!
        var animation: AlphaAnimation!
        
        beforeEach {
            view = UIView()
            animation = AlphaAnimation(view: view)
        }
        describe("AlphaAnimation") {
            it("should add and retrieve keyframes") {
                animation[2] = 0.3
                expect(animation[2]).to(equal(0.3))
            }
            it("should add and retrieve negative keyframes") {
                animation[-2] = 0.3
                expect(animation[-2]).to(equal(0.3))
            }
            it("should add and retrieve multiple keyframes") {
                animation[-2] = 0.3
                animation[2] = 0.6
                expect(animation[-2]).to(equal(0.3))
                expect(animation[2]).to(equal(0.6))
            }
            it("should interpolate between keyframes") {
                animation[1] = 0.3
                animation[3] = 0.5
                expect(animation[2]).to(equal(0.4))
            }
            it("should return the first value for times before the start time") {
                animation[2] = 0.3
                animation[4] = 0.5
                expect(animation[1]).to(equal(0.3))
                expect(animation[0]).to(equal(0.3))
            }
            it("should return the last value for times after the end time") {
                animation[2] = 0.3
                animation[4] = 0.5
                expect(animation[6]).to(equal(0.5))
                expect(animation[10]).to(equal(0.5))
            }
            it("should set a easing function") {
                animation.addKeyframe(1, value: 0.1, easing: EasingFunctionEaseInQuad)
                animation.addKeyframe(2, value: 0.2)
                expect(animation[1.5]).to(equal(((0.5 * 0.5) * 0.1) + 0.1))
            }
            it("should use the easing function from the starting keyframe") {
                animation.addKeyframe(1, value: 0.1, easing: EasingFunctionEaseInQuad)
                animation.addKeyframe(2, value: 0.2, easing: EasingFunctionEaseOutBounce)
                expect(animation[1.5]).to(equal(((0.5 * 0.5) * 0.1) + 0.1))
            }
            it("should use linear time for keyframes with no easing function") {
                animation.addKeyframe(1, value: 0.1, easing: EasingFunctionEaseInBounce)
                animation.addKeyframe(2, value: 0.2)
                animation.addKeyframe(3, value: 0.3)
                expect(animation[2.5]).to(equal(0.25))
            }
            it("should apply changes to the view's alpha") {
                animation[1] = 0.3
                animation[3] = 0.5
                animation.animate(1)
                expect(view.alpha).to(beCloseTo(0.3))
                animation.animate(2)
                expect(view.alpha).to(beCloseTo(0.4))
                animation.animate(3)
                expect(view.alpha).to(beCloseTo(0.5))
            }
            it("should do nothing if no keyframes have been set") {
                animation.animate(5)
                expect(view.alpha).to(equal(1))
            }
        }
    }
}
