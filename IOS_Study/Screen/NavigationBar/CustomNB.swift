//
//  CustomNB.swift
//  IOS_Study
//
//  Created by 황윤경 on 2022/01/03.
//

import UIKit

class CustomNB: UIView {
    private static let NIB_NAME = "CustomNB"
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var naviTitle: UILabel!
    @IBOutlet weak var seperateBar: UIView!
    @IBOutlet weak var firstBtn: UIButton!
    @IBOutlet weak var secondBtn: UIButton!
    
    // navigationBar title Setting
    var title: String = "" {
        didSet {
            naviTitle.text = title
        }
    }
    
    // 첫번째 버튼(왼쪽)이 있는가
    // 없을 경우: isFirstBtnEnabled = false
    var isFirstBtnEnabled: Bool {
        set {
            firstBtn.setImage(UIImage(), for: .normal)
            firstBtn.isEnabled = false
        }
        get {
            return firstBtn.isEnabled
        }
    }
    
    // 두번째 버튼(오른쪽)이 있는가
    var isSecondBtnEnabled: Bool {
        set {
            secondBtn.setImage(UIImage(), for: .normal)
            secondBtn.isEnabled = false
        }
        get {
            return secondBtn.isEnabled
        }
    }
    
    // awakeFromNib
    override func awakeFromNib() {
        initWithNib()
    }
    
    private func initWithNib() {
        Bundle.main.loadNibNamed(CustomNB.NIB_NAME, owner: self, options: nil)
        addSubview(view)
        setupLayout()
        setUpView()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate(
            [
                view.topAnchor.constraint(equalTo: topAnchor),
                view.leadingAnchor.constraint(equalTo: leadingAnchor),
                view.bottomAnchor.constraint(equalTo: bottomAnchor),
                view.trailingAnchor.constraint(equalTo: trailingAnchor),
            ]
        )
    }
    
    private func setUpView() {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        
        seperateBar.backgroundColor = .systemGray3
    }
}
