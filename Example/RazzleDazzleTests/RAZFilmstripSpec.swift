//
//  FilmstripSpec.swift
//  RazzleDazzle
//
//  Created by Laura Skelton on 6/16/15.
//  Copyright (c) 2015 IFTTT. All rights reserved.
//

import RazzleDazzle

import Nimble
import Quick

class FilmstripSpec: QuickSpec {
    override func spec() {
        var floatFilmstrip: Filmstrip<CGFloat>!
        var colorFilmstrip: Filmstrip<UIColor>!
        
        beforeEach {
            floatFilmstrip = Filmstrip<CGFloat>()
            colorFilmstrip = Filmstrip<UIColor>()
        }
        
        describe("Filmstrip") {
            it("should start empty") {
                expect(floatFilmstrip.isEmpty).to(beTruthy())
                expect(colorFilmstrip.isEmpty).to(beTruthy())
            }
            it("should set and get a float") {
                floatFilmstrip[2] = 3
                expect(floatFilmstrip[2]).to(equal(3))
            }
            it("should set and get a color") {
                colorFilmstrip[2] = UIColor.red
                expect(colorFilmstrip[2]).to(equal(UIColor.red))
            }
            it("should set and get multiple floats") {
                floatFilmstrip[2] = 3
                floatFilmstrip[5] = 8
                expect(floatFilmstrip[2]).to(equal(3))
                expect(floatFilmstrip[5]).to(equal(8))
            }
            it("should set and get multiple colors") {
                colorFilmstrip[2] = UIColor.red
                colorFilmstrip[5] = UIColor.blue
                expect(colorFilmstrip[2]).to(equal(UIColor.red))
                expect(colorFilmstrip[5]).to(equal(UIColor.blue))
            }
            it("should interpolate between values") {
                floatFilmstrip[2] = 3
                floatFilmstrip[4] = 5
                expect(floatFilmstrip[3]).to(equal(4))
            }
            it("should return the first value for times before the start time") {
                floatFilmstrip[2] = 3
                floatFilmstrip[4] = 5
                expect(floatFilmstrip[1]).to(equal(3))
                expect(floatFilmstrip[0]).to(equal(3))
            }
            it("should return the first value for times before the start time") {
                colorFilmstrip[2] = UIColor.red
                colorFilmstrip[5] = UIColor.blue
                expect(colorFilmstrip[1]).to(equal(UIColor.red))
                expect(colorFilmstrip[0]).to(equal(UIColor.red))
            }
            it("should return the last value for times after the end time") {
                floatFilmstrip[2] = 3
                floatFilmstrip[4] = 5
                expect(floatFilmstrip[6]).to(equal(5))
                expect(floatFilmstrip[10]).to(equal(5))
            }
            it("should return the last value for times after the end time") {
                colorFilmstrip[2] = UIColor.red
                colorFilmstrip[5] = UIColor.blue
                expect(colorFilmstrip[6]).to(equal(UIColor.blue))
                expect(colorFilmstrip[10]).to(equal(UIColor.blue))
            }
            it("should work for negative times") {
                floatFilmstrip[-2] = 3
                floatFilmstrip[4] = 5
                expect(floatFilmstrip[-5]).to(equal(3))
                expect(floatFilmstrip[-2]).to(equal(3))
                expect(floatFilmstrip[4]).to(equal(5))
            }
            it("should work for negative times") {
                colorFilmstrip[-2] = UIColor.red
                colorFilmstrip[4] = UIColor.blue
                expect(colorFilmstrip[-5]).to(equal(UIColor.red))
                expect(colorFilmstrip[-2]).to(equal(UIColor.red))
                expect(colorFilmstrip[4]).to(equal(UIColor.blue))
            }
            it("should set a timing curve") {
                floatFilmstrip.setValue(10, atTime: 1, easing: EasingFunctionEaseInQuad)
                floatFilmstrip.setValue(20, atTime: 2)
                expect(floatFilmstrip.valueAtTime(1.5)).to(equal(((0.5 * 0.5) * 10.0) + 10.0))
            }
            it("should use the timing curve from the starting keyframe") {
                floatFilmstrip.setValue(10, atTime: 1, easing: EasingFunctionEaseInQuad)
                floatFilmstrip.setValue(20, atTime: 2, easing: EasingFunctionEaseInBounce)
                expect(floatFilmstrip.valueAtTime(1.5)).to(equal(((0.5 * 0.5) * 10.0) + 10.0))
            }
            it("should use linear time for keyframes with no timing curve") {
                floatFilmstrip.setValue(10, atTime: 1, easing: EasingFunctionEaseInBounce)
                floatFilmstrip.setValue(20, atTime: 2)
                floatFilmstrip.setValue(30, atTime: 3)
                expect(floatFilmstrip.valueAtTime(2.5)).to(equal(25))
            }
        }
    }
}
