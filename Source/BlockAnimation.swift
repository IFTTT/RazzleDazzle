import Foundation

/// Allows for custom animations by providing the timing to a block
class BlockAnimation<T: Interpolatable>: Animation<T>, Animatable where T.ValueType == T {
    fileprivate let block: ((T) -> Void)
    
    init(block: @escaping ((T) -> Void)) {
        self.block = block
    }
    
    func animate(_ time: CGFloat) {
        if !hasKeyframes() { return }
        
        block(self[time])
    }
}
