//
//  LoginModel.swift
//  whatsong v3
//
//  Created by Andrii Shchudlo on 16/05/2019.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import Foundation

struct LoginModel: Decodable  {
    let data: LoginDataModel
}

struct LoginDataModel: Decodable  {
    let accessToken: AccessToken
    let refreshToken: RefreshToken
}

struct AccessToken: Decodable {
    let expire_in: Int
    let role: String
    let value: String
}

struct RefreshToken: Decodable {
    let expire_in: Int
    let value: String
}
