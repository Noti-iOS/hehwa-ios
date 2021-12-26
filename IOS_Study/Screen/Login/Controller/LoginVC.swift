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
        setSocialLoginButton()
    }
    @IBAction func moveHome(_ sender: Any) {
    }
}

// MARK: - custom Method
extension LoginVC{
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
        googleLogin.layer.shadowOpacity = 0.7
        googleLogin.layer.shadowOffset = CGSize(width: 0, height: 1)
        kakaoLogin.layer.cornerRadius = 4
        kakaoLogin.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.25)
        kakaoLogin.layer.shadowRadius = 3
        kakaoLogin.layer.shadowOpacity = 0.7
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
