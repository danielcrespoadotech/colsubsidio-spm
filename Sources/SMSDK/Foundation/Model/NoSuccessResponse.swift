//
//  NoSuccessResponse.swift
//  SMSDK
//
//  Created by Dani Riders on 12/07/22.
//

import Foundation

public struct NoSuccessResponse: Decodable {
    public var name: String?
    public var message: String?
    public var code:Int?
}
