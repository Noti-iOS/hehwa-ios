//
//  CustomSideMenuNC.swift
//  IOS_Study
//
//  Created by 황윤경 on 2022/01/02.
//

import UIKit
import SideMenu

class CustomSideMenuNC: SideMenuNavigationController {
    
    override func viewDidLoad() {
        presentationStyle = .menuSlideIn
        presentationStyle.backgroundColor = .black
        presentationStyle.presentingEndAlpha = 0.3
        menuWidth = view.frame.width - 100
    }
}

