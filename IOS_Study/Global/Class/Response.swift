//
//  Response.swift
//  IOS_Study
//
//  Created by ho jun lim on 2022/01/04.
//

import Foundation

// MARK: Response Class
// api 통신시 response 관리를 위한 decodable 클래스 생성 필요한 통신마다 response를 상속해 데이터 decoder
// 임의의 class proterty
class Response: Decodable {
    var result:[Int]
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
