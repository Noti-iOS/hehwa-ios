//
//  Auth.swift
//  IOS_Study
//
//  Created by ho jun lim on 2022/01/04.
//

import Foundation
import Alamofire

class Auth {
    static let url = "url"
    
    //로그인 요청
    static func Login(params login:Login){
        let headers: HTTPHeaders = []
        // 서버 resonpse 내용에 따라 코드 수정
        AF.request(url, method: .post, parameters: login, encoder: JSONParameterEncoder.default, headers: headers)
            .responseData { response in switch response.result {
            case .success(let data):
                let jwtToken = Auth.parseData(data)
                //자동 로그인을 위한 jwt 저장
                UserDefaults.standard.set(jwtToken, forKey: "jwtToken")
                NotificationCenter.default.post(name: .authStateDidChange, object: nil)
            case.failure(let error):
                print("error: \(error)")
            }
        }
    }
    
    // decode data
    static func parseData(_ data:Data)->JwtToken{
        let decoder = JSONDecoder()
        do{
            let response = try decoder.decode(LoginResponse.self, from: data)
            let jwtToken = response.jwtToken
            return jwtToken
        }catch let error{
            print("error--->\(error)")
        }
    }
    
    static func logout(){
        UserDefaults.standard.removeObject(forKey: "jwtToken")
        NotificationCenter.default.post(name: .authStateDidChange, object: nil)
    }
}

