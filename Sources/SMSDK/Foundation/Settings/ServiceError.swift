import Foundation

public struct ServiceError {
    
    public var error400 = "Los datos proporcionados no corresponden con los criterios esperados."
    public var error401 = "El proceso de autorización no fue exitoso. Valide el codigo de proyecto y/o el API Key."
    public var error404 = "El codigo de producto y/o proyecto especificado no existe."
    public var error404Customer = "El numero de cedula del usuario no existe."
    public var error500 = "Ha ocurrido un error, valide el número de id entregado para obtener más detalles."
    public var defaultMessage = "Algo no salió bien, por\nfavor comunícate con\nnuestra mesa de soporte"
    public var backButton = String()
    public var error: Bool = false;
    
    public func responseObjectError(_ type: String) -> TransactionResponse{
        var transactionResponse = TransactionResponse()
        let extras = ExtrasResponse()
        
        transactionResponse.Extras = extras
        transactionResponse.Uid = "";
        transactionResponse.StartingDate = "";
        transactionResponse.CreationDate = "";
        transactionResponse.CreationIP = "198.143.41.3";
        transactionResponse.IdNumber = "";
        transactionResponse.FirstName = "";
        transactionResponse.SecondName = "";
        transactionResponse.FirstSurname = "";
        transactionResponse.SecondSurname = "";
        transactionResponse.Gender = "";
        transactionResponse.AdoProjectId = "";
        transactionResponse.TransactionId = "";
        transactionResponse.ProductId = "1";
        transactionResponse.Extras?.additionalProp1 = "";
        transactionResponse.Extras?.additionalProp2 = "";
        transactionResponse.Extras?.additionalProp3 = "";
        transactionResponse.Extras?.IdState = "";
        transactionResponse.Extras?.StateName = "";
        transactionResponse.TransactionTypeName = SMConfiguration.shared.validation ==  true ?("Verify"):("Enroll");
        transactionResponse.TransactionType = SMConfiguration.shared.validation ==  true ?(2):(1);
        
        
        switch type {
        case "A":
            transactionResponse.Extras?.additionalProp1 = "Documento no se encuentra enrolado";
            transactionResponse.Extras?.IdState = "15";
            transactionResponse.Extras?.StateName = "Error";
            SMConfiguration.shared.ProcessResponse(response: transactionResponse)
            return transactionResponse
            
        case "B":
            
            let r = Int.random(in: 0...1999999999)
            transactionResponse.Uid = "b23086ff-dd2b-4f8c-9e4a-8e69c9cb023f";
            transactionResponse.StartingDate = "";
            transactionResponse.CreationDate = "";
            transactionResponse.IdNumber = String(r);
            transactionResponse.FirstName = "MARLON";
            transactionResponse.SecondName = "ANDRES";
            transactionResponse.FirstSurname = "MARIN";
            transactionResponse.SecondSurname = "BELTRAN";
            transactionResponse.TransactionId = "360";
            transactionResponse.Extras?.IdState = "2";
            transactionResponse.Extras?.StateName = "Proceso satisfactorio";
            
            return SMConfiguration.shared.ProcessResponse(response: transactionResponse)
            
        case "C":
            
            transactionResponse.Extras?.additionalProp1 = "la persona ya se encuentra registrada en nuestra plataforma";
            transactionResponse.Extras?.IdState = "14";
            transactionResponse.Extras?.StateName = "Persona registrada previamente";
            transactionResponse.IdNumber = SMConfiguration.shared.identification;
           
            return SMConfiguration.shared.ProcessResponse(response: transactionResponse)
            
            
        case "D":
            transactionResponse.Extras?.additionalProp1 = "El usuario sobrepaso el numero de intentos fallidos de Liveness";
            transactionResponse.Extras?.IdState = "15";
            transactionResponse.Extras?.StateName = "Error";
           
            return SMConfiguration.shared.ProcessResponse(response: transactionResponse)
            
        case "E":
            transactionResponse.Extras?.additionalProp1 = "El usuario navego atras en los tips del selfie";
            transactionResponse.Extras?.IdState = "17";
            transactionResponse.Extras?.StateName = "Proceso cancelado por el usuario";
            
            return SMConfiguration.shared.ProcessResponse(response: transactionResponse)
            
        case "F":
            transactionResponse.Extras?.additionalProp1 = "El usuario salio del sdk en la pantalla de conexión";
            transactionResponse.Extras?.IdState = "17";
            transactionResponse.Extras?.StateName = "Proceso cancelado por el usuario";
           
            return SMConfiguration.shared.ProcessResponse(response: transactionResponse)
            
        case "G":
            transactionResponse.Extras?.additionalProp1 = "El usuario ha cerrado el SDK";
            transactionResponse.Extras?.IdState = "17";
            transactionResponse.Extras?.StateName = "Proceso cancelado por el usuario";
            
            return SMConfiguration.shared.ProcessResponse(response: transactionResponse)
            
        case "H":
            transactionResponse.Extras?.additionalProp1 = "Las credenciales para obtener el Token no son correctas.";
            transactionResponse.Extras?.IdState = "15";
            transactionResponse.Extras?.StateName = "Error";
           
        return SMConfiguration.shared.ProcessResponse(response: transactionResponse)
            
        case "400":
            transactionResponse.Extras?.additionalProp1 = "Error interno.";
            transactionResponse.Extras?.IdState = "15";
            transactionResponse.Extras?.StateName = "Error";
            
        return SMConfiguration.shared.ProcessResponse(response: transactionResponse)
            
        case "401":
            transactionResponse.Extras?.additionalProp1 = "El proceso de autorización no fue exitoso, valide el nombre de proyecto y/o el API Key.";
            transactionResponse.Extras?.IdState = "15";
            transactionResponse.Extras?.StateName = "Error";
            
        return SMConfiguration.shared.ProcessResponse(response: transactionResponse)
            
        case "404":
            transactionResponse.Extras?.additionalProp1 = "Verifique las credenciales de iniciación del SDK.";
            transactionResponse.Extras?.IdState = "15";
            transactionResponse.Extras?.StateName = "Error";
           
        return SMConfiguration.shared.ProcessResponse(response: transactionResponse)
            
        case "500":
            transactionResponse.Extras?.additionalProp1 = "Error interno, 500.";
            transactionResponse.Extras?.IdState = "15";
            transactionResponse.Extras?.StateName = "Error";
           
        return SMConfiguration.shared.ProcessResponse(response: transactionResponse)
            
        default:
            transactionResponse.Extras?.additionalProp1 = "Ha ocurrido un error inesperado";
            transactionResponse.Extras?.IdState = "15";
            transactionResponse.Extras?.StateName = "Error";
           
            return SMConfiguration.shared.ProcessResponse(response: transactionResponse)
        }
    }
}
