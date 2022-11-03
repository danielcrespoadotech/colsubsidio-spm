//
//  StagesResponse.swift
//  SMSDK
//
//  Created by Daniel Crespo on 12/07/22.
//

import Foundation

public struct StagesResponse: Decodable {
    public var action_type: String?
    public var stage: Stages?
    public var payload: Payload?
    public var status: String?
}
