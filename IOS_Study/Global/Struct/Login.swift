//
//  Login.swift
//  IOS_Study
//
//  Created by ho jun lim on 2022/01/04.
//

import Foundation

//MARK: 로그인을 위한 Codable 구조체
struct Login: Codable {
    let email:String
    let password:String
    
    // api통신시 json 구조에 맞게 프로퍼티 이름 변경
    enum CodingKeys:String, CodingKey{
        case email = "email"
        case password = "password"
    }
}
