//
//  LoginVC.swift
//  IOS_Study
//
//

import UIKit
import Alamofire

class LoginVC: UIViewController {
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var googleLogin: UIButton!
    @IBOutlet weak var kakaoLogin: UIButton!
    @IBOutlet weak var appleLogin: UIButton!
    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var inputPassword: UITextField!
    @IBOutlet weak var moveHome: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setDelegate()
        setSocialLoginButton()
        setupAddTargetCheckTextfield()
    }
    
    @IBAction func tapForDissmissKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
    // 임시 탭바 화면 이동
    @IBAction func moveHome(_ sender: Any) {
        let vc = ViewControllerFactory.viewController(for: .tabBar)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func moveSignup(_ sender: Any) {
        let vc = ViewControllerFactory.viewController(for: .signup)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func loginClick(_ sender: Any) {
        guard let email=inputEmail.text, let password=inputPassword.text else {return}
        let login = Login(email:email,password: password)
        // login test
        UserDefaults.standard.set("jwtToken", forKey: "jwtToken")
        NotificationCenter.default.post(name: .authStateDidChange, object: nil)
        //showAlert(title: "로그인 실패", message: "회원정보가 없습니다")
        //LoginAPI.requestLogin(params: login)
        print(login)
    }
    
    @objc func textFieldsIsNotEmpty(sender: UITextField) {
        sender.text = sender.text?.trimmingCharacters(in: .whitespaces)
        guard
            let email = inputEmail.text, !email.isEmpty,
            let password = inputPassword.text, !password.isEmpty
        else {
            self.loginButton.isEnabled = false
            loginButton.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 0.6), for: .normal)
            loginButton.backgroundColor = UIColor(red: 100/255, green: 119/255, blue: 211/255, alpha: 0.6)
            return
        }
        loginButton.isEnabled = true
        loginButton.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        loginButton.backgroundColor = UIColor(red: 100/255, green: 119/255, blue: 211/255, alpha: 1)
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

}

// MARK: - custom Method
extension LoginVC{
    func setDelegate(){
        inputEmail.delegate = self
        inputPassword.delegate = self
    }
    
    func setupAddTargetCheckTextfield () {
        loginButton.isEnabled = false
        inputEmail.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged)
        inputPassword.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged)
    }
    
    func setView () {
        let logoImage = UIImage(named: "Logo")
        logo.image = logoImage
        loginLabel.alpha = 0.5
        loginButton.layer.cornerRadius = 4
        inputEmail.addLeftPadding(width: 10)
        inputEmail.layer.cornerRadius = 4
        inputPassword.addLeftPadding(width: 10)
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
    
    // alert
    func showAlert(title:String, message: String){
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
           
        let okAction: UIAlertAction = UIAlertAction(title: "확인", style: .default) { action in
            self.inputEmail.text = ""
            self.inputPassword.text = ""
            self.inputEmail.becomeFirstResponder()
        }
           alert.addAction(okAction)
           
           self.present(alert, animated: true){
               print("얼럿 화면에 보여짐")
           }
    }
    // function for login
    // validation
    func isValidEmail(email: String?) -> Bool {
              let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
              let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
              return emailTest.evaluate(with: email)
    }
    
    func isValidPasswordLogin(pwd: String?) -> Bool {
        if let hasPassword = pwd {
            if hasPassword.count < 8{
                return false
            }
        }
        return true
    }

    
    func isValidPassword(pwd: String?) -> Bool {
            let passwordRegEx = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,20}"
            let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
            return passwordTest.evaluate(with: pwd)
    }
}

// MARK: function for login
class LoginAPI{
    static let url = "url"
    
    //로그인 요청
    static func requestLogin(params login:Login){
        let headers: HTTPHeaders = []
        // 서버 resonpse 내용에 따라 코드 수정
        AF.request(url, method: .post, parameters: login, encoder: JSONParameterEncoder.default, headers: headers)
            .responseData { response in switch response.result {
            case .success(let data):
                let jwtToken = LoginAPI.parseData(data)
                //자동 로그인을 위한 jwt 저장
                UserDefaults.standard.set(jwtToken, forKey: "jwtToken")
                NotificationCenter.default.post(name: .authStateDidChange, object: nil)
            case.failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    // decode data
    static func parseData(_ data:Data)->String{
        let decoder = JSONDecoder()
        do{
            let response = try decoder.decode(LoginResponse.self, from: data)
            let jwtToken = response.jwtToken
            return jwtToken
        }catch let error{
            print("error--->\(error)")
            return ""
        }
    }
}
