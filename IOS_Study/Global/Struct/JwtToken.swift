//
//  JwtToken.swift
//  IOS_Study
//
//  Created by ho jun lim on 2022/01/05.
//

import Foundation

struct JwtToken: Codable {
    let accessToken: String
    let refreshToken: String
}
