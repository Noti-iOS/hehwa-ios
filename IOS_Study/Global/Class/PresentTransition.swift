//
//  PresentTransition.swift
//  IOS_Study
//
//  Created by ho jun lim on 2022/01/15.
//

import UIKit
// present animation을 위한 클래스 오른쪽에서 왼쪽으로 화면이동
class PresentTransition: NSObject {
    var animator:UIViewImplicitlyAnimating?
}

//MARK: - UIViewControllerAnimatedTransitioning
extension PresentTransition:UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let animator = self.interruptibleAnimator(using: transitionContext)
        animator.startAnimation()
    }

    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        if self.animator != nil {
            return self.animator!
        }

        let container = transitionContext.containerView
        let fromVC = transitionContext.viewController(forKey: .from)!

        let fromViewInitialFrame = transitionContext.initialFrame(for: fromVC)
        var fromViewFinalFrame = fromViewInitialFrame
        fromViewFinalFrame.origin.x = -fromViewFinalFrame.width

        let fromView = fromVC.view!
        let toView = transitionContext.view(forKey: .to)!

        var toViewInitialFrame = fromViewInitialFrame
        toViewInitialFrame.origin.x = toView.frame.size.width

        toView.frame = toViewInitialFrame
        container.addSubview(toView)

        let animator = UIViewPropertyAnimator(duration: self.transitionDuration(using: transitionContext), curve: .easeInOut) {

            toView.frame = fromViewInitialFrame
            fromView.frame = fromViewFinalFrame
        }

        animator.addCompletion { _ in
            transitionContext.completeTransition(true)
        }

        self.animator = animator

        return animator
    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        self.animator = nil
    }
}
