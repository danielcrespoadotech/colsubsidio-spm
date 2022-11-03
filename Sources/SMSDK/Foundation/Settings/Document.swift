//
//  Document.swift
//  SMSDK
//
//  Created by Fernando León on 3/30/20.
//  Copyright © 2020 Fernando León. All rights reserved.
//

import Foundation

public struct Document {
    public var citizenshipIDFrontTitle = "Registro de cédula"
    public var identityCardFrontTitle = "Tarjeta de ciudadanía"
    public var foreignerIDFrontTitle = "Cédula de extranjería"
    public var passportFrontTitle = "Registro de pasaporte"
    public var citizenshipIDFrontMessage = "Gira tu celular, ubica tu cédula\nen el recuadro y toca la\npantalla para capturar la parte\ndelantera de tu cédula."
    public var identityCardFrontMessage = "Gira tu celular, ubica tu tarjeta\nen el recuadro y toca la\npantalla para capturar por el\nlado de la foto."
    public var foreignerIDFrontMessage = "Gira tu celular, ubica tu cédula\nen el recuadro y toca la\npantalla para capturar por el\nlado de la foto."
    public var passportFrontMessage = "Gira tu celular, ubica tu pasaporte\nen el recuadro y toca la\npantalla para capturar por la\nhoja donde está tu cara."
    public var citizenshipIDBackTitle = "Posterior de cédula"
    public var identityCardBackTitle = "Ahora la parte de atrás"
    public var foreignerIDBackTitle = "Posterior de cédula"
    public var passportBackTitle = "Permiso especial"
    public var citizenshipIDBackMessage = "Gira tu celular, ubica tu cédula\nen el recuadro y toca la\npantalla para capturar por el\nlado de la huella."
    public var identityCardBackMessage = "Gira tu celular, ubica tu tarjeta\nen el recuadro y toca la\npantalla para capturar por el\nlado de la huella."
    public var foreignerIDBackMessage = "Gira tu celular, ubica tu documento\nen el recuadro y toca la\npantalla para capturar por el\nlado de la huella."
    public var passportBackMessage = "Gira tu celular, ubica tu permiso\nespecial de permanecia en el recuadro\ny toca la pantalla para capturar\npor el lado de la foto."
    public var alreadyRegisteredMessage = "Ya te encuentras registrado"
    public var clearDocumentTitleMessage = "¿Está bien la imagen de tu documento?"
    public var clearDocumentMessage = "Asegúrate que se vea perfectamente."
    public var continueButton = "Si, está bien"
    public var startButton = "Tomemos la foto"
    public var takeAnotherPhotoButton = "No, tomar otra foto"
    public var scanAgain = "No, tomar otra foto"
    public var invalidTitleFront = "Registro inválido"
    public var invalidTitleBack = "Registro inválido"
    public var invalidMessageFront = "No hemos podido detectar un\ndocumento. Por favor intenta de\nnuevo."
    public var invalidMessageBack = "No hemos podido detectar un\ndocumento. Por favor intenta de\nnuevo."
    public var backButton = String()
    public var titleCaptureLabel = "Vamos a escanear\ntu documento"
    public var frontMessageLabel = "Debes tener tu cédula colombiana en buen estado.\nUbicate en un lugar iluminado y no muevas tu celular mientas se captura la foto de tu documento.\nParte delantera."
    public var backMessageLabel = "Debes tener tu cédula colombiana en buen estado.\nUbícate en un lugar iluminado y no muevas tu celular mientas se captura la foto de tu documento.\nParte trasera."
}
