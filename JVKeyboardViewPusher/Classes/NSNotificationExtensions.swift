import UIKit

/// Helper extensions for the KeyboardViewPusher
public extension NSNotification {
    var keyboardHeight: CGFloat {
        return (userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
    }
    
    var keyboardAnimationDuration: TimeInterval {
        return userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
    }
}
