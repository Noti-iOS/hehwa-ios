//
//  MyPageVC.swift
//  IOS_Study
//
//  Created by 황윤경 on 2021/12/18.
//

import UIKit
import Photos

class MyPageVC: UIViewController {
    let subjects = [
        Subjects("수학", "윤경T", ["쎈 수학 p110~120", "곱셈공식 암기"]),
        Subjects("영어", "호준T", ["단어 Day 7 암기", "영어 문법(초록책) p20~24", "수능특강 p11~14"]),
        Subjects("과학", "은희T", ["p51~60", "주기율표 암기"])
    ]
    var isopened = [false, false, false]
    
    @IBOutlet weak var customNaviBar: CustomNB!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var studentPhone: UITextField!
    @IBOutlet weak var school: UITextField!
    @IBOutlet weak var parentsPhone: UITextField!
    
    @IBOutlet weak var subjectsListTV: UITableView!
    
    var imagePicker:UIImagePickerController!
    var isInfoEditing: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNaviBar()
        setUpProfileImg()
        setUpStudentInfo()
        
        subjectsListTV.dataSource = self
        subjectsListTV.delegate = self
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
            let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let goGallery = UIAlertAction(title: "갤러리로 이동", style: .default) { action -> Void in
                self.openGallery()
            }

            let setDefaultImg = UIAlertAction(title: "기본 이미지로 변경", style: .default) { action -> Void in
                self.profileImg.image = UIImage(named: "SampleProfileImg")
            }
            let cancelAction = UIAlertAction(title: "취소", style: .cancel) { action -> Void in }
            
            actionSheetController.addAction(goGallery)
            actionSheetController.addAction(setDefaultImg)
            actionSheetController.addAction(cancelAction)
            
            present(actionSheetController, animated: true, completion: nil)
            
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

extension MyPageVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // 과목 수
        return subjects.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isopened[section] {
            return 2 + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let sectionCell = subjectsListTV.dequeueReusableCell(withIdentifier: Identifiers.subjectTVC, for: indexPath) as! SubjectTVC
            
            sectionCell.subjectName.text = subjects[indexPath.section].subjectName
            
            return sectionCell
        } else {
            let cell = subjectsListTV.dequeueReusableCell(withIdentifier: "HomeworkTVC", for: indexPath)
            return cell
        }
    }
}

extension MyPageVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            isopened[indexPath.section].toggle()
            
            subjectsListTV.reloadSections([indexPath.section], with: .none)
        }
    }
}
