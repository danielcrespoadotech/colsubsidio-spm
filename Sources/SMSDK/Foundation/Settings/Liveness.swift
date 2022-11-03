//
//  Liveness.swift
//  SMSDK
//
//  Created by Fernando León on 3/30/20.
//  Copyright © 2020 Fernando León. All rights reserved.
//

import Foundation

public struct Liveness {
    public var lookAtCenterText = "No muevas tu celular hasta que se rellene el círculo del centro"
    public var lookLeftText = "Gira tu cara hacia la izquierda sin salir del círculo."
    public var lookRightText = "Gira tu cara hacia la derecha sin salir del círculo."
    public var initialAlignFaceText = "Ubica tu cara dentro del círculo al nivel de tus ojos"
    public var ongoingAlignFaceText = "Ubica tu cara dentro del círculo al nivel de tus ojos"
    public var comeCloserText = "Estás muy lejos. Acércate un poco"
    public var getFurtherText = "Estás muy cerca. Aléjate un poco"
    public var multipleFacesFoundText = "Solo debe haber un rostro en el círculo. ¡El tuyo!"
    public var sessionEndedSuccessfullyText = "Espera un momento"
    public var processingDataText = "Espera un momento"
    
    public var badFaceFocusText = "Imagen no enfocada"
    public var faceIlluminationTooDarkText = "Está muy oscura"
    public var faceIlluminationTooBrightText = "Está muy claro"
    public var facePositionNotStableText = "¡No te muevas! Ya casi estamos listos. Danos unos segundos"
    
    public var urlErrorTitle = "Error"
    public var urlErrorMessage = "Ha ocurrido un problema con la UrlServiceLiveness"
    public var catchErrorTitle = "Error"
    public var delegateMessage = LivenessDelegateMessage()
}

public struct LivenessDelegateMessage {
    public var abortUserCanceled = "User Canceled"
    public var abortFailed = "Liveness Failed"
    public var abortTimeout = "Liveness Timeout"
    public var abortCantOpenCamera = "Can Not Open Camera"
    public var abortAppGoesToBackground = "App Goes To Background"
    public var abortServerError = "Server Error"
    public var abortConnectionError = "Connection Error"
    public var errorLivenessCanceled = "Liveness Canceled"
    public var livenessVCCompleted = "Liveness Completed"
}
