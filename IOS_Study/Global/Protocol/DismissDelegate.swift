//
//  DismissDelegate.swift
//  IOS_Study
//
//  Created by ho jun lim on 2022/01/17.
//

import UIKit

// vc1-> vc2로 모달 이동후 vc2->vc1로 dissmiss 후 -> vc3로 nagivation push 이동
// 위의 예시말고도 다양한 이동 가능
protocol DismissDelegate: class {
    func dismissViewController(_ controller: UIViewController)
}
