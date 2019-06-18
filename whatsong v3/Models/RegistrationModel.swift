//
//  RegistrationModel.swift
//  whatsong v3
//
//  Created by Andrii Shchudlo on 17/06/2019.
//  Copyright © 2019 Tom Andrew. All rights reserved.
//

import UIKit

struct SignUpResponce: Decodable {
    let success: Bool
    var error: ErrorStruct?
}

struct ErrorStruct: Decodable {
    
    let message: String?
    let name: String?
    var errors: ErrorsStruct?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.message = try values.decode(String.self, forKey: .message)
        self.name = try values.decode(String.self, forKey: .name)
        if values.contains(.errors) {
            errors = try values.decodeIfPresent(ErrorsStruct.self, forKey: .errors)
        } else {
            errors = nil
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case message = "message"
        case name = "name"
        case errors = "errors"
    }
}

struct ErrorsStruct: Decodable {
    var email: EmailStruct?
    var username: UserNameStruct?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if values.contains(.email) {
            email = try values.decodeIfPresent(EmailStruct.self, forKey: .email)
        } else {
            email = nil
        }
        if values.contains(.username) {
            username = try values.decodeIfPresent(UserNameStruct.self, forKey: .username)
        } else {
            username = nil
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case email = "email"
        case username = "username"
    }
    
}

struct UserNameStruct: Decodable {
    let message: String?
}

struct EmailStruct: Decodable {
    let message: String?
}

