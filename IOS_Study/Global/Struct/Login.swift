//
//  Login.swift
//  IOS_Study
//
//  Created by ho jun lim on 2022/01/04.
//

import Foundation

//MARK: 로그인을 위한 Codable(encodable, decodable) 구조체
struct Login: Codable {
    let email:String
    let password:String
    
    // api통신시 json 구조에 맞게 프로퍼티 이름 변경
    enum CodingKeys:String, CodingKey{
        case email = "email"
        case password = "password"
    }
}

// MARK: Response 상속
class LoginResponse: Response {
    let jwtToken: String
    
    enum CodingKeys: String, CodingKey{
        case jwtToken
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.jwtToken = try container.decode(String.self, forKey: .jwtToken)
        try super.init(from: decoder)
    }
}
