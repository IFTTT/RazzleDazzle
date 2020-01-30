//
//  InterpolatableTests.swift
//  RazzleDazzleTests
//
//  Created by Eduardo Irias on 1/28/20.
//  Copyright © 2020 IFTTT. All rights reserved.
//

import XCTest

class InterpolatableTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - CGFloat
    
    func testInterpolateFloats() {
        // should interpolate floats
        
        let middleFloat = CGFloat.interpolateFrom(1, to: 3, withProgress: 0.5)
        XCTAssertEqual(middleFloat, 2)
    }
    
    func testInterpolateFloatsLessHalfway() {
        // should interpolate floats with less than halfway progress
        
        let middleFloat = CGFloat.interpolateFrom(1, to: 2, withProgress: 0.25)
        XCTAssertEqual(middleFloat, 1.25)
    }
    
    
    func testInterpolateFloatsGreaterHalfway() {
        // should interpolate floats with greater than halfway progress
        
        let middleFloat = CGFloat.interpolateFrom(1, to: 2, withProgress: 0.75)
        XCTAssertEqual(middleFloat, 1.75)
    }
    
    func testInterpolateFloatsNoProgress() {
        // should interpolate floats with no progress
        
        let middleFloat = CGFloat.interpolateFrom(1, to: 2, withProgress: 0)
        XCTAssertEqual(middleFloat, 1)
    }
    
    func testInterpolateFloatsFullProgress() {
        // should interpolate floats with full progress
        
        let middleFloat = CGFloat.interpolateFrom(1, to: 2, withProgress: 1)
        XCTAssertEqual(middleFloat, 2)
    }
    
    // MARK: - CGPoint

    func testInterpolatePoint() {
        // should interpolate points
        
        let middlePoint = CGPoint.interpolateFrom(CGPoint(x: 1, y: 2), to: CGPoint(x: 3, y: 6), withProgress: 0.5)
        XCTAssertEqual(middlePoint, CGPoint(x: 2, y: 4))
    }
    
    // MARK: - CGSize

    func testInterpolateSize() {
        // should interpolate sizes
        
        let middleSize = CGSize.interpolateFrom(CGSize(width: 1, height: 2), to: CGSize(width: 3, height: 6), withProgress: 0.5)
        XCTAssertEqual(middleSize, CGSize(width: 2, height: 4))
    }
    
    // MARK: - CGRect
    
    func testInterpolateRect() {
        // should interpolate rects
        
        let middleRect = CGRect.interpolateFrom(CGRect(x: 1, y: 2, width: 10, height: 20), to: CGRect(x: 3, y: 6, width: 30, height: 60), withProgress: 0.5)
        XCTAssertEqual(middleRect, CGRect(x: 2, y: 4, width: 20, height: 40))
    }
    
}
