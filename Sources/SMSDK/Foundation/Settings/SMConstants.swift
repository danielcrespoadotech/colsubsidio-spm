//
//  Constants.swift
//  SMSDK
//
//  Created by Fernando León on 3/26/20.
//  Copyright © 2020 Fernando León. All rights reserved.
//

import Foundation

struct SMConstants {
    struct URL {
        static var getConfig = SMConfiguration.shared.urlSdk + SMConfiguration.shared.projectName + "/GetConfig?Message=hola"
        static var getToken = SMConfiguration.shared.urlSdk + "/token"
        static var validationNew = SMConfiguration.shared.baseUrl + "/Integration/" + SMConfiguration.shared.projectName + "/Validation/New"
        static var customerVerification = SMConfiguration.shared.baseUrl + "/" + SMConfiguration.shared.projectName + "/CustomerVerification"
        static var postFrontDoc = SMConfiguration.shared.baseUrl + "/Integration/" + SMConfiguration.shared.projectName + "/Validation/Images/DocumentFrontSide"
        static var postBackDoc = SMConfiguration.shared.baseUrl + "/Integration/" + SMConfiguration.shared.projectName + "/Validation/Images/DocumentBackSide"
        static var postClose = SMConfiguration.shared.baseUrl + "/Integration/" + SMConfiguration.shared.projectName + "/Validation/Close"
        static var registerLog = SMConfiguration.shared.baseUrl + "/" + SMConfiguration.shared.projectName + "/RegisterLog"
    }
    
    struct Key {
        static var acuantLicenseKey = "431530538E1F"
    }
}
