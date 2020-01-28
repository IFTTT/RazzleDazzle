//
//  EasingFunctionTests.swift
//  RazzleDazzleTests
//
//  Created by Eduardo Irias on 1/28/20.
//  Copyright © 2020 IFTTT. All rights reserved.
//

import XCTest
@testable import RazzleDazzle

class EasingFunctionTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEasingFunctionLinear() {
        // should return t
        XCTAssertEqual(EasingFunctionLinear(1), 1)
        XCTAssertEqual(EasingFunctionLinear(0.5), 0.5)
        XCTAssertEqual(EasingFunctionLinear(0.25), 0.25)
    }

    func testEasingFunctionEaseInQuad() {
        // should return t * t
        XCTAssertEqual(EasingFunctionEaseInQuad(1), 1)
        XCTAssertEqual(EasingFunctionEaseInQuad(0.5), 0.25)
        XCTAssertEqual(EasingFunctionEaseInQuad(0.25), 0.0625)
    }
    
    func testEasingFunctionEaseInCubic() {
        // should return t * t * t
        XCTAssertEqual(EasingFunctionEaseInCubic(1), 1)
        XCTAssertEqual(EasingFunctionEaseInCubic(0.5), 0.125)
        XCTAssertEqual(EasingFunctionEaseInCubic(0.25), 0.015625)
    }
    
    
    func testEasingFunctionEaseOutQuad() {
        // should return between 0 and 1
        XCTAssertEqual(EasingFunctionEaseOutQuad(1), 1)
        XCTAssertGreaterThan(EasingFunctionEaseOutQuad(0.5), 0)
        XCTAssertLessThan(EasingFunctionEaseOutQuad(0.5), 1)
        XCTAssertEqual(EasingFunctionEaseOutQuad(0), 0)
    }
    
    func testEasingFunctionEaseOutCubic() {
        // should return between 0 and 1
        XCTAssertEqual(EasingFunctionEaseOutCubic(1), 1)
        XCTAssertGreaterThan(EasingFunctionEaseOutCubic(0.5), 0)
        XCTAssertLessThan(EasingFunctionEaseOutCubic(0.5), 1)
        XCTAssertEqual(EasingFunctionEaseOutCubic(0), 0)
    }
    
    func testEasingFunctionEaseInOutCubic() {
        // should return between 0 and 1
        XCTAssertEqual(EasingFunctionEaseInOutCubic(1), 1)
        XCTAssertGreaterThan(EasingFunctionEaseInOutCubic(0.5), 0)
        XCTAssertLessThan(EasingFunctionEaseInOutCubic(0.5), 1)
        XCTAssertEqual(EasingFunctionEaseInOutCubic(0), 0)
    }
    
    func testEasingFunctionEaseInBounce() {
        // should return between 0 and 1
        XCTAssertEqual(EasingFunctionEaseInBounce(1), 1)
        XCTAssertGreaterThan(EasingFunctionEaseInBounce(0.5), 0)
        XCTAssertLessThan(EasingFunctionEaseInBounce(0.5), 1)
        XCTAssertEqual(EasingFunctionEaseInBounce(0), 0)
    }
    
    func testEasingFunctionEaseOutBounce() {
        // should return between 0 and 1
        XCTAssertEqual(EasingFunctionEaseOutBounce(1), 1)
        XCTAssertGreaterThan(EasingFunctionEaseOutBounce(0.5), 0)
        XCTAssertLessThan(EasingFunctionEaseOutBounce(0.5), 1)
        XCTAssertEqual(EasingFunctionEaseOutBounce(0), 0)
    }
    
    func testCubicBezier() {
        // should return between 0 and 1
        let cubicBezierCurve = CubicBezier(0.17, 0.67, 0.83, 0.67)
        
        XCTAssertGreaterThan(cubicBezierCurve(1), 0.99)
        XCTAssertLessThan(cubicBezierCurve(1), 1.01)
        XCTAssertGreaterThan(cubicBezierCurve(0.5), 0)
        XCTAssertLessThan(cubicBezierCurve(0.5), 1)
        XCTAssertLessThan(cubicBezierCurve(0), 0.01)
        XCTAssertGreaterThan(cubicBezierCurve(0), -0.01)
        
    }
}
