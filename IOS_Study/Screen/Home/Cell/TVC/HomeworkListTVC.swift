//
//  HomeworkListTVC.swift
//  IOS_Study
//
//  Created by 황윤경 on 2021/12/20.
//

import UIKit

class HomeworkListTVC : UITableViewCell {
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var homeworkContents: UILabel!
    
    @IBAction func checkHomework(_ sender: Any) {
        if checkBtn.imageView?.image == UIImage(named: "CheckBox_Selected") {
            checkBtn.setImage(UIImage(named: "CheckBox_UnSelected"), for: .normal)
        } else {
            checkBtn.setImage(UIImage(named: "CheckBox_Selected"), for: .normal)
        }
    }
}
//MARK: Custom Function
extension HomeworkListTVC {
    func setHomeworkListCell() {
        self.backgroundColor = .systemGray6
    }
}
