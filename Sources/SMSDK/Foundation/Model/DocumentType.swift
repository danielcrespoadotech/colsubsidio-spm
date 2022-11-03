//
//  DocumentType.swift
//  SMSDK
//
//  Created by Fernando León on 3/27/20.
//  Copyright © 2020 Fernando León. All rights reserved.
//

import Foundation

public enum DocumentType {
    case citizenshipID
    case identityCard
    case foreignerID
    case passport
        
    var identifier: String {
        switch self {
        case .citizenshipID:
            return "1"
        case .identityCard:
            return "5"
        case .foreignerID:
            return "4"
        case .passport:
            return "2"
        }
    }
    
    var frontTitle: String {
        switch self {
        case .citizenshipID:
            return SMManager.customization.document.citizenshipIDFrontTitle
        case .identityCard:
            return SMManager.customization.document.identityCardFrontTitle
        case .foreignerID:
            return SMManager.customization.document.foreignerIDFrontTitle
        case .passport:
            return SMManager.customization.document.passportFrontTitle
        }
    }
    
    var frontMessage: String {
        switch self {
        case .citizenshipID:
            return SMManager.customization.document.citizenshipIDFrontMessage
        case .identityCard:
            return SMManager.customization.document.identityCardFrontMessage
        case .foreignerID:
            return SMManager.customization.document.foreignerIDFrontMessage
        case .passport:
            return SMManager.customization.document.passportFrontMessage
        }
    }
    
    var backTitle: String {
        switch self {
        case .citizenshipID:
            return SMManager.customization.document.citizenshipIDBackTitle
        case .identityCard:
            return SMManager.customization.document.identityCardBackTitle
        case .foreignerID:
            return SMManager.customization.document.foreignerIDBackTitle
        case .passport:
            return SMManager.customization.document.passportBackTitle
        }
    }
    
    var backMessage: String {
        switch self {
        case .citizenshipID:
            return SMManager.customization.document.citizenshipIDBackMessage
        case .identityCard:
            return SMManager.customization.document.identityCardBackMessage
        case .foreignerID:
            return SMManager.customization.document.foreignerIDBackMessage
        case .passport:
            return SMManager.customization.document.passportBackMessage
        }
    }
}
