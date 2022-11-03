//
//  AnimationType.swift
//  SMSDK
//
//  Created by Fernando León on 3/26/20.
//  Copyright © 2020 Fernando León. All rights reserved.
//

import Foundation

enum AnimationType {
    case loader
    
    var name: String {
        switch self {
        case .loader:
            return "loader"
        }
    }
}
