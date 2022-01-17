//
//  AddChattingVC.swift
//  IOS_Study
//
//  Created by ho jun lim on 2022/01/14.
//

import UIKit

class AddChattingVC: UIViewController {
    //기본 유저 목록
    var users = [ChattingInfo(userImage: UIImage(named: "SampleProfileImg")!, userName: "신성용", chattingMessage: "hi", chattingTime: "오후 1:30"),
                        ChattingInfo(userImage: UIImage(named: "SampleProfileImg")!, userName: "임호준", chattingMessage: "hi", chattingTime: "오후 1:30"),
                        ChattingInfo(userImage: UIImage(named: "SampleProfileImg")!, userName: "김강록", chattingMessage: "hi", chattingTime: "오후 1:30"),
                        ChattingInfo(userImage: UIImage(named: "SampleProfileImg")!, userName: "이상호", chattingMessage: "hi", chattingTime: "오후 1:30"),
                        ChattingInfo(userImage: UIImage(named: "SampleProfileImg")!, userName: "백은희", chattingMessage: "hi", chattingTime: "오후 1:30"),
                        ChattingInfo(userImage: UIImage(named: "SampleProfileImg")!, userName: "황윤경", chattingMessage: "hi", chattingTime: "오후 1:30"),
                        ChattingInfo(userImage: UIImage(named: "SampleProfileImg")!, userName: "나이스", chattingMessage: "hi", chattingTime: "오후 1:30"),
                 ChattingInfo(userImage: UIImage(named: "SampleProfileImg")!, userName: "임효준", chattingMessage: "hi", chattingTime: "오후 1:30"),
                 ChattingInfo(userImage: UIImage(named: "SampleProfileImg")!, userName: "김강성", chattingMessage: "hi", chattingTime: "오후 1:30"),
                 ChattingInfo(userImage: UIImage(named: "SampleProfileImg")!, userName: "hojjon", chattingMessage: "hi", chattingTime: "오후 1:30"),
                 ChattingInfo(userImage: UIImage(named: "SampleProfileImg")!, userName: "hee", chattingMessage: "hi", chattingTime: "오후 1:30")
    ].sorted{$0.userName < $1.userName}
    // 검색시 필터링 되는 유저
    var filteredUser:[ChattingInfo]!
    
    //dimiss delegate
    var delegate : DismissDelegate!
    var isSelected:Bool = false
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var userTV: UITableView!
    @IBOutlet weak var okButton: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSearchBar()
        setupTV()
        // Do any additional setup after loading the view.
    }
    
// 화면 이동 기능 구현중...
    @IBAction func tapFunction(sender: UITapGestureRecognizer) {
        //self.delegate = ChattingVC
        if self.delegate != nil {
            //ChattingVC의 dismissViewController가 실행되고 매개변수로 AddChattingVC가 넘어간다.
            self.delegate.dismissViewController(self)
        }
       
    }
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
//MARK: - Custom Method
extension AddChattingVC{
    func setupUI(){
        okButton.isEnabled = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(AddChattingVC.tapFunction))
        okButton.isUserInteractionEnabled = false
        okButton.addGestureRecognizer(tap)
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
    
    func setupTV(){
        userTV.delegate = self
        userTV.dataSource = self
        userTV.keyboardDismissMode = .onDrag
        filteredUser = users
    }
}

//MARK: - UISearchBarDelegate
extension AddChattingVC:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        //searchtext가 없으면 기존 유저 정보를 보여주고 있으면 필터링
        filteredUser = searchText.isEmpty ? users : users.filter({ user in
            return user.userName.range(of: searchText, options:.caseInsensitive) != nil
        }).sorted{$0.userName < $1.userName}
        okButton.isEnabled = false
        okButton.isUserInteractionEnabled = false
        // reload tableview
        userTV.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

//MARK: - UITableViewDelegate
extension AddChattingVC:UITableViewDelegate{
    // 셀 선택되어있을때 클릭하면 선택해제
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow,
                indexPathForSelectedRow == indexPath {
                tableView.deselectRow(at: indexPath, animated: false)
            okButton.isEnabled = false
            okButton.isUserInteractionEnabled = false
                return nil
            }
        okButton.isEnabled = true
        okButton.isUserInteractionEnabled = true
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }
}

//MARK: - UITableViewDataSource
extension AddChattingVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.addChattingTVC, for: indexPath) as? AddChattingTVC else {
            return UITableViewCell()
        }
        cell.update(userInfo: filteredUser[indexPath.row])
        return cell
    }
}
