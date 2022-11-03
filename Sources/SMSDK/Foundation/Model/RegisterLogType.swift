//
//  RegisterLogType.swift
//  SMSDK
//
//  Created by Fernando León on 4/1/20.
//  Copyright © 2020 Fernando León. All rights reserved.
//

import Foundation

enum RegisterLogType {
    case startSDK
    case locationGranted
    case locationDenied
    case startLiveness
    case errorLiveness
    case successLiveness
    case startFront
    case startBack
    case endFront
    case endBack
    
    var source: String {
        switch self {
        case .startSDK:
            return "Inicia SDK"
        case .locationGranted:
            return "Autorización de permisos de localización"
        case .locationDenied:
            return "Negación de permisos de localización"
        case .startLiveness:
            return "Inicia Captura liveness"
        case .errorLiveness:
            return SMConfiguration.shared.errorLivenessRegisterLog
        case .successLiveness:
            return "Liveness finish successful"
        case .startFront:
            return "Inicio de captura front"
        case .startBack:
            return "Inicio Captura Back"
        case .endFront:
            return "Finalización captura front"
        case .endBack:
            return "Finalización Captura Back"
        }
    }
    
    var message: String {
        switch self {
        case .startSDK:
            return "SKD initialization"
        case .locationGranted:
            return "Permission for location granted"
        case .locationDenied:
            return "Permission for location not granted"
        case .startLiveness:
            return "Start capture liveness"
        case .errorLiveness:
            return "RegisterLogWithExceptionType"
        case .successLiveness:
            return "LivenessVC Success"
        case .startFront:
            return "Start Capture Front Side"
        case .startBack:
            return "Start Capture Back Side"
        case .endFront:
            return "Capture Process Front Side successful"
        case .endBack:
            return "Capture Process Back Side successful"
        }
    }
    
    var exceptionType: String {
        switch self {
        case .errorLiveness:
            return "Error"
        default:
            return "Info"
        }
    }
}
