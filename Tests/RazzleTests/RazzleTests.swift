import XCTest
@testable import RazzleDazzle

final class RazzleTests: XCTestCase {
    var view = UIView()
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        
        var animation: ScaleAnimation!
        animation = ScaleAnimation(view: view)
        animation[2] = 5
        XCTAssertEqual(animation[2], 5)
        
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
