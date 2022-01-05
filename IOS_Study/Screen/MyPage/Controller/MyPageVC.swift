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
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var studentPhone: UITextField!
    @IBOutlet weak var school: UITextField!
    @IBOutlet weak var parentsPhone: UITextField!
    
    var imagePicker:UIImagePickerController!
    var isInfoEditing: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNaviBar()
        setUpProfileImg()
        setUpStudentInfo()
    }
}

//MARK: Custom Function
extension MyPageVC {
    // NavigationBar Setting
    func setUpNaviBar() {
        customNaviBar.title = "PROFILE"
        
        customNaviBar.isFirstBtnEnabled = false
        customNaviBar.secondBtn.setImage(UIImage(), for: .normal)
        customNaviBar.secondBtn.setTitle("편집", for: .normal)
        customNaviBar.secondBtn.addTarget(self, action: #selector(editInfo), for: .touchUpInside)
    }
    
    // profileImg Setting
    func setUpProfileImg() {
        profileImg.image = UIImage(named: "SampleProfileImg")
        profileImg.layer.cornerRadius = profileImg.frame.width / 2
        profileImg.clipsToBounds = true
        
        let imgTapGesture = UITapGestureRecognizer(target: self, action: #selector(selectProfile))
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
    
    // 프로필 이미지 눌렀을 때
    @objc func selectProfile() {
        if isInfoEditing {
            setProfileImg()
        } else {
            showProfileImg()
        }
    }
    
    // open Gallery and Select Profile
    func setProfileImg(){
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
    
    // 프로필 이미지 새 뷰에서 보기
    func showProfileImg() {
        guard let profileImgVC = UIStoryboard(name: Identifiers.profileImageSB, bundle: nil).instantiateViewController(withIdentifier:  Identifiers.profileImageVC) as? ProfileImageVC else {return}
        
        profileImgVC.profileImgTmp = profileImg.image
        profileImgVC.modalPresentationStyle = .fullScreen
        present(profileImgVC, animated: true, completion: nil)
    }
    
    // info data Setting
    func setUpStudentInfo() {
        isInfoEditing = false
        
        name.text = "황윤경"
        email.text = "hyk0425@gmail.com"
        
        studentPhone.text = "010-5585-4034"
        studentPhone.textColor = .systemGray
        studentPhone.isEnabled = false
        
        school.text = "서울사대부고등학교"
        school.textColor = .systemGray
        school.isEnabled = false
        
        parentsPhone.text = "010-8701-4034"
        parentsPhone.textColor = .systemGray
        parentsPhone.isEnabled = false
    }
    
    // info data Edit
    @objc func editInfo() {
        isInfoEditing.toggle()
        
        if isInfoEditing {
            customNaviBar.secondBtn.setTitle("완료", for: .normal)
            
            studentPhone.isEnabled = true
            school.isEnabled = true
            parentsPhone.isEnabled = true
            
            studentPhone.textColor = .systemGray3
            school.textColor = .systemGray3
            parentsPhone.textColor = .systemGray3
        } else {
            customNaviBar.secondBtn.setTitle("편집", for: .normal)
            
            studentPhone.isEnabled = false
            school.isEnabled = false
            parentsPhone.isEnabled = false
            
            studentPhone.textColor = .systemGray
            school.textColor = .systemGray
            parentsPhone.textColor = .systemGray
        }
    }
}

//MARK: UIImagePickerControllerDelegate, UINavigationControllerDelegate
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
