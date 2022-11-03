//
//  Payload.swift
//  SMSDK
//
//  Created by Dani Riders on 12/07/22.
//

import Foundation

public struct Payload: Decodable {
    public var threshold: Double?
    public var score: Double?
    public var images: Images?
}
