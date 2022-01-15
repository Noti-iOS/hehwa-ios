//
//  UINavigationController+.swift
//  IOS_Study
//
//  Created by ho jun lim on 2022/01/15.
//

import Foundation
import UIKit

extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
    // 기본 네비바를 숨기면 swipe back 기능이 멈춤 popGesture delegate를 설정
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    // 쌓인 스텍이 1개 초과일때 제스처 작동
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
