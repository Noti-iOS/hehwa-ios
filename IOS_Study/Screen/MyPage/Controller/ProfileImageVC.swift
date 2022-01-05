//
//  ProfileImageVC.swift
//  IOS_Study
//
//  Created by 황윤경 on 2022/01/06.
//

import UIKit

class ProfileImageVC: UIViewController {
    @IBOutlet weak var profilImg: UIImageView!
    var profileImgTmp: UIImage?
    
    override func viewDidLoad() {
        profilImg.image = profileImgTmp
    }
    @IBAction func dismissView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
