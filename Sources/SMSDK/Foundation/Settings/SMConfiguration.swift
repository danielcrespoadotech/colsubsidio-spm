//
//  SMConfiguration.swift
//  SMSDK
//
//  Created by Fernando León on 3/26/20.
//  Copyright © 2020 Fernando León. All rights reserved.
//

import CoreLocation
import UIKit
import Alamofire

class SMConfiguration {
    static let shared = SMConfiguration()
    var SMBundle = Bundle.module
    var uid = String()
    var urlServiceLiveness = String()
    var urlLiveness = String()
    var documentType = String()
    var document: DocumentType = .citizenshipID
    var productId = String()
    var projectName = String()
    var apiKey = String()
    var urlSdk = String()
    var identification = String()
    var validation: Bool = false
    var baseUrl = String()
    var location: CLLocation?
    var errorLivenessRegisterLog = String()
    
    var urlServicesOCR = String()
    var TryLiveness = Int()
    var Token_KYC = String()
    var livenessPath = String()
    var TypeLiveness = Int()
    var Token = String()
    var urlOCR = String()
    var tryOCR = Int()
    var token = String()
    var getToken = String()
    var userName = String()
    var password = String()
    var uuidevice = String()
    var secondCamera = Bool()
    var getGeoreference = Int()
    var UrlNewServiceLiveness = String()
    var ConfigFileLiveness = String()
    
    var captureAttempt = 0;
    var captureAttemptOCR = 0;
    var uiLiveness = UILivenessModel()
    var uiManualCapture = UIManualCaptureModel()
    var threshold: Double = 0.5
    
    private init() {}
    
    func updateValues(params: SMParams) {
        baseUrl = params.urlSdk
        documentType = params.documentType
        projectName = params.projectName
        apiKey = params.apiKey
        urlSdk = params.urlSdk
        identification = params.identification
        validation = params.validation
        productId = params.productId
        userName = params.userName
        password = params.password
    }
    
    func headers() -> HTTPHeaders {
        let headers: HTTPHeaders = ["Content-type":"application/json", "projectName":projectName, "apiKey":apiKey, "Authorization": token]
        return headers
    }
    
    func headersGetConfig() -> HTTPHeaders {
        let headersGetConfig: HTTPHeaders = ["Content-type":"application/json", "projectName":projectName, "apiKey":apiKey, "productId":productId]
        return headersGetConfig
    }
    
    func updateToken(response_token: String) {
        token = "bearer "+response_token
    }
    
    func updateConfig(response: GetConfigResponse) {
        TryLiveness = response.TryLiveness
        Token_KYC = response.Token_KYC
        urlServicesOCR = response.UrlServiceOCR
        urlServiceLiveness = response.UrlServiceLiveness
        TypeLiveness = response.TypeLiveness
        projectName = response.ProjectName
        apiKey = response.ApiKey
        baseUrl = response.Base_Uri
        tryOCR = response.TryOcr
        getGeoreference = response.GetGeoreference
        getToken = response.GetToken
        captureAttempt = TryLiveness
        uuidevice = UUID().uuidString
        uid = ""
        secondCamera = response.SecondCamera
        uiLiveness = response.ConfigurationUI.LivenessUI
        uiManualCapture = response.ConfigurationUI.CardCaptureUI
        UrlNewServiceLiveness = response.UrlNewServiceLiveness
        ConfigFileLiveness = response.ConfigFileLiveness
    }
    
    var latitude: String {
        return location?.coordinate.latitude != nil ? String(describing: location!.coordinate.latitude) : ""
    }
    
    var longitude: String {
        return location?.coordinate.longitude != nil ? String(describing: location!.coordinate.longitude) : ""
    }
    
    
    func ProcessResponse (response: TransactionResponse) -> TransactionResponse{
        var transactionResponse = response
        
        if (validation){
            switch(response.Extras?.IdState) {
            case "1",
                "5",
                "6",
                "7",
                "8",
                "9",
                "10",
                "11",
                "15",
                "16",
                "18":
                transactionResponse.Status = EStatus.ERROR
            case "14":
                transactionResponse.Status = EStatus.SUCCESS
            case "17":
                transactionResponse.Status = EStatus.CANCELLED_BY_USER
            default:
                transactionResponse.Status = EStatus.ERROR
            }
        }else
        {
            switch(response.Extras?.IdState) {
            case "1",
                "5",
                "6",
                "7",
                "8",
                "9",
                "10",
                "11",
                "14",
                "15",
                "16",
                "18":
                transactionResponse.Status = EStatus.ERROR
            case "2":
                transactionResponse.Status = EStatus.SUCCESS
            case "17":
                transactionResponse.Status = EStatus.CANCELLED_BY_USER
            default:
                transactionResponse.Status = EStatus.ERROR
            }
        }
        return transactionResponse
    }
}
