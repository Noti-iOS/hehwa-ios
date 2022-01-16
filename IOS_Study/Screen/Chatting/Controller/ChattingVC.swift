//
//  ChattingVC.swift
//  IOS_Study
//
//  Created by ho jun lim on 2022/01/15.
//

import UIKit
import CoreMIDI

class ChattingVC: UIViewController {
    // animator 선언
    let chattingList = [ChattingInfo(userImage: UIImage(named: "SampleProfileImg")!, userName: "hojoon", chattingMessage: "hi", chattingTime: "오후 1:30"),
                        ChattingInfo(userImage: UIImage(named: "SampleProfileImg")!, userName: "hojoon", chattingMessage: "hi", chattingTime: "오후 1:30"),
                        ChattingInfo(userImage: UIImage(named: "SampleProfileImg")!, userName: "hojoon", chattingMessage: "hi", chattingTime: "오후 1:30"),
                        ChattingInfo(userImage: UIImage(named: "SampleProfileImg")!, userName: "hojoon", chattingMessage: "hi", chattingTime: "오후 1:30"),
                        ChattingInfo(userImage: UIImage(named: "SampleProfileImg")!, userName: "hojoon", chattingMessage: "hi", chattingTime: "오후 1:30"),
                        ChattingInfo(userImage: UIImage(named: "SampleProfileImg")!, userName: "hojoon", chattingMessage: "hi", chattingTime: "오후 1:30")
    ]

    @IBOutlet weak var customNaviBar: CustomNB!
    @IBOutlet weak var chattingListTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNaviBar()
        setupTV()
        setupNavi()
    }
}


//MARK: Custom Method
extension ChattingVC{
    func setupNaviBar() {
//        customNaviBar.
        customNaviBar.title = "CHATTING"
        customNaviBar.isFirstBtnEnabled = false
        customNaviBar.secondBtn.setImage(UIImage(named: "Add_Circle"), for: .normal)
        customNaviBar.secondBtn.addTarget(self, action: #selector(addChatting), for: .touchUpInside)
    }
    
    func setupTV(){
        chattingListTV.delegate = self
        chattingListTV.dataSource = self
    }
    
    func setupNavi(){
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @objc func addChatting(){
        let addChattingVC = ViewControllerFactory.viewController(for: .addChatting) as? AddChattingVC
        addChattingVC?.modalPresentationStyle = .fullScreen
        //addChatting에 선언된 delegate에 ChattingVC를 할당해준다.
        addChattingVC?.delegate = self
        self.present(addChattingVC! , animated: true, completion: nil)
//        self.navigationController?.pushViewController(addChattingVC, animated: true)
    }
    
    func startChatting(){
        guard let startChattingVC = ViewControllerFactory.viewController(for: .startChatting) as? StartChattingVC else {return}
        // 채팅 시작시 탭바를 숨김
        startChattingVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(startChattingVC, animated: true)
        print("ddfd")
    }
}

//MARK: - UITableViewDelegate
extension ChattingVC:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // cell 선택 후 해제
        chattingListTV.deselectRow(at: indexPath, animated: true)
        // cell 선택시 채팅 시작
        startChatting()
    }
}

//MARK: - UITableViewDataSource
extension ChattingVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chattingList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.chattingListTVC, for: indexPath) as? ChattingListTVC else {
            return UITableViewCell()
        }
        cell.update(chattingInfo: chattingList[indexPath.row])
        return cell
    }
}

//MARK: - DismissDelegate
extension ChattingVC:DismissDelegate{
    func dismissViewController(_ controller: UIViewController) {
        controller.dismiss(animated: true, completion: {()->Void in
            guard let startChattingVC = ViewControllerFactory.viewController(for: .startChatting) as? StartChattingVC else {return}
            // 채팅 시작시 탭바를 숨김
            startChattingVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(startChattingVC, animated: false)
            print("ddfd")
        })
    }
}
