//
//  MainTBC.swift
//  IOS_Study
//
//  Created by 황윤경 on 2021/12/18.
//

import UIKit

class MainTBC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
    }
    
    //MARK: - Custom Method
    /// makeTabVC - 탭별 아이템 생성하는 함수
    func makeTabVC(vcType: TypeOfViewController, tabBarTitle: String, tabBarImage: String, tabBarSelectedImage: String) -> UIViewController {
        
        let tab = ViewControllerFactory.viewController(for: vcType)
        tab.tabBarItem = UITabBarItem(title: tabBarTitle, image: UIImage(named: tabBarImage), selectedImage: UIImage(named: tabBarSelectedImage))
        tab.tabBarItem.imageInsets = UIEdgeInsets(top: -0.5, left: -0.5, bottom: -0.5, right: -0.5)
        return tab
    }
    
    /// setTabBar - 탭바 Setting
    func setTabBar() {
        
        let homeTab = makeTabVC(vcType: .home, tabBarTitle: "Home", tabBarImage: "Home", tabBarSelectedImage: "Home")
        let chattingTab = makeTabVC(vcType: .chatting, tabBarTitle: "Chat", tabBarImage: "Chat", tabBarSelectedImage: "Chat")
        let mypageTab = makeTabVC(vcType: .myPage, tabBarTitle: "MyPage", tabBarImage: "MyPage", tabBarSelectedImage: "MyPage")
        
        // 탭바 스타일 설정
        tabBar.frame.size.height = 84
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .lightGray
        
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 2
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.3

        tabBar.backgroundColor = .white
        tabBar.isTranslucent = false
        
        // 탭 구성
        let tabs =  [homeTab, chattingTab, mypageTab]
        
        // VC에 루트로 설정
        self.setViewControllers(tabs, animated: false)
    }
}
