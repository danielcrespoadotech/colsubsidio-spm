import Foundation
import UIKit

class VerificationService: SMConnectionService {
    func newValidation(base64String: String, countLiveness: String, completion: @escaping(_ config: TransactionResponse?, _ error: Error?, _ statusCode: Int) -> ()) {
        let parameters = [
            "ProductId": SMConfiguration.shared.productId,
            "CustomerPhoto": base64String,
            "DocumentType": SMConfiguration.shared.documentType,
            "longitude": SMConfiguration.shared.longitude,
            "Latitude": SMConfiguration.shared.latitude,
            "IdAssociated": "",
            "ClientRole": "",
            "KeyProcessLiveness": SMConfiguration.shared.uuidevice + "-" + countLiveness,
            "UIdDevice": SMConfiguration.shared.uuidevice,
            "SourceDevice": "3",
            "SdkVersion": "3.0.2",
            "OS": String(format: "%@%@",  UIDevice.current.systemName, UIDevice.current.systemVersion),
            "Uid": SMConfiguration.shared.uid]
        SMConnectionService.requestPOST(url: SMConstants.URL.validationNew, parameters: parameters, timeout: 30) { (result, error, statusCode) in
            guard error == nil, let result = result, let jsonData = try? JSONSerialization.data(withJSONObject: result) else {
                completion(nil, error, statusCode)
                return
            }
            do {
                completion(try JSONDecoder().decode(TransactionResponse.self, from: jsonData), nil, statusCode)
            } catch let jsonError {
                NSLog("Error serializing ValidationNewService json: %@", jsonError.localizedDescription)
                completion(nil, jsonError, statusCode)
            }
        }
    }
    
    func customerVerification(base64String: String, countLiveness: String, completion: @escaping(_ config: TransactionResponse?, _ error: Error?, _ statusCode: Int) -> ()) {
        let parameters = [
            "ProductId": SMConfiguration.shared.productId,
            "DocumentType": SMConfiguration.shared.documentType,
            "IdentificationNumber": SMConfiguration.shared.identification,
            "Face": base64String,
            "FingerPrint": "",
            "SourceDevice": "3",
            "SdkVersion": "3.0.2",
            "OS": String(format: "%@%@",  UIDevice.current.systemName, UIDevice.current.systemVersion),
            "KeyProcessLiveness": SMConfiguration.shared.uuidevice + "-" + countLiveness]
        SMConnectionService.requestPOST(url: SMConstants.URL.customerVerification, parameters: parameters, timeout: 30) { (result, error, statusCode) in
            guard error == nil, let result = result, let jsonData = try? JSONSerialization.data(withJSONObject: result) else {
                completion(nil, error, statusCode)
                return
            }
            do {
                completion(try JSONDecoder().decode(TransactionResponse.self, from: jsonData), nil, statusCode)
            } catch let jsonError {
                NSLog("Error serializing CustomerVerificationService json: %@", jsonError.localizedDescription)
                completion(nil, jsonError, statusCode)
            }
        }
    }
}
