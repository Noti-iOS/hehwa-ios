//
//  SubjectCVC.swift
//  IOS_Study
//
//  Created by 황윤경 on 2021/12/20.
//

import UIKit

class SubjectListCVC: UICollectionViewCell {
    @IBOutlet weak var subjectName: UILabel!
    @IBOutlet weak var teacher: UILabel!
    @IBOutlet weak var homeworkListTV: UITableView!
    @IBOutlet weak var homeworkListHeight: NSLayoutConstraint!
    
    var homeworkContents:Array<String> = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setHomeworkListTV()
    }
}

//MARK: Custom Function
extension SubjectListCVC {
    func setHomeworkListTV() {
        homeworkListTV.dataSource = self
        homeworkListTV.delegate = self
        
        homeworkListTV.layer.cornerRadius = 10
        homeworkListTV.backgroundColor = .systemGray6

        homeworkListTV.allowsSelection = false
        homeworkListTV.isScrollEnabled = false
    }
}
//MARK: UITableViewDataSource
extension SubjectListCVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeworkContents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeworkListTV.dequeueReusableCell(withIdentifier: Identifiers.homeworkListTVC, for: indexPath) as! HomeworkListTVC
        cell.homeworkContents.text = homeworkContents[indexPath.row]
        return cell
    }
}

//MARK: UITableViewDelegate
extension SubjectListCVC: UITableViewDelegate {

}
