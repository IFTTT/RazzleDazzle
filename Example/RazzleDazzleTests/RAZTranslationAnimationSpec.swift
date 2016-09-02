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
                animation[2] = CGPoint(x: 1, y: 2)
                expect(animation[2].equalTo(CGPoint(x: 1, y: 2))).to(beTruthy())
            }
            it("should add and retrieve negative keyframes") {
                animation[-2] = CGPoint(x: 1, y: 2)
                expect(animation[-2].equalTo(CGPoint(x: 1, y: 2))).to(beTruthy())
            }
            it("should add and retrieve multiple keyframes") {
                animation[-2] = CGPoint(x: 1, y: 2)
                animation[2] = CGPoint(x: 3, y: 4)
                expect(animation[-2].equalTo(CGPoint(x: 1, y: 2))).to(beTruthy())
                expect(animation[2].equalTo(CGPoint(x: 3, y: 4))).to(beTruthy())
            }
            it("should return the first value for times before the start time") {
                animation[2] = CGPoint(x: 1, y: 2)
                animation[4] = CGPoint(x: 3, y: 4)
                expect(animation[1].equalTo(CGPoint(x: 1, y: 2))).to(beTruthy())
                expect(animation[0].equalTo(CGPoint(x: 1, y: 2))).to(beTruthy())
            }
            it("should return the last value for times after the end time") {
                animation[2] = CGPoint(x: 1, y: 2)
                animation[4] = CGPoint(x: 3, y: 4)
                expect(animation[5].equalTo(CGPoint(x: 3, y: 4))).to(beTruthy())
                expect(animation[6].equalTo(CGPoint(x: 3, y: 4))).to(beTruthy())
            }
            it("should apply changes to the view's translation transform") {
                animation[2] = CGPoint(x: 1, y: 2)
                animation[4] = CGPoint(x: 3, y: 4)
                animation.animate(2)
                expect(view.transform == CGAffineTransform(translationX: 1, y: 2)).to(beTruthy())
                animation.animate(4)
                expect(view.transform == CGAffineTransform(translationX: 3, y: 4)).to(beTruthy())
            }
            it("should do nothing if no keyframes have been set") {
                animation.animate(5)
                expect(view.transform == CGAffineTransform.identity).to(beTruthy())
            }
        }
    }
}
