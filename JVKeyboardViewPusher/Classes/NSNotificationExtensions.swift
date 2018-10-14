import UIKit

/// Helper extensions for the KeyboardViewPusher
public extension NSNotification {
    public func determineKeyboardHeight() -> CGFloat? {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
    }
    
    public func determineKeyboardAnimationDuration() -> TimeInterval? {
        return userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
    }
}
