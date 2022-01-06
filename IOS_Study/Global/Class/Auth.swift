//
//  Auth.swift
//  IOS_Study
//
//  Created by ho jun lim on 2022/01/04.
//

import Foundation
import Alamofire
import KakaoSDKAuth
import KakaoSDKUser

class Auth {
    static let url = "url"
    
    //로그인 요청
    static func Login(params login:Login){
        let headers: HTTPHeaders = []
        // 서버 resonpse 내용에 따라 코드 수정
        AF.request(url, method: .post, parameters: login, encoder: JSONParameterEncoder.default, headers: headers)
            .responseData { response in switch response.result {
            case .success(let data):
                guard let jwtToken = Auth.parseData(data) else { return }
                //자동 로그인을 위한 jwt 저장
                KeychainHelper.standard.save(jwtToken, service: "token", account: "student")
                NotificationCenter.default.post(name: .authStateDidChange, object: nil)
            case.failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    // decode data 추후에 삭제 될 수도 있음.
    static func parseData(_ data:Data)->JwtToken?{
        let decoder = JSONDecoder()
        do{
            let response = try decoder.decode(LoginResponse.self, from: data)
            let jwtToken = response.jwtToken
            return jwtToken
        }catch let error{
            print("error--->\(error)")
            return nil
        }
    }
    
    static func logout(){
        KeychainHelper.standard.delete(service: "token", account: "student")
        NotificationCenter.default.post(name: .authStateDidChange, object: nil)
    }
    
    static func kakaoLogin(){
        let kakaoLoginUrl = "url"
        let headers: HTTPHeaders = []
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                print("loginWithKakaoTalk() success.")
                guard let token = oauthToken else {return}
                print(token)
                let param = ["accessToken":token.accessToken]
                AF.request(kakaoLoginUrl, method: .post, parameters: param, encoder: JSONParameterEncoder.default, headers: headers)
                    .responseData { response in switch response.result {
                    case .success(let data):
                        guard let jwtToken = Auth.parseData(data) else { return }
                        //자동 로그인을 위한 jwt 저장
                        KeychainHelper.standard.save(jwtToken, service: "token", account: "student")
                        NotificationCenter.default.post(name: .authStateDidChange, object: nil)
                    case.failure(let error):
                        print("error: \(error)")
                    }
                }
            }
        }
        else {
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                print("loginWithKakaoAccount() success.")
                //do something
                guard let token = oauthToken else {return}
                print(token)
                let param = ["accessToken":token.accessToken]
                AF.request(kakaoLoginUrl, method: .post, parameters: param, encoder: JSONParameterEncoder.default, headers: headers)
                    .responseData { response in switch response.result {
                    case .success(let data):
                        guard let jwtToken = Auth.parseData(data) else { return }
                        //자동 로그인을 위한 jwt 저장
                        KeychainHelper.standard.save(jwtToken, service: "token", account: "student")
                        NotificationCenter.default.post(name: .authStateDidChange, object: nil)
                    case.failure(let error):
                        print("error: \(error)")
                    }
                }
            }
        }
    }
    
    static func testKakaoLogin(){
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                print("loginWithKakaoTalk() success.")
                guard let token = oauthToken else {return}
                let jwtToken = JwtToken(accessToken: token.accessToken, refreshToken: token.refreshToken)
                KeychainHelper.standard.save(jwtToken, service: "token", account: "student")
                NotificationCenter.default.post(name: .authStateDidChange, object: nil)
                print(token)
            }
        }
        else {
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                print("loginWithKakaoAccount() success.")
                //do something
                guard let token = oauthToken else {return}
                let jwtToken = JwtToken(accessToken: token.accessToken, refreshToken: token.refreshToken)
                KeychainHelper.standard.save(jwtToken, service: "token", account: "student")
                NotificationCenter.default.post(name: .authStateDidChange, object: nil)
                print(token)
            }
        }
    }
}

