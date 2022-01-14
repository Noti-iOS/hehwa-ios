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
        setupUI()

    }
}

//MARK: custom method
extension ChattingListTVC{
    // cell update
    func update(chattingInfo:ChattingInfo){
        userImage.image = chattingInfo.userImage
        userName.text = chattingInfo.userName
        chattingMessage.text = chattingInfo.chattingMessage
        chattingTime.text = chattingInfo.chattingTime
    }
    
    func setupUI(){
        userImage.layer.cornerRadius = 15
    }
}
