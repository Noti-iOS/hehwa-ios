//
//  Login.swift
//  IOS_Study
//
//  Created by ho jun lim on 2022/01/04.
//

import Foundation

//MARK: 로그인을 위한 Codable 구조체
struct Login {
    let email:String
    let password:String
    let jwtToken:String?
}
