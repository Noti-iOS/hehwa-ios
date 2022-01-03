//
//  Notification+.swift
//  IOS_Study
//
//  Created by ho jun lim on 2022/01/03.
//

import Foundation

// MARK: 로그인 상태 변경 noti 확인을 위해 이름 추가
extension Notification.Name {
    static let authStateDidChange = NSNotification.Name("authStateDidChange")
}
