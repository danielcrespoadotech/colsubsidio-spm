//
//  DocViewModel.swift
//  SMSDK
//
//  Created by Rhonny Gonzalez on 3/30/20.
//  Copyright © 2020 Fernando León. All rights reserved.
//

import UIKit

protocol DocViewModelProtocol: AnyObject {
    var delegate: DocViewControllerProtocol? { get set }
    func continueButton(isFrontal: Bool, base64image: String?)
    func registerLogWithExceptionType(type: RegisterLogType, device: String)
}

class DocViewModel: DocViewModelProtocol {
    weak var delegate: DocViewControllerProtocol?
    private var documentService: DocumentService
    
    init() {
        documentService = .init()
    }
    
    func continueButton(isFrontal: Bool, base64image: String?) {
        isFrontal ? postFrontDoc(base64String: base64image) : postBackDoc(base64String: base64image)
    }
    
    private func postFrontDoc(base64String: String?) {
        documentService.uploadDocument(base64String: base64String ?? "", isFrontal: true) { [weak self] (response, error, statusCode) in
            switch statusCode {
            case 200:
                self?.delegate?.takeBackSide()
            case 201:
                self?.delegate?.successClose(response: response)
            default:
                self?.evaluateError(errorCode: statusCode, error: error)
            }
        }
    }
    
    private func postBackDoc(base64String: String?) {
        documentService.uploadDocument(base64String: base64String ?? "", isFrontal: false) { [weak self] (response, error, statusCode) in

            switch statusCode {
            case 200:
                self?.postClose()
            case 201:
                self?.delegate?.successClose(response: response)
            default:
                self?.evaluateError(errorCode: statusCode, error: error)
            }
        }
    }
    
    private func postClose() {
        documentService.closeService { [weak self] (response, error, statusCode) in
            switch statusCode {
            case 200:
                self?.delegate?.successClose(response: response)
            default:
                self?.evaluateError(errorCode: statusCode, error: error)
            }
        }
    }
    
    func evaluateError(errorCode: Int, error: Error?) {
        switch errorCode {
        case 400:
            delegate?.failedWithError(success: false, response: SMManager.customization.serviceErrors.responseObjectError("400"), error: SMManager.customization.serviceErrors.error400)
        case 401:
            delegate?.failedWithError(success: false, response: SMManager.customization.serviceErrors.responseObjectError("401"), error: SMManager.customization.serviceErrors.error401)
        case 404:
            delegate?.failedWithError(success: false, response: SMManager.customization.serviceErrors.responseObjectError("404"), error: SMManager.customization.serviceErrors.error404)
        case 500:
            delegate?.failedWithError(success: false, response: SMManager.customization.serviceErrors.responseObjectError("500"), error: SMManager.customization.serviceErrors.error500)
        default:
            delegate?.failedWithError(success: false, response: SMManager.customization.serviceErrors.responseObjectError("501"), error: SMManager.customization.serviceErrors.error500)
        }
    }
    
    func registerLogWithExceptionType(type: RegisterLogType, device: String) {
        documentService.sendRegisterExpection(type: type, device: device)
    }
}


