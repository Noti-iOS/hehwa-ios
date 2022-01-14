//
//  ChattingVC.swift
//  IOS_Study
//
//  Created by 황윤경 on 2021/12/18.
//

import UIKit

class ChattingVC: UIViewController {
 
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
    
    @objc func addChatting(){
        let addChattingVC = ViewControllerFactory.viewController(for: .addChatting)
        addChattingVC.modalPresentationStyle = .fullScreen
        addChattingVC.modalTransitionStyle = .crossDissolve
        self.present(addChattingVC, animated: true, completion: nil)
    }
    
    func startChatting(){
        let startChattingVC = ViewControllerFactory.viewController(for: .startChatting)
        startChattingVC.modalPresentationStyle = .fullScreen
        self.present(startChattingVC, animated: true, completion: nil)
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
