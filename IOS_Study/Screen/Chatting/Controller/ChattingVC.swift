//
//  ChattingVC.swift
//  IOS_Study
//
//  Created by 황윤경 on 2021/12/18.
//

import UIKit

class ChattingVC: UIViewController {

    @IBOutlet weak var customNaviBar: CustomNB!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNaviBar()
    }
}


//MARK: Custom Method
extension ChattingVC{
    func setUpNaviBar() {
//        customNaviBar.
        customNaviBar.title = "CHATTING"
        
        customNaviBar.firstBtn.setImage(UIImage(named: "Alarm"), for: .normal)
        customNaviBar.secondBtn.setImage(UIImage(named: "ETC"), for: .normal)

    }
}
