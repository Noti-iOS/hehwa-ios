//
//  SideMenuVC.swift
//  IOS_Study
//
//  Created by 황윤경 on 2022/01/02.
//

import UIKit

class SideMenuVC: UIViewController {
    @IBOutlet weak var menuListTV: UITableView!
    
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
        menuListTV.dataSource = self
        menuListTV.delegate = self
        
        menuListTV.backgroundColor = .systemGray6
        menuListTV.isScrollEnabled = false
    }
}

// MARK: UITableViewDataSource
extension SideMenuVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = menuListTV.dequeueReusableCell(withIdentifier: Identifiers.menuListTVC, for: indexPath) as! MenuListTVC
        cell.backgroundColor = .systemGray6
        cell.menuTitle.text = menuList[indexPath.row]
        cell.menuIcon.image = menuIcon[indexPath.row]
        return cell
    }
}

// MARK: UITableViewDelegate
extension SideMenuVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 선택 후 해제
        menuListTV.deselectRow(at: indexPath, animated: false)
        
        // cell에 맞는 Action
        switch indexPath.row {
        case 0:
            print("버전 정보")
        case 1:
            let logoutAC = UIAlertController(title: "", message: "로그아웃 하시겠습니까?", preferredStyle: .alert)
            logoutAC.view.tintColor = .label
            let logout = UIAlertAction(title: "로그아웃", style: .destructive) { (action) in
                print("로그아웃")
                Auth.logout()
            }
            let cancel = UIAlertAction(title: "취소", style: .cancel) { action -> Void in }

            logoutAC.addAction(logout)
            logoutAC.addAction(cancel)

            present(logoutAC, animated: true, completion: nil)
        case 2:
            print("과외 정보")
        case 3:
            print("회원 정보 수정")
        default:
            return
        }
    }
}
