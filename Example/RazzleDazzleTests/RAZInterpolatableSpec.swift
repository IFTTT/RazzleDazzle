//
//  InterpolatableSpec.swift
//  RazzleDazzle
//
//  Created by Laura Skelton on 6/17/15.
//  Copyright (c) 2015 IFTTT. All rights reserved.
//

import RazzleDazzle

import Nimble
import Quick

class InterpolatableSpec: QuickSpec {
    override func spec() {
        describe("Interpolatable-CGFloat") {
            it("should interpolate floats") {
                let middleFloat = CGFloat.interpolateFrom(1, to: 3, withProgress: 0.5)
                expect(middleFloat).to(equal(2))
            }
            it("should interpolate floats with less than halfway progress") {
                let middleFloat = CGFloat.interpolateFrom(1, to: 2, withProgress: 0.25)
                expect(middleFloat).to(equal(1.25))
            }
            it("should interpolate floats with greater than halfway progress") {
                let middleFloat = CGFloat.interpolateFrom(1, to: 2, withProgress: 0.75)
                expect(middleFloat).to(equal(1.75))
            }
            it("should interpolate floats with no progress") {
                let middleFloat = CGFloat.interpolateFrom(1, to: 2, withProgress: 0)
                expect(middleFloat).to(equal(1))
            }
            it("should interpolate floats with full progress") {
                let middleFloat = CGFloat.interpolateFrom(1, to: 2, withProgress: 1)
                expect(middleFloat).to(equal(2))
            }
        }
        describe("Interpolatable-CGPoint") {
            it("should interpolate points") {
                let middlePoint = CGPoint.interpolateFrom(CGPointMake(1, 2), to: CGPointMake(3, 6), withProgress: 0.5)
                expect(middlePoint).to(equal(CGPointMake(2, 4)))
            }
        }
        describe("Interpolatable-CGSize") {
            it("should interpolate sizes") {
                let middleSize = CGSize.interpolateFrom(CGSizeMake(1, 2), to: CGSizeMake(3, 6), withProgress: 0.5)
                expect(middleSize).to(equal(CGSizeMake(2, 4)))
            }
        }
        describe("Interpolatable-CGRect") {
            it("should interpolate rects") {
                let middleRect = CGRect.interpolateFrom(CGRectMake(1, 2, 10, 20), to: CGRectMake(3, 6, 30, 60), withProgress: 0.5)
                expect(middleRect).to(equal(CGRectMake(2, 4, 20, 40)))
            }
        }
    }
}
