import XCTest
@testable import RazzleDazzle

final class AnimationSpec: XCTestCase {
    var view: UIView!
    var mixedTransform : CGAffineTransform!

    override func setUp() {
        super.setUp()
                
        view = UIView()
        
        let animator = Animator()
        let alphaAnimation = AlphaAnimation(view: view)
        let colorAnimation = BackgroundColorAnimation(view: view)
        let scaleAnimation = ScaleAnimation(view: view)
        let rotationAnimation = RotationAnimation(view: view)
        let translationAnimation = TranslationAnimation(view: view)
        
        alphaAnimation[2] = 0.5
        colorAnimation[2] = UIColor.red
        scaleAnimation[2] = 3
        rotationAnimation[2] = 90
        translationAnimation[2] = CGPoint(x: 5, y: 15)
        
        animator.addAnimation(alphaAnimation)
        animator.addAnimation(colorAnimation)
        animator.addAnimation(scaleAnimation)
        animator.addAnimation(rotationAnimation)
        animator.addAnimation(translationAnimation)
        
        let scaleTransform = CGAffineTransform(scaleX: 3, y: 3)
        let rotationTransform = CGAffineTransform(rotationAngle: 90 * CGFloat.pi / -180.0)
        let translationTransform = CGAffineTransform(translationX: 5, y: 15)
        mixedTransform = translationTransform.concatenating(scaleTransform.concatenating(rotationTransform))
        
        animator.animate(2)
    }
    
    
    func testViewsAlpha() {
        // should apply the correct alpha to the view
        XCTAssertLessThan(abs(view.alpha - 0.5), 0.1)
    }
    
    func testViewsBackgroundColor() {
        // should apply the correct background color to the view
        
        XCTAssertEqual(view.backgroundColor, UIColor.red)
    }
    
    func testViewsTrasformation() {
        // should apply the correct transform to the view
        
        XCTAssertEqual(view.transform, mixedTransform)
    }
    
}
