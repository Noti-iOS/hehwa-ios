//
//  ChattingListTVC.swift
//  IOS_Study
//
//  Created by ho jun lim on 2022/01/14.
//

import UIKit

class ChattingListTVC: UITableViewCell {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var chattingMessage: UILabel!
    @IBOutlet weak var chattingTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()

    }
}

//MARK: - custom method
extension ChattingListTVC{
    // cell update
    func update(chattingInfo:ChattingInfo){
        userImage.image = chattingInfo.userImage
        userName.text = chattingInfo.userName
        chattingMessage.text = chattingInfo.chattingMessage
        chattingTime.text = chattingInfo.chattingTime
    }
    
    func setupCell(){
        userImage.layer.cornerRadius = 15
        // cell 클릭시 background color 설정
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(named: "CfColor")
        self.selectedBackgroundView = backgroundView
    }
}
