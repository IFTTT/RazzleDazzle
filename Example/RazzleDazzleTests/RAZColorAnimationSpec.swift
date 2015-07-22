//
//  ColorAnimationSpec.swift
//  RazzleDazzle
//
//  Created by Laura Skelton on 6/17/15.
//  Copyright (c) 2015 IFTTT. All rights reserved.
//

import RazzleDazzle

import Nimble
import Quick

class BackgroundColorAnimationSpec: QuickSpec {
    override func spec() {
        var view: UIView!
        var animation: BackgroundColorAnimation!
        
        beforeEach {
            view = UIView()
            view.backgroundColor = UIColor.whiteColor()
            animation = BackgroundColorAnimation(view: view)
        }
        describe("ColorAnimation") {
            it("should add and retrieve keyframes") {
                animation[2] = UIColor.redColor()
                expect(animation[2]).to(equal(UIColor.redColor()))
            }
            it("should add and retrieve negative keyframes") {
                animation[-2] = UIColor.redColor()
                expect(animation[-2]).to(equal(UIColor.redColor()))
            }
            it("should add and retrieve multiple keyframes") {
                animation[-2] = UIColor.redColor()
                animation[2] = UIColor.blueColor()
                expect(animation[-2]).to(equal(UIColor.redColor()))
                expect(animation[2]).to(equal(UIColor.blueColor()))
            }
            it("should return the first value for times before the start time") {
                animation[2] = UIColor.redColor()
                animation[4] = UIColor.blueColor()
                expect(animation[1]).to(equal(UIColor.redColor()))
                expect(animation[0]).to(equal(UIColor.redColor()))
            }
            it("should return the last value for times after the end time") {
                animation[2] = UIColor.redColor()
                animation[4] = UIColor.blueColor()
                expect(animation[6]).to(equal(UIColor.blueColor()))
                expect(animation[10]).to(equal(UIColor.blueColor()))
            }
            it("should apply changes to the view's background color") {
                animation[1] = UIColor.redColor()
                animation[3] = UIColor.blueColor()
                animation.animate(1)
                expect(view.backgroundColor).to(equal(UIColor.redColor()))
                animation.animate(3)
                expect(view.backgroundColor).to(equal(UIColor.blueColor()))
            }
            it("should do nothing if no keyframes have been set") {
                animation.animate(5)
                expect(view.backgroundColor).to(equal(UIColor.whiteColor()))
            }
        }
    }
}
