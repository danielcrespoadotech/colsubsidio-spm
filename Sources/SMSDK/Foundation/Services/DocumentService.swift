import Foundation
import UIKit

class DocumentService: SMConnectionService {
    func uploadDocument(base64String: String, isFrontal: Bool, completion: @escaping(_ config: TransactionResponse?, _ error: Error?, _ statusCode: Int) -> ()) {
        let parameters = [
            "Image": base64String,
            "DocumentType": SMConfiguration.shared.documentType,
            "UIdDevice": SMConfiguration.shared.uuidevice,
            "SourceDevice": "3",
            "SdkVersion": "3.0.2",
            "OS": String(format: "%@%@",  UIDevice.current.systemName, UIDevice.current.systemVersion),
            "Uid": SMConfiguration.shared.uid]
        SMConnectionService.requestPOST(url: isFrontal ? SMConstants.URL.postFrontDoc : SMConstants.URL.postBackDoc, parameters: parameters, timeout: 30) { (result, error, statusCode) in
            guard error == nil, let result = result, let jsonData = try? JSONSerialization.data(withJSONObject: result) else {
                completion(nil, error, statusCode)
                return
            }
            do {
                completion(try JSONDecoder().decode(TransactionResponse.self, from: jsonData), nil, statusCode)
            } catch let jsonError {
                NSLog("Error serializing DocumentService uploadDocument json: %@", jsonError.localizedDescription)
                completion(nil, jsonError, statusCode)
            }
        }
    }
    
    func closeService(completion: @escaping(_ config: TransactionResponse?, _ error: Error?, _ statusCode: Int) -> ()) {
        let parameters = [
            "Uid": SMConfiguration.shared.uid]
        SMConnectionService.requestPOST(url: SMConstants.URL.postClose, parameters: parameters, timeout: 30) { (result, error, statusCode) in
            guard error == nil, let result = result, let jsonData = try? JSONSerialization.data(withJSONObject: result) else {
                completion(nil, error, statusCode)
                return
            }
            do {
                completion(try JSONDecoder().decode(TransactionResponse.self, from: jsonData), nil, statusCode)
            } catch let jsonError {
                NSLog("Error serializing DocumentService closeService json: %@", jsonError.localizedDescription)
                completion(nil, jsonError, statusCode)
            }
        }
    }
    
    func sendRegisterExpection(type: RegisterLogType, device: String) {
        let parameters = [
            "ExceptionType": type.exceptionType,
            "Source": type.source,
            "Message": type.message,
            "Device": device,
            "OperatingSystem": String(format: "%@%@",  UIDevice.current.systemName, UIDevice.current.systemVersion),
            "Uid": SMConfiguration.shared.uid,
            "Attempt": ""]
        SMConnectionService.requestPOST(url: SMConstants.URL.registerLog, parameters: parameters, timeout: 30) { (result, error, statusCode) in
            NSLog("RegisterLog " + type.message + (error != nil ? " error: " : " success: " + "\(statusCode)"))
        }
    }
}
