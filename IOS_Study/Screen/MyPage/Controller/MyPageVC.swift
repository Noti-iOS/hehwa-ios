//
//  MyPageVC.swift
//  IOS_Study
//
//  Created by 황윤경 on 2021/12/18.
//

import UIKit
import Photos

class MyPageVC: UIViewController {
    @IBOutlet weak var customNaviBar: CustomNB!
    @IBOutlet weak var profileImg: UIImageView!
    
    var imagePicker:UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNaviBar()
        setUpProfileImg()
    }
}

//MARK: Custom Function
extension MyPageVC {
    // NavigationBar Setting
    func setUpNaviBar() {
        customNaviBar.title = "PROFILE"
        
        customNaviBar.isFirstBtnEnabled = false
        customNaviBar.isSecondBtnEnabled = false
    }
    
    // profileImg Setting
    func setUpProfileImg() {
        profileImg.image = UIImage(named: "SampleProfileImg")
        profileImg.layer.cornerRadius = profileImg.frame.width / 2
        profileImg.clipsToBounds = true
        
        let imgTapGesture = UITapGestureRecognizer(target: self, action: #selector(setProfileImg))
        profileImg.addGestureRecognizer(imgTapGesture)
        profileImg.isUserInteractionEnabled = true
    }
    
    // Gallery Open
    func openGallery() {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    // open Gallery and Select Profile
    @objc func setProfileImg(){
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            // 갤러리 권한 존재, 갤러리로 전환
            openGallery()
        case .notDetermined:
            // 갤러리 권한 요청
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { (status) in }
        default:
            // 갤러리 권한 없음, 설정 화면으로 이동
            let accessConfirmVC = UIAlertController(title: "권한 필요", message: "갤러리 접근 권한이 없습니다. 설정 화면에서 설정해주세요.", preferredStyle: .alert)
            let goSettings = UIAlertAction(title: "설정으로 이동", style: .default) { (action) in
                print("go settings")
                
                if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
                }
            }
            let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            accessConfirmVC.addAction(goSettings)
            accessConfirmVC.addAction(cancel)
            self.present(accessConfirmVC, animated: true, completion: nil)
        }
    }
}

extension MyPageVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var selectedImg: UIImage? = nil
                
        if let possibleImage = info[.editedImage] as? UIImage {
            selectedImg = possibleImage
        } else if let possibleImage = info[.originalImage] as? UIImage {
            selectedImg = possibleImage
        }
        
        profileImg.image = selectedImg
        profileImg.contentMode = .scaleAspectFill
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
