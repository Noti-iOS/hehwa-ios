//
//  AddChattingTVC.swift
//  IOS_Study
//
//  Created by ho jun lim on 2022/01/16.
//

import UIKit

class AddChattingTVC: UITableViewCell {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
// MARK: - Custom Method
extension AddChattingTVC{
    func setupCell(){
        userImage.layer.cornerRadius = 10
        // cell 클릭시 background color 설정
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(named: "CfColor")
        self.selectedBackgroundView = backgroundView
    }
    func update(userInfo:ChattingInfo){
        userImage.image = userInfo.userImage
        username.text = userInfo.userName
    }
}
