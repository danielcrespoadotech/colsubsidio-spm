//
//  SMParams.swift
//  SMSDK
//
//  Created by Fernando León on 3/26/20.
//  Copyright © 2020 Fernando León. All rights reserved.
//

import Foundation

public struct SMParams {
    
    public var documentType: String
    public var productId: String
    public var projectName: String
    public var apiKey: String
    public var urlSdk: String
    public var identification: String
    public var validation: Bool
    public var userName: String
    public var password: String
    
    public init(documentType: String, productId: String, projectName: String, apiKey: String, urlSdk: String, identification: String, validation: Bool, userName: String, password: String) {
        self.documentType = documentType
        self.productId = productId
        self.projectName = projectName
        self.apiKey = apiKey
        self.urlSdk = urlSdk
        self.identification = identification
        self.validation = validation
        self.userName = userName
        self.password = password
        
    }
}
