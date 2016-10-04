//
//  ScaleAnimationSpec.swift
//  RazzleDazzle
//
//  Created by Laura Skelton on 6/17/15.
//  Copyright (c) 2015 IFTTT. All rights reserved.
//

import RazzleDazzle

import Nimble
import Quick

class ScaleAnimationSpec: QuickSpec {
    override func spec() {
        var view: UIView!
        var animation: ScaleAnimation!
        
        beforeEach {
            view = UIView()
            animation = ScaleAnimation(view: view)
        }
        describe("ScaleAnimation") {
            it("should add and retrieve keyframes") {
                animation[2] = 5
                expect(animation[2]).to(equal(5))
            }
            it("should add and retrieve negative keyframes") {
                animation[-2] = 5
                expect(animation[-2]).to(equal(5))
            }
            it("should add and retrieve multiple keyframes") {
                animation[-2] = 3
                animation[2] = 5
                expect(animation[-2]).to(equal(3))
                expect(animation[2]).to(equal(5))
            }
            it("should return the first value for times before the start time") {
                animation[2] = 3
                animation[4] = 5
                expect(animation[1]).to(equal(3))
                expect(animation[0]).to(equal(3))
            }
            it("should return the last value for times after the end time") {
                animation[2] = 3
                animation[4] = 5
                expect(animation[6]).to(equal(5))
                expect(animation[10]).to(equal(5))
            }
            it("should apply changes to the view's scale transform") {
                animation[1] = 3
                animation[3] = 5
                animation.animate(1)
                expect(view.transform == CGAffineTransform(scaleX: 3, y: 3)).to(beTruthy())
                animation.animate(3)
                expect(view.transform == CGAffineTransform(scaleX: 5, y: 5)).to(beTruthy())
            }
            it("should do nothing if no keyframes have been set") {
                animation.animate(5)
                expect(view.transform == CGAffineTransform.identity).to(beTruthy())
            }
        }
    }
}
