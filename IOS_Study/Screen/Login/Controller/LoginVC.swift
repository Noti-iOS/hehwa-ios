//
//  LoginVC.swift
//  IOS_Study
//
//

import UIKit
import GoogleSignIn
import Alamofire

class LoginVC: UIViewController {
    
    let signInConfig = GIDConfiguration.init(clientID: "375201416995-kfre8b862ibg7f8bekjd80f62kjihbku.apps.googleusercontent.com")
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var googleLoginButton: UIButton!
    @IBOutlet weak var kakaoLoginButton: UIButton!
    @IBOutlet weak var appleLoginButton: UIButton!
    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var inputPassword: UITextField!

    
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
    
    
    @IBAction func moveSignup(_ sender: Any) {
        let vc = ViewControllerFactory.viewController(for: .signup)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func loginClick(_ sender: Any) {
        guard let email=inputEmail.text, let password=inputPassword.text else {return}
        let login = Login(email:email,password: password)
        // login test
        let token = JwtToken(accessToken: "access", refreshToken:"refresh")
        KeychainHelper.standard.save(token, service: "token", account: "student")
        NotificationCenter.default.post(name: .authStateDidChange, object: nil)
        //showAlert(title: "로그인 실패", message: "회원정보가 없습니다")
        //Auth.requestLogin(params: login)
        print(login)
    }
    
    @IBAction func googleLoginButtonClick(_ sender: Any) {
        googleLoginTest()
    }
    
    @IBAction func kakaoLoginButtonClick(_ sender: Any) {
        AppAuth.testKakaoLogin()
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
        googleLoginButton.layer.cornerRadius = 4
        googleLoginButton.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.25)
        googleLoginButton.layer.shadowRadius = 3
        googleLoginButton.layer.shadowOpacity = 0.5
        googleLoginButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        kakaoLoginButton.layer.cornerRadius = 4
        kakaoLoginButton.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.25)
        kakaoLoginButton.layer.shadowRadius = 3
        kakaoLoginButton.layer.shadowOpacity = 0.5
        kakaoLoginButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        appleLoginButton.layer.cornerRadius = 4
        appleLoginButton.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.25)
        appleLoginButton.layer.shadowRadius = 3
        appleLoginButton.layer.shadowOpacity = 0.5
        appleLoginButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        
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
extension LoginVC {
    func googleLoginTest(){
        GIDSignIn.sharedInstance.signIn(with: self.signInConfig, presenting: self) { user, error in
            guard error == nil else { return }
            guard let user = user else { return }
            print(user)
                user.authentication.do { authentication, error in
                    guard error == nil else { return }
                    guard let authentication = authentication else { return }
                    guard let idToken = authentication.idToken else { return }
                    let jwtToken = JwtToken(accessToken: authentication.accessToken, refreshToken: authentication.refreshToken)
                    KeychainHelper.standard.save(jwtToken, service: "token", account: "student")
                    NotificationCenter.default.post(name: .authStateDidChange, object: nil)
                    print(idToken)
                }
        }
    }
    
    func googleLogin(){
        let url = "url"
        GIDSignIn.sharedInstance.signIn(with: self.signInConfig, presenting: self) { user, error in
            guard error == nil else { return }
            guard let user = user else { return }

                user.authentication.do { authentication, error in
                    guard error == nil else { return }
                    guard let authentication = authentication else { return }
                    guard let idToken = authentication.idToken else { return }
                    let headers:HTTPHeaders = [
                        "Authorization" : "Bearer \(idToken)"
                    ]
                    // Send ID token to backend (example below).
                    print(idToken)
                    let param = ["type":"google"]
                    AF.request(url, method: .post, parameters: param, encoder: JSONParameterEncoder.default, headers: headers)
                        .responseData { response in switch response.result {
                        case .success(let data):
                            guard let jwtToken = AppAuth.parseData(data) else { return }
                            //자동 로그인을 위한 jwt 저장
                            KeychainHelper.standard.save(jwtToken, service: "token", account: "student")
                            NotificationCenter.default.post(name: .authStateDidChange, object: nil)
                        case.failure(let error):
                            print("error: \(error)")
                        }
                    }
                }
            // If sign in succeeded, display the app's main content View.
          }
    }
}
