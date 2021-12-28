//
//  LoginVC.swift
//  IOS_Study
//
//

import UIKit

class LoginVC: UIViewController {
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var googleLogin: UIButton!
    @IBOutlet weak var kakaoLogin: UIButton!
    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var inputPassword: UITextField!
    @IBOutlet weak var moveHome: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setDelegate()
        setSocialLoginButton()
    }
    
    // 임시 탭바 화면 이동
    @IBAction func moveHome(_ sender: Any) {
        let vc = ViewControllerFactory.viewController(for: .tabBar)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
}

extension LoginVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 100/255, green: 119/255, blue: 211/255, alpha: 1).cgColor
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.layer.borderWidth = 0
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //email field에서 리턴키룰 누르면 password field로 포커스 이동
        if (textField.isEqual(inputEmail)){
            print("input email")
            inputPassword.becomeFirstResponder()
        }
        // 리턴 버튼을 누르면 키보드 사라짐
        textField.resignFirstResponder()
        return true
    }
    
    func endEdit(){
        inputPassword.resignFirstResponder()
    }
}

// MARK: - custom Method
extension LoginVC{
    func setDelegate(){
        inputEmail.delegate = self
        inputPassword.delegate = self
    }
    
    func setView () {
        let logoImage = UIImage(named: "Logo")
        logo.image = logoImage
        loginLabel.alpha = 0.5
        loginButton.layer.cornerRadius = 4
        inputEmail.addLeftPadding()
        inputEmail.layer.cornerRadius = 4
        inputPassword.addLeftPadding()
        inputPassword.layer.cornerRadius = 4
    }
    
    // 소셜 로그인 버튼 그림자 추가
    func setSocialLoginButton () {
        googleLogin.layer.cornerRadius = 4
        googleLogin.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.25)
        googleLogin.layer.shadowRadius = 3
        googleLogin.layer.shadowOpacity = 0.5
        googleLogin.layer.shadowOffset = CGSize(width: 0, height: 1)
        kakaoLogin.layer.cornerRadius = 4
        kakaoLogin.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.25)
        kakaoLogin.layer.shadowRadius = 3
        kakaoLogin.layer.shadowOpacity = 0.5
        kakaoLogin.layer.shadowOffset = CGSize(width: 0, height: 1)
    }
}

// MARK: - Custom Method
extension UITextField {
    func addLeftPadding() {
        // text 입력 부분 왼쪽 패딩을 위한 함수
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
