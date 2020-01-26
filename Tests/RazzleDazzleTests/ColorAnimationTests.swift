import XCTest
@testable import RazzleDazzle

final class BackgroundColorAnimationTests: XCTestCase {
    var view: UIView!
    var animation: BackgroundColorAnimation!
    
    override func setUp() {
        super.setUp()
        view = UIView()
        view.backgroundColor = UIColor.white
        animation = BackgroundColorAnimation(view: view)
    }
    
    func testRetrieveKeyframes() {
        // should add and retrieve keyframes
        
        animation[2] = UIColor.red
        XCTAssertEqual(animation[2], UIColor.red)
    }
    
    func testRetrieveNegativeKeyframes() {
        // should add and retrieve negative keyframes
        
        animation[-2] = UIColor.red
        XCTAssertEqual(animation[-2], UIColor.red)
    }
    
    func testRetrieveMultipleKeyframes() {
        // should add and retrieve multiple keyframes
        
        animation[-2] = UIColor.red
        animation[2] = UIColor.blue
        XCTAssertEqual(animation[-2], UIColor.red)
        XCTAssertEqual(animation[2], UIColor.blue)
    }
    
    func testBeforeStartFirstValue() {
        // should return the first value for times before the start time
        
        animation[2] = UIColor.red
        animation[4] = UIColor.blue
        XCTAssertEqual(animation[0], UIColor.red)
        XCTAssertEqual(animation[1], UIColor.red)
    }
    

    func testAfterEndLastTime() {
        // should return the last value for times after the end time
        
        animation[2] = UIColor.red
        animation[4] = UIColor.blue
        XCTAssertEqual(animation[6], UIColor.blue)
        XCTAssertEqual(animation[10], UIColor.blue)
    }
    
    func testBackgroundColor() {
        // should apply changes to the view's background color
        
        animation[1] = UIColor.red
        animation[3] = UIColor.blue
        animation.animate(1)
        XCTAssertEqual(view.backgroundColor, UIColor.red)
        animation.animate(3)
        XCTAssertEqual(view.backgroundColor, UIColor.blue)
    }
    
    func testNothing() {
        // should do nothing if no keyframes have been set
        
        animation.animate(5)
        XCTAssertEqual(view.backgroundColor, UIColor.white)
    }
}
