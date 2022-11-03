import Foundation
import Alamofire

class GetConfigService: SMConnectionService {
    func syncConfig(completion: @escaping(_ config: GetConfigResponse?, _ error: Error?, _ statusCode: Int) -> ()) {
        SMConnectionService.requestPOSTGetConfig(url: SMConstants.URL.getConfig) { (result, error, statusCode) in
            guard error == nil, let result = result, let jsonData = try? JSONSerialization.data(withJSONObject: result) else {
                completion(nil, error, statusCode)
                return
            }
            do {
                completion(try JSONDecoder().decode(GetConfigResponse.self, from: jsonData), nil, statusCode)
            } catch let jsonError {
                NSLog("Error serializing GetConfigService json: %@", jsonError.localizedDescription)
                completion(nil, jsonError, statusCode)
            }
        }
    }
    
    func getToken(completion: @escaping(_ config: String?, _ error: Error?, _ statusCode: Int) -> ()) {
        let parameters = [
        "grant_type": "password",
        "username": SMConfiguration.shared.userName,
        "password": SMConfiguration.shared.password]
        
        AF.request(SMConstants.URL.getToken, method: .post, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            let statusCode = response.response?.statusCode ?? 404
            switch response.result {
            case .success(let JSON):
                
                let response1 = JSON as! NSDictionary
                let token = response1.object(forKey: "access_token")
                completion(token as? String, nil, statusCode)
                
            case .failure(let error):
                print(error)
                completion(nil, error, statusCode)
            }
        }
    }
}
