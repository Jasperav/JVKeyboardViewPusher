import UIKit

/// Be SURE to call didAppear() and disDisappear() at the right time in your viewcontroller.
open class KeyboardViewPusher {
    
    /// Because of 2 things we need the actual viewControllersView:
    ///     1. Because we need to call layoutIfNeeded() on this particular view to actually animate it
    ///        If we do this directly on property 'view', it doesn't animate (nice job Apple).
    ///     2. To determine the safe area bottom constant (although we can get it also through the keyWindow).
    ///        But then we need to force unwrap stuff.
    public unowned let viewControllerView: UIView
    
    /// This is the view to push upwards.
    public unowned let view: UIView
    
    /// The bottom constant.
    /// Make sure this is equal to view.bottomAnchor == viewControllerView.bottomAnchor
    public unowned let viewBottomConstraint: NSLayoutConstraint
    
    /// Start constant of viewBottomConstraint
    /// We need this to properly animate it back when the keyboard will hide.
    public let viewBottomConstraintConstant: CGFloat
    
    public init(viewControllerView: UIView, view: UIView, viewBottomConstraint: NSLayoutConstraint) {
        self.viewControllerView = viewControllerView
        self.view = view
        self.viewBottomConstraint = viewBottomConstraint
        viewBottomConstraintConstant = viewBottomConstraint.constant
    }
    
    /// Call this in the viewDidAppear() method in the viewController.
    open func didAppear() {
        addObserver()
    }
    
    /// Call this in the viewDidDisappear() method in the viewController.
    open func didDisappear() {
        removeObserver()
    }
    
    open func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    open func addObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc open func keyboardWillShow(_ notification: NSNotification) {
        let maximumPushValue = -(notification.keyboardHeight - viewControllerView.safeAreaInsets.bottom)
        
        viewBottomConstraint.constant = maximumPushValue
        
        UIView.animate(withDuration: notification.keyboardAnimationDuration) {
            self.viewControllerView.layoutIfNeeded()
        }
    }
    
    @objc open func keyboardWillHide(_ notification: NSNotification) {
        hide(animationDuration: notification.keyboardAnimationDuration)
    }
    
    // When animation with a value of 0, it doesn't actually animates it but directly layouts the view.
    // This doesn't negatively affect the performance.
    open func hide(animationDuration: TimeInterval = 0) {
        guard viewBottomConstraint.constant != viewBottomConstraintConstant else { return }
        
        viewBottomConstraint.constant = viewBottomConstraintConstant
        
        UIView.animate(withDuration: animationDuration) {
            self.viewControllerView.layoutIfNeeded()
        }
    }
    
    deinit {
        removeObserver()
    }
}
