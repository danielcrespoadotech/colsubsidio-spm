//
//  SMStrings.swift
//  SMSDK
//
//  Created by Fernando León on 3/30/20.
//  Copyright © 2020 Fernando León. All rights reserved.
//

import Foundation

public struct Face {
    public var title = "Verificación de identidad"
    public var message = "Para continuar, es necesario que no tengas accesorios como gafas o gorros puestos.​"
    public var clearPhotoMessage = "¿Quieres cambiar la\nfotografía?"
    public var noSucessface = "Inténtalo de nuevo"
    public var almostDoneMessage = "Ya casi terminamos..."
    public var alreadyRegisteredMessage = "Ya te encuentras registrado"
    public var takeAnotherPhotoButton = "Tomar nuevamente"
    public var startButton = "Comenzar"
    public var continueButton = "Sí, está bien"
    public var alerts = FaceAlert()
}

public struct FaceAlert {
    public var getLocationCancel = "Cancelar"
    public var getLocationGoToSettings = "Ir a configuración"
    public var getLocationErrorTitle = "Error"
    public var getLocationPermissions = "Se necesita permiso para acceder a tu ubicación y realizar la verificación de identidad"
    public var getLocationCantGoToSettings = "No se ha podido abrir la configuración, por favor habilita la ubicación manualmente desde los ajustes"
    public var getConfigCancelAction = "Cancelar"
    public var getConfigTryAgainAction = "Intentar nuevamente"
    public var getConfigErrorTitle = "Error"
    public var getConfigErrorMessage = "Ha ocurrido un problema al intentar recuperar la configuración necesaria"
}
