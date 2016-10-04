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
            view.backgroundColor = UIColor.white
            animation = BackgroundColorAnimation(view: view)
        }
        describe("ColorAnimation") {
            it("should add and retrieve keyframes") {
                animation[2] = UIColor.red
                expect(animation[2]).to(equal(UIColor.red))
            }
            it("should add and retrieve negative keyframes") {
                animation[-2] = UIColor.red
                expect(animation[-2]).to(equal(UIColor.red))
            }
            it("should add and retrieve multiple keyframes") {
                animation[-2] = UIColor.red
                animation[2] = UIColor.blue
                expect(animation[-2]).to(equal(UIColor.red))
                expect(animation[2]).to(equal(UIColor.blue))
            }
            it("should return the first value for times before the start time") {
                animation[2] = UIColor.red
                animation[4] = UIColor.blue
                expect(animation[1]).to(equal(UIColor.red))
                expect(animation[0]).to(equal(UIColor.red))
            }
            it("should return the last value for times after the end time") {
                animation[2] = UIColor.red
                animation[4] = UIColor.blue
                expect(animation[6]).to(equal(UIColor.blue))
                expect(animation[10]).to(equal(UIColor.blue))
            }
            it("should apply changes to the view's background color") {
                animation[1] = UIColor.red
                animation[3] = UIColor.blue
                animation.animate(1)
                expect(view.backgroundColor).to(equal(UIColor.red))
                animation.animate(3)
                expect(view.backgroundColor).to(equal(UIColor.blue))
            }
            it("should do nothing if no keyframes have been set") {
                animation.animate(5)
                expect(view.backgroundColor).to(equal(UIColor.white))
            }
        }
    }
}
