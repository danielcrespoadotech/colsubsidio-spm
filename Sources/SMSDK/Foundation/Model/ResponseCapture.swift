//
//  ResponseCapture.swift
//  SMSDK
//
//  Created by Daniel Crespo on 12/07/22.
//

import Foundation

public struct ResponseCapture: Decodable {
    public var action_type: String?
    public var status: String?
    public var stages = [StagesResponse]()
    public var caseId: String?
    public var configFilename: String?
    public var success: Bool
}
