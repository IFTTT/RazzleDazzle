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
                let middlePoint = CGPoint.interpolateFrom(CGPoint(x: 1, y: 2), to: CGPoint(x: 3, y: 6), withProgress: 0.5)
                expect(middlePoint).to(equal(CGPoint(x: 2, y: 4)))
            }
        }
        describe("Interpolatable-CGSize") {
            it("should interpolate sizes") {
                let middleSize = CGSize.interpolateFrom(CGSize(width: 1, height: 2), to: CGSize(width: 3, height: 6), withProgress: 0.5)
                expect(middleSize).to(equal(CGSize(width: 2, height: 4)))
            }
        }
        describe("Interpolatable-CGRect") {
            it("should interpolate rects") {
                let middleRect = CGRect.interpolateFrom(CGRect(x: 1, y: 2, width: 10, height: 20), to: CGRect(x: 3, y: 6, width: 30, height: 60), withProgress: 0.5)
                expect(middleRect).to(equal(CGRect(x: 2, y: 4, width: 20, height: 40)))
            }
        }
    }
}
