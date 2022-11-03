import Foundation

struct UIManualCaptureModel : Decodable {
    
    var Id: Int?
    var CaptureFrontInstructionsText: String?
    var CaptureBackInstructionsText: String?
    var MainColor: String?
    var BackArrowColor: String?
    var InstructionsColor: String?
    var InstructionsBackgroundColor: String?
    var BackArrowShape: Int?
    var InstructionsPosition: Int?
    var BackArrowSide: Int?
    
}
