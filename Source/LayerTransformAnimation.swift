
import UIKit

/**
 Animates the `transform` property of a `CALayer`.
 */
public class LayerTransformAnimation : Animation<CATransform3D>, Animatable {
    private let layer : CALayer
    
    public init(layer: CALayer) {
        self.layer = layer
    }
    
    public func animate(_ time: CGFloat) {
        if !hasKeyframes() {return}

        layer.transform = self[time]
    }
}
