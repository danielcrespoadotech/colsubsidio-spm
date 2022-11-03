import Foundation

struct GetConfigResponse: Decodable {
    
    var TryLiveness: Int
    var Token_KYC: String
    var UrlServiceOCR: String
    var UrlServiceLiveness: String
    var UrlNewServiceLiveness: String
    var ConfigFileLiveness: String
    var TypeLiveness: Int
    var ProjectName: String
    var ApiKey: String
    var Base_Uri: String
    var TryOcr: Int
    var GetGeoreference: Int
    var GetToken: String
    var SecondCamera: Bool
    var ConfigurationUI: ConfigurationUIModel
    
}
