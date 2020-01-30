import XCTest
@testable import RazzleDazzle

final class AlphaAnimationTests: XCTestCase {
    var view: UIView!
    var animation: AlphaAnimation!
    
    override func setUp() {
        super.setUp()
                
        view = UIView()
        animation = AlphaAnimation(view: view)
    }
    
    func testAddRetrieveKeyframes() {
        // Should add and retrieve keyframes
        
        animation[2] = 0.3
        XCTAssertEqual(animation[2], 0.3)
    }
    
    func testAddRetrieveNegativeKeyframes() {
        // should add and retrieve negative keyframes
        
        animation[-2] = 0.3
        XCTAssertEqual(animation[-2], 0.3)
    }
    
    func testAddRetrieveMultipleKeyframes() {
        // should add and retrieve multiple keyframes
        
        animation[-2] = 0.3
        animation[2] = 0.6
        XCTAssertEqual(animation[-2], 0.3)
        XCTAssertEqual(animation[2], 0.6)
    }
    
    func testInterpolationBetweenKeyframes() {
        // should interpolate between keyframes
        
        animation[1] = 0.3
        animation[3] = 0.5
        XCTAssertEqual(animation[2], 0.4)
    }
    
    func testBeforeStartFirstValue() {
        // should return the first value for times before the start time
        
        animation[2] = 0.3
        animation[4] = 0.5
        XCTAssertEqual(animation[1], 0.3)
        XCTAssertEqual(animation[0], 0.3)
    }
    
    func testAfterEndLastTime() {
        // should return the last value for times after the end time
        
        animation[2] = 0.3
        animation[4] = 0.5
        XCTAssertEqual(animation[6], 0.5)
        XCTAssertEqual(animation[10], 0.5)
    }
    
    func testEasing() {
        // should set a easing function
        
        animation.addKeyframe(1, value: 0.1, easing: EasingFunctionEaseInQuad)
        animation.addKeyframe(2, value: 0.2)
        XCTAssertEqual(animation[1.5], ((0.5 * 0.5) * 0.1) + 0.1)
    }
    
    func testEasingStartingKeyframe() {
        // should use the easing function from the starting keyframe
        
        animation.addKeyframe(1, value: 0.1, easing: EasingFunctionEaseInQuad)
        animation.addKeyframe(2, value: 0.2, easing: EasingFunctionEaseOutBounce)        
        XCTAssertEqual(animation[1.5], ((0.5 * 0.5) * 0.1) + 0.1)
    }
    
    func testLinearTimeWithNoEasing() {
        // should use linear time for keyframes with no easing function
        
        animation.addKeyframe(1, value: 0.1, easing: EasingFunctionEaseInBounce)
        animation.addKeyframe(2, value: 0.2)
        animation.addKeyframe(3, value: 0.3)
        XCTAssertEqual(animation[2.5], 0.25)
    }
    
    func testViewsAlpha() {
        // should apply changes to the view's alpha
        
        animation[1] = 0.3
        animation[3] = 0.5
        animation.animate(1)
        XCTAssertLessThan(abs(view.alpha - 0.3), 0.1)
        animation.animate(2)
        XCTAssertLessThan(abs(view.alpha - 0.4), 0.1)
        animation.animate(3)
        XCTAssertLessThan(abs(view.alpha - 0.4), 0.1)
    }
    
    func testNothing() {
        // should do nothing if no keyframes have been set
        
        animation.animate(5)
        XCTAssertEqual(view.alpha, 1)
    }
    
}
