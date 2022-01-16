//
//  AddChattingVC.swift
//  IOS_Study
//
//  Created by ho jun lim on 2022/01/14.
//

import UIKit

class AddChattingVC: UIViewController {
    
    let chattingList = [ChattingInfo(userImage: UIImage(named: "SampleProfileImg")!, userName: "hojoon", chattingMessage: "hi", chattingTime: "오후 1:30"),
                        ChattingInfo(userImage: UIImage(named: "SampleProfileImg")!, userName: "hojoon", chattingMessage: "hi", chattingTime: "오후 1:30"),
                        ChattingInfo(userImage: UIImage(named: "SampleProfileImg")!, userName: "hojoon", chattingMessage: "hi", chattingTime: "오후 1:30"),
                        ChattingInfo(userImage: UIImage(named: "SampleProfileImg")!, userName: "hojoon", chattingMessage: "hi", chattingTime: "오후 1:30"),
                        ChattingInfo(userImage: UIImage(named: "SampleProfileImg")!, userName: "hojoon", chattingMessage: "hi", chattingTime: "오후 1:30"),
                        ChattingInfo(userImage: UIImage(named: "SampleProfileImg")!, userName: "hojoon", chattingMessage: "hi", chattingTime: "오후 1:30"),
                        ChattingInfo(userImage: UIImage(named: "SampleProfileImg")!, userName: "hojoon", chattingMessage: "hi", chattingTime: "오후 1:30")
    ]

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var userTV: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSearchBar()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
//MARK: - Custom Method
extension AddChattingVC{
    func setupUI(){
        searchTextField.layer.cornerRadius = 10
        searchTextField.addLeftPadding(width: 10)
        
    }
    
    func setupSearchBar(){
        searchBar.delegate = self
        searchBar.clipsToBounds = true
        searchBar.placeholder = "이름 검색"
        searchBar.setImage(UIImage(), for: .search, state: .normal)
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.attributedPlaceholder = NSAttributedString(string: textfield.placeholder ?? "", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),                           NSAttributedString.Key.foregroundColor:UIColor.systemGray])
            textfield.font = UIFont.systemFont(ofSize: 15)
        }
    }
}
//MARK: - UITextFieldDelegate
extension AddChattingVC:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
