//
//  SideMenuVC.swift
//  IOS_Study
//
//  Created by 황윤경 on 2022/01/02.
//

import UIKit

class SideMenuVC: UIViewController {
    @IBOutlet weak var etcTV: UITableView!
    
    override func viewDidLoad() {
        view.backgroundColor = .systemGray6
        etcTV.dataSource = self
        etcTV.backgroundColor = .systemGray6
        etcTV.isScrollEnabled = false
    }
}
// MARK:UITableViewDataSource
extension SideMenuVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = etcTV.dequeueReusableCell(withIdentifier: Identifiers.etcTVC, for: indexPath)
        cell.backgroundColor = .systemGray6
        cell.widthAnchor.constraint(equalToConstant: etcTV.frame.width).isActive = true
        return cell
    }
}
