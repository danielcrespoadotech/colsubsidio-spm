import Foundation
    
public struct TransactionResponse: Decodable {
    public var Uid: String?
    public var StartingDate: String?
    public var CreationDate: String?
    public var CreationIP: String?
    public var DocumentType: Int?
    public var IdNumber: String?
    public var FirstName: String?
    public var SecondName: String?
    public var FirstSurname: String?
    public var SecondSurname: String?
    public var Gender: String?
    public var BirthDate: String?
    public var Street: String?
    public var CedulateCondition: String?
    public var Spouse: String?
    public var Home: String?
    public var MaritalStatus: String?
    public var DateOfIdentification: String?
    public var DateOfDeath: String?
    public var MarriageDate: String?
    public var Instruction: String?
    public var PlaceBirth: String?
    public var Nationality: String?
    public var MotherName: String?
    public var FatherName: String?
    public var HouseNumber: String?
    public var Profession: String?
    public var ExpeditionCity: String?
    public var ExpeditionDepartment: String?
    public var BirthCity: String?
    public var BirthDepartment: String?
    public var TransactionType: Int?
    public var TransactionTypeName: String?
    public var IssueDate: String?
    public var AdoProjectId: String?
    public var TransactionId: String?
    public var ProductId: String?
    public var Extras: ExtrasResponse?
    public var NumberPhone: String?
    public var DactilarCode: String?
    public var ReponseControlList: Bool?
    public var Response_ANI: String?
    public var Status: EStatus?
}
