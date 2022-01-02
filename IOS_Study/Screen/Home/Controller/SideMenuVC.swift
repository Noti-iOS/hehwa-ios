//
//  SideMenuVC.swift
//  IOS_Study
//
//  Created by 황윤경 on 2022/01/02.
//

import UIKit

class SideMenuVC: UIViewController {
    @IBOutlet weak var MenuListTV: UITableView!
    
    let menuList = ["버전 정보", "로그아웃", "과외 정보", "회원 정보 수정"]
    let menuIcon = [UIImage(named: "Menu_Version"), UIImage(named: "Menu_Logout"), UIImage(named: "Menu_info"), UIImage(named: "Menu_Setting")]
    
    override func viewDidLoad() {
        setUpView()
        setUpEtcTV()
    }
}
//MARK: Custom Function
extension SideMenuVC {
    func setUpView() {
        view.backgroundColor = .systemGray6
    }
    
    func setUpEtcTV() {
        MenuListTV.dataSource = self
        
        MenuListTV.backgroundColor = .systemGray6
        MenuListTV.isScrollEnabled = false
    }
}

// MARK:UITableViewDataSource
extension SideMenuVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MenuListTV.dequeueReusableCell(withIdentifier: Identifiers.menuListTVC, for: indexPath) as! MenuListTVC
        cell.backgroundColor = .systemGray6
        cell.menuTitle.text = menuList[indexPath.row]
        cell.menuIcon.image = menuIcon[indexPath.row]
        return cell
    }
}
