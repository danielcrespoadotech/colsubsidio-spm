import Foundation

struct UILivenessModel : Decodable {
    
    var Id: Int?
    var LookLeftText: String?
    var LookRightText: String?
    var LookAtCenterText: String?
    var InitialAlignFaceText: String?
    var OngoingAlignFaceText: String?
    var MultipleFacesFoundText: String?
    var GetFurtherText: String?
    var ComeCloserText: String?
    var ProcessingDataText: String?
    var SessionEndedSuccessfullyText: String?
    var FaceIlluminationTooBrightText: String?
    var FaceIlluminationTooDarkText: String?
    var BadFaceFocusText: String?
    var FacePositionNotStableText: String?
    var UnderlineColorResource: String?
    var LoaderColorResource: String?
    var BackArrowColorResource: String?
    var DirectingArrowsColor: String?
    var SuccessSignColor: String?
    var SuccessSignBackgroundColor: String?
    var InstructionsPosition: Int?
    var DirectionSignShape : Int?
    var BackButtonShape: Int?
    var BackButtonSide: Int?
    
}
