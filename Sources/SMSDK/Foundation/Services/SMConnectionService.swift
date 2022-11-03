import UIKit
import Alamofire

class SMConnectionService: NSObject {
    
    typealias CompletionBlock = (Any?, Error?, Int) -> ()
    
    //MARK: Static functions
    static func requestGET(url: String, parameters: [String: Any]? = nil, timeout: TimeInterval = 30, completion: @escaping CompletionBlock) {
        request(url: url, method: .get, parameters: parameters, timeout: timeout, completion: completion)
    }
    
    static func requestPOST(url: String, parameters: [String: Any]? = nil, timeout: TimeInterval = 30, completion: @escaping CompletionBlock) {
        request(url: url, method: .post, parameters: parameters, timeout: timeout, completion: completion)
    }
    
    static func requestPOSTGetConfig(url: String, parameters: [String: Any]? = nil, timeout: TimeInterval = 30, completion: @escaping CompletionBlock) {
        requestGetConfig(url: url, method: .post, parameters: parameters, timeout: timeout, completion: completion)
    }
    
    static func requestPUT(url: String, parameters: [String: Any]? = nil, timeout: TimeInterval = 30, completion: @escaping CompletionBlock) {
        request(url: url, method: .put, parameters: parameters, timeout: timeout, completion: completion)
    }
    
    static func requestDELETE(url: String, parameters: [String: Any]? = nil, timeout: TimeInterval = 30, completion: @escaping CompletionBlock) {
        request(url: url, method: .delete, parameters: parameters, timeout: timeout, completion: completion)
    }
    
    static func isConnectedToInternet() -> Bool{
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}

//MARK:- Private functions
private extension SMConnectionService {
    
    static func request(url: String, method: HTTPMethod, parameters: [String: Any]?, timeout: TimeInterval, completion: @escaping CompletionBlock) {
        showActivityIndicator(true)
        AF.session.configuration.timeoutIntervalForRequest = timeout
        AF.session.configuration.timeoutIntervalForResource = timeout
        AF.request(url, method: method, parameters: parameters,  encoding: JSONEncoding.default , headers: SMConfiguration.shared.headers()).responseJSON { response in
            showActivityIndicator(false)
            let statusCode = response.response?.statusCode ?? 404
            if statusCode >= 300 || response.error != nil {
                completion(nil, response.error, statusCode)
            } else {
                completion(response.value, nil, statusCode)
            }
        }
    }
    
    static func requestGetConfig(url: String, method: HTTPMethod, parameters: [String: Any]?, timeout: TimeInterval, completion: @escaping CompletionBlock) {
        showActivityIndicator(true)
        AF.session.configuration.timeoutIntervalForRequest = timeout
        AF.session.configuration.timeoutIntervalForResource = timeout
        AF.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default , headers: SMConfiguration.shared.headersGetConfig()).responseJSON { response in
            showActivityIndicator(false)
            let statusCode = response.response?.statusCode ?? 404
            if statusCode >= 300 || response.error != nil {
                completion(nil, response.error, statusCode)
            } else {
                completion(response.value, nil, statusCode)
            }
        }
    }
    
    static func showActivityIndicator(_ show: Bool) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = show
        }
    }
    
}
