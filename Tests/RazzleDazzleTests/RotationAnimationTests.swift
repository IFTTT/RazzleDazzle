//
//  RotationAnimationTests.swift
//  RazzleDazzleTests
//
//  Created by Eduardo Irias on 1/29/20.
//  Copyright © 2020 IFTTT. All rights reserved.
//

import XCTest
@testable import RazzleDazzle

class RotationAnimationTests: XCTestCase {
    
    var view: UIView!
    var animation: RotationAnimation!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        view = UIView()
        animation = RotationAnimation(view: view)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRetrieveKeyframes() {
        // should add and retrieve keyframes
        
        animation[2] = 5
        XCTAssertEqual(animation[2], 5)
    }
    
    func testRetrieveNegativeKeyframes() {
        // should add and retrieve negative keyframes
        
        animation[-2] = 5
        XCTAssertEqual(animation[-2], 5)
    }
    
    func testRetrieveMultipleKeyframes() {
        // should add and retrieve multiple keyframes
        
        animation[-2] = 3
        animation[2] = 5
        XCTAssertEqual(animation[-2], 3)
        XCTAssertEqual(animation[2], 5)
    }
    
    func testBeforeStartFirstValue() {
        // should return the first value for times before the start time
        
        animation[2] = 3
        animation[4] = 5
        XCTAssertEqual(animation[0], 3)
        XCTAssertEqual(animation[1], 3)
    }
    
    func testAfterEndLastTime() {
        // should return the last value for times after the end time
        
        animation[2] = 3
        animation[4] = 5
        XCTAssertEqual(animation[6], 5)
        XCTAssertEqual(animation[10], 5)
    }
    
    func testViewRotationTransform() {
        // should apply changes to the view's scale transform
        
        animation[1] = 3
        animation[3] = 5
        let radiansOne = 3 * (CGFloat.pi / -180.0)
        let radiansThree = 5 * (CGFloat.pi / -180.0)
        animation.animate(1)
        XCTAssertEqual(view.transform, CGAffineTransform(rotationAngle: radiansOne))
        animation.animate(3)
        XCTAssertEqual(view.transform, CGAffineTransform(rotationAngle: radiansThree))
    }
    
    func testNothing() {
        // should do nothing if no keyframes have been set
        
        animation.animate(5)
        XCTAssertEqual(view.transform, CGAffineTransform.identity)
    }
}
