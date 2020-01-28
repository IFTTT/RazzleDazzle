//
//  FilmstripTests.swift
//  RazzleDazzleTests
//
//  Created by Eduardo Irias on 1/28/20.
//  Copyright © 2020 IFTTT. All rights reserved.
//

import XCTest
@testable import RazzleDazzle

class FilmstripTests: XCTestCase {

    var floatFilmstrip: Filmstrip<CGFloat>!
    var colorFilmstrip: Filmstrip<UIColor>!
    
    override func setUp() {
        floatFilmstrip = Filmstrip<CGFloat>()
        colorFilmstrip = Filmstrip<UIColor>()
    }
    
    func testFilmstripStartEmpty() {
        // should start empty
        XCTAssertTrue(floatFilmstrip.isEmpty)
        XCTAssertTrue(colorFilmstrip.isEmpty)
    }

    func testFilmstripFloat() {
        // should set and get a float
        floatFilmstrip[2] = 3
        XCTAssertEqual(floatFilmstrip[2], 3)
    }
    
    func testFilmstripColor() {
        // should set and get a color
        colorFilmstrip[2] = UIColor.red
        XCTAssertEqual(colorFilmstrip[2], UIColor.red)
    }
    
    func testFilmstripMultipleFloats() {
        // should set and get multiple floats
        floatFilmstrip[2] = 3
        floatFilmstrip[5] = 8
        XCTAssertEqual(floatFilmstrip[2], 3)
        XCTAssertEqual(floatFilmstrip[5], 8)
    }
    
    func testFilmstripMultipleColors() {
        // should set and get multiple colors
        colorFilmstrip[2] = UIColor.red
        colorFilmstrip[5] = UIColor.blue
        XCTAssertEqual(colorFilmstrip[2], UIColor.red)
        XCTAssertEqual(colorFilmstrip[5], UIColor.blue)
    }
    
    func testFilmstripInterpolation() {
        // should interpolate between values
        floatFilmstrip[2] = 3
        floatFilmstrip[4] = 5
        XCTAssertEqual(floatFilmstrip[3], 4)
    }
    
    func testFilmstripFirstFloatValue() {
        // should return the first value for times before the start time
        floatFilmstrip[2] = 3
        floatFilmstrip[4] = 5
        XCTAssertEqual(floatFilmstrip[1], 3)
        XCTAssertEqual(floatFilmstrip[0], 3)
    }
    
    func testFilmstripFirstColorValue() {
        // should return the first value for times before the start time
        colorFilmstrip[2] = UIColor.red
        colorFilmstrip[5] = UIColor.blue
        XCTAssertEqual(colorFilmstrip[1], UIColor.red)
        XCTAssertEqual(colorFilmstrip[0], UIColor.red)
    }
    
    func testFilmstripLastFloatValue() {
        // should return the last value for times after the end time
        floatFilmstrip[2] = 3
        floatFilmstrip[4] = 5
        XCTAssertEqual(floatFilmstrip[6], 5)
        XCTAssertEqual(floatFilmstrip[10], 5)
    }
    
    func testFilmstripLastColorValue() {
        // should return the last value for times after the end time
        colorFilmstrip[2] = UIColor.red
        colorFilmstrip[5] = UIColor.blue
        XCTAssertEqual(colorFilmstrip[6], UIColor.blue)
        XCTAssertEqual(colorFilmstrip[10], UIColor.blue)
    }
    
    func testFilmstripFloatNegativeTimes() {
        // should work for negative times
        floatFilmstrip[-2] = 3
        floatFilmstrip[4] = 5
        XCTAssertEqual(floatFilmstrip[-5], 3)
        XCTAssertEqual(floatFilmstrip[-2], 3)
        XCTAssertEqual(floatFilmstrip[4], 5)
    }
    
    func testFilmstripColorNegativeTimes() {
        // should work for negative times
        colorFilmstrip[-2] = UIColor.red
        colorFilmstrip[4] = UIColor.blue
        XCTAssertEqual(colorFilmstrip[-5], UIColor.red)
        XCTAssertEqual(colorFilmstrip[-2], UIColor.red)
        XCTAssertEqual(colorFilmstrip[4], UIColor.blue)
    }
    
    func testFilmstripTimingCurve() {
        // should set a timing curve
        floatFilmstrip.setValue(10, atTime: 1, easing: EasingFunctionEaseInQuad)
        floatFilmstrip.setValue(20, atTime: 2)
        XCTAssertEqual(floatFilmstrip.valueAtTime(1.5), ((0.5 * 0.5) * 10.0) + 10.0)
    }
    
    func testFilmstripTimingCurveStart() {
        // should use the timing curve from the starting keyframe
        floatFilmstrip.setValue(10, atTime: 1, easing: EasingFunctionEaseInQuad)
        floatFilmstrip.setValue(20, atTime: 2, easing: EasingFunctionEaseInBounce)
        XCTAssertEqual(floatFilmstrip.valueAtTime(1.5), ((0.5 * 0.5) * 10.0) + 10.0)
    }
    
    func testFilmstripLinearTime() {
        // should use linear time for keyframes with no timing curve
        floatFilmstrip.setValue(10, atTime: 1, easing: EasingFunctionEaseInBounce)
        floatFilmstrip.setValue(20, atTime: 2)
        floatFilmstrip.setValue(30, atTime: 3)
        XCTAssertEqual(floatFilmstrip.valueAtTime(2.5), 25)
    }

}
