//
//  UITextView+.swift
//  IOS_Study
//
//  Created by 황윤경 on 2021/12/27.
//

import UIKit
extension UITextView {
    /// addLeftPadding - TextView에서 상하좌우 여백을 주는 함수
    func addPadding() {
        self.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10);
    }
}
