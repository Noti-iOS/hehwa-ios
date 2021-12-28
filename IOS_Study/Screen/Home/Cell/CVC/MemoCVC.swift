//
//  MemoCVC.swift
//  IOS_Study
//
//  Created by 황윤경 on 2021/12/20.
//

import UIKit

class MemoCVC: UICollectionViewCell {
    @IBOutlet weak var memoTF: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setMemoCell()
    }
}
//MARK: Custom Function
extension MemoCVC {
    func setMemoCell() {
        memoTF.addPadding()
        memoTF.text = ""
        memoTF.backgroundColor = .systemGray6
        memoTF.layer.cornerRadius = 10
        memoTF.isScrollEnabled = false
        memoTF.heightAnchor.constraint(equalToConstant: 130).isActive = true
    }
}
