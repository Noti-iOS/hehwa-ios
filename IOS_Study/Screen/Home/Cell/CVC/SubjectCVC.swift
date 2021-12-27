//
//  SubjectCVC.swift
//  IOS_Study
//
//  Created by 황윤경 on 2021/12/20.
//

import UIKit

class SubjectCVC: UICollectionViewCell {
    @IBOutlet weak var homeworkListTV: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setSubjectCell()
        setHomeworkListTV()
    }
}
//MARK: Custom Function
extension SubjectCVC {
    func setSubjectCell() {
        
    }
    
    func setHomeworkListTV() {
        homeworkListTV.dataSource = self
        homeworkListTV.layer.cornerRadius = 10
        homeworkListTV.backgroundColor = .systemGray6
        homeworkListTV.heightAnchor.constraint(equalToConstant: 130).isActive = true

        homeworkListTV.allowsSelection = false
        homeworkListTV.isScrollEnabled = false
        
        // tableview의 높이 = cell의 개수 * cell의 높이(45)
//        homeworkListTV.heightAnchor.constraint(equalToConstant: 4 * 45).isActive = true
    }
}
//MARK: UITableViewDataSource
extension SubjectCVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeworkListTV.dequeueReusableCell(withIdentifier: Identifiers.homeworkTVC, for: indexPath)
        return cell
    }
}
