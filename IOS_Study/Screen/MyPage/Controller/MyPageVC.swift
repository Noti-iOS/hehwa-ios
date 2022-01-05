//
//  MyPageVC.swift
//  IOS_Study
//
//  Created by 황윤경 on 2021/12/18.
//

import UIKit

class MyPageVC: UIViewController {
    @IBOutlet weak var customNaviBar: CustomNB!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNaviBar()
    }
}

//MARK: Custom Function
extension MyPageVC {
    // NavigationBar Setting
    func setUpNaviBar() {
        customNaviBar.title = "PROFILE"
        
        customNaviBar.isFirstBtnEnabled = false
        customNaviBar.isSecondBtnEnabled = false
    }
}
