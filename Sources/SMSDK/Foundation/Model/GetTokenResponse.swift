//
//  GetTokenResponse.swift
//  SMSDK
//
//  Created by Gerard Amortegui on 2/07/20.
//  Copyright © 2020 Fernando León. All rights reserved.
//

import Foundation

struct GetTokenResponse: Decodable {
    
    var access_token: String
    var token_type: String
    var expires_in: Int
    var userName : String
    var issued: String
    var expires: String
}
