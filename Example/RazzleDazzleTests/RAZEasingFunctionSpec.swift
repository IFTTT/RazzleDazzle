//
//  EasingFunctionSpec.swift
//  RazzleDazzle
//
//  Created by Laura Skelton on 6/16/15.
//  Copyright (c) 2015 IFTTT. All rights reserved.
//

import RazzleDazzle

import Nimble
import Quick

class EasingFunctionSpec: QuickSpec {
    override func spec() {
        describe("EasingFunctionLinear") {
            it("should return t") {
                expect(EasingFunctionLinear(1)).to(equal(1))
                expect(EasingFunctionLinear(0.5)).to(equal(0.5))
                expect(EasingFunctionLinear(0.25)).to(equal(0.25))
            }
        }
        describe("EasingFunctionEaseInQuad") {
            it("should return t * t") {
                expect(EasingFunctionEaseInQuad(1)).to(equal(1))
                expect(EasingFunctionEaseInQuad(0.5)).to(equal(0.25))
                expect(EasingFunctionEaseInQuad(0.25)).to(equal(0.0625))
            }
        }
        describe("EasingFunctionEaseInCubic") {
            it("should return t * t * t") {
                expect(EasingFunctionEaseInCubic(1)).to(equal(1))
                expect(EasingFunctionEaseInCubic(0.5)).to(equal(0.125))
                expect(EasingFunctionEaseInCubic(0.25)).to(equal(0.015625))
            }
        }
        describe("EasingFunctionEaseOutQuad") {
            it("should return between 0 and 1") {
                expect(EasingFunctionEaseOutQuad(1)).to(equal(1))
                expect(EasingFunctionEaseOutQuad(0.5)).to(beGreaterThan(0))
                expect(EasingFunctionEaseOutQuad(0.5)).to(beLessThan(1))
                expect(EasingFunctionEaseOutQuad(0)).to(equal(0))
            }
        }
        describe("EasingFunctionEaseOutCubic") {
            it("should return between 0 and 1") {
                expect(EasingFunctionEaseOutCubic(1)).to(equal(1))
                expect(EasingFunctionEaseOutCubic(0.5)).to(beGreaterThan(0))
                expect(EasingFunctionEaseOutCubic(0.5)).to(beLessThan(1))
                expect(EasingFunctionEaseOutCubic(0)).to(equal(0))
            }
        }
        describe("EasingFunctionEaseInOutCubic") {
            it("should return between 0 and 1") {
                expect(EasingFunctionEaseInOutCubic(1)).to(equal(1))
                expect(EasingFunctionEaseInOutCubic(0.5)).to(beGreaterThan(0))
                expect(EasingFunctionEaseInOutCubic(0.5)).to(beLessThan(1))
                expect(EasingFunctionEaseInOutCubic(0)).to(equal(0))
            }
        }
        describe("EasingFunctionEaseInBounce") {
            it("should return between 0 and 1") {
                expect(EasingFunctionEaseInBounce(1)).to(equal(1))
                expect(EasingFunctionEaseInBounce(0.5)).to(beGreaterThan(0))
                expect(EasingFunctionEaseInBounce(0.5)).to(beLessThan(1))
                expect(EasingFunctionEaseInBounce(0)).to(equal(0))
            }
        }
        describe("EasingFunctionEaseOutBounce") {
            it("should return between 0 and 1") {
                expect(EasingFunctionEaseOutBounce(1)).to(equal(1))
                expect(EasingFunctionEaseOutBounce(0.5)).to(beGreaterThan(0))
                expect(EasingFunctionEaseOutBounce(0.5)).to(beLessThan(1))
                expect(EasingFunctionEaseOutBounce(0)).to(equal(0))
            }
        }
        describe("CubicBezier") {
            it("should return between 0 and 1") {
                let cubicBezierCurve = CubicBezier(0.17, 0.67, 0.83, 0.67)
                expect(cubicBezierCurve(1)).to(beGreaterThan(0.99))
                expect(cubicBezierCurve(1)).to(beLessThan(1.01))
                expect(cubicBezierCurve(0.5)).to(beGreaterThan(0))
                expect(cubicBezierCurve(0.5)).to(beLessThan(1))
                expect(cubicBezierCurve(0)).to(beLessThan(0.01))
                expect(cubicBezierCurve(0)).to(beGreaterThan(-0.01))
            }
        }
    }
}
