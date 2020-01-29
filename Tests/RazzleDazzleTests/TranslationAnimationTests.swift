//
//  TranslationAnimationTests.swift
//  RazzleDazzleTests
//
//  Created by Eduardo Irias on 1/29/20.
//  Copyright © 2020 IFTTT. All rights reserved.
//

import XCTest
@testable import RazzleDazzle

class TranslationAnimationTests: XCTestCase {
    
    var view: UIView!
    var animation: TranslationAnimation!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        view = UIView()
        animation = TranslationAnimation(view: view)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRetrieveKeyframes() {
        // should add and retrieve keyframes
        
        animation[2] = CGPoint(x: 1, y: 2)
        XCTAssertEqual(animation[2], CGPoint(x: 1, y: 2))
    }
    
    func testRetrieveNegativeKeyframes() {
        // should add and retrieve negative keyframes
        
        animation[-2] = CGPoint(x: 1, y: 2)
        XCTAssertEqual(animation[-2], CGPoint(x: 1, y: 2))
    }
    
    func testRetrieveMultipleKeyframes() {
        // should add and retrieve multiple keyframes
        
        animation[-2] = CGPoint(x: 1, y: 2)
        animation[2] = CGPoint(x: 3, y: 4)
        XCTAssertEqual(animation[-2], CGPoint(x: 1, y: 2))
        XCTAssertEqual(animation[2], CGPoint(x: 3, y: 4))
    }
    
    func testBeforeStartFirstValue() {
        // should return the first value for times before the start time
        
        animation[2] = CGPoint(x: 1, y: 2)
        animation[4] = CGPoint(x: 3, y: 4)
        XCTAssertEqual(animation[0], CGPoint(x: 1, y: 2))
        XCTAssertEqual(animation[1], CGPoint(x: 1, y: 2))
    }
    
    func testAfterEndLastTime() {
        // should return the last value for times after the end time
        
        animation[2] = CGPoint(x: 1, y: 2)
        animation[4] = CGPoint(x: 3, y: 4)
        XCTAssertEqual(animation[6], CGPoint(x: 3, y: 4))
        XCTAssertEqual(animation[10], CGPoint(x: 3, y: 4))
    }
    
    func testViewTranslationTransform() {
        // should apply changes to the view's scale transform
        
        animation[2] = CGPoint(x: 1, y: 2)
        animation[4] = CGPoint(x: 3, y: 4)
        animation.animate(2)
        XCTAssertEqual(view.transform, CGAffineTransform(translationX: 1, y: 2))
        animation.animate(4)
        XCTAssertEqual(view.transform, CGAffineTransform(translationX: 3, y: 4))
    }
    
    func testNothing() {
        // should do nothing if no keyframes have been set
        
        animation.animate(5)
        XCTAssertEqual(view.transform, CGAffineTransform.identity)
    }
    
}
