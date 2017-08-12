
import UIKit

/**
 Animates the `transform` property of a view's `CALayer`.
 */
public class TransformAnimation : Animation<CATransform3D>, Animatable {
    private let view : UIView
    
    public init(view: UIView) {
        self.view = view
    }
    
    public func animate(_ time: CGFloat) {
        if !hasKeyframes() {return}

        view.layer.transform = self[time]
    }
}
