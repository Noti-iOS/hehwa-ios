//
//  AllSubjectsDataTVC.swift
//  IOS_Study
//
//  Created by 황윤경 on 2022/01/07.
//

import UIKit

class AllSubjectsDataTVC: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var percent: UILabel!
    @IBOutlet weak var isDone: UISegmentedControl!
    @IBOutlet weak var dataList: UITableView!
    
    override func awakeFromNib() {
        setdataListCell()
    }
}
//MARK: Custom Function
extension AllSubjectsDataTVC {
    func setdataListCell() {
        dataList.dataSource = self
        dataList.delegate = self
        
        dataList.layer.cornerRadius = 10
        dataList.backgroundColor = .systemGray6
        dataList.bounces = false
    }
}
//MARK: UITableViewDataSource
extension AllSubjectsDataTVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dataList.dequeueReusableCell(withIdentifier: "HomeworkList", for: indexPath)
        cell.backgroundColor = .clear
        
        return cell
    }
}
//MARK: UITableViewDelegate
extension AllSubjectsDataTVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataList.deselectRow(at: indexPath, animated: false)
    }
}
