import Foundation


public enum EStatus: Decodable {
 
    
    case SUCCESS
    case ERROR
    case CANCELLED_BY_USER
    public init (from decoder: Decoder) throws{
        let A = try decoder.singleValueContainer()
        let B = try? A.decode(String.self)
        switch B {
        case "SUCCESS": self = .SUCCESS
        case "ERROR": self = .ERROR
        case "CANCELLED_BY_USER": self = .CANCELLED_BY_USER
        default:
            self = .ERROR
        }
    }

    
}
