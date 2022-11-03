import Foundation

protocol FaceViewModelProtocol {
    var delegate: FaceViewControllerProtocol? { get set }
    
    func syncConfig()
    func getToken()
    func performVerification(base64String: String?, countLiveness: String?)
    func registerLogWithExceptionType(type: RegisterLogType, device: String)
}

class FaceViewModel: FaceViewModelProtocol {
    weak var delegate: FaceViewControllerProtocol?
    private var configService: GetConfigService
    private var verifationService: VerificationService
    private var documentService: DocumentService
    
    init() {
        configService = .init()
        verifationService = .init()
        documentService = .init()
    }
    
    func syncConfig() {
        configService.syncConfig { [weak self] (response, error, statusCode) in
            guard error == nil, let config = response else {
                self?.evaluateError(errorCode: statusCode, errorMessage: error?.localizedDescription)
                return
            }
            SMConfiguration.shared.updateConfig(response: config)
            if(response?.GetToken == "True"){
                self!.getToken()
            }else{
                self?.delegate?.fetchConfig(success: true)
            }
        }
    }
    
    func getToken() {
        configService.getToken { [weak self] (response, error, statusCode) in
            guard error == nil, let token = response else {
                if statusCode == 400{
                    self!.delegate?.fetchTransaction(success: false, response: SMManager.customization.serviceErrors.responseObjectError("H"), errorMessage: SMManager.customization.serviceErrors.error400)
                    return
                }else{
                    self?.evaluateError(errorCode: statusCode, errorMessage: error?.localizedDescription)
                    return
                }
            }
            SMConfiguration.shared.updateToken(response_token: token)
            self?.delegate?.fetchToken(success: true)
        }
    }
    
    func performVerification(base64String: String?, countLiveness: String?) {
        SMConfiguration.shared.validation ? customerVerification(base64String: base64String ?? String(), countLiveness: countLiveness ?? String()) : validationNew(base64String: base64String ?? String(), countLiveness: countLiveness ?? String())
    }
    
    func validationNew(base64String: String, countLiveness: String) {
        verifationService.newValidation(base64String: base64String, countLiveness: countLiveness) { [weak self] (response, error, statusCode) in
            SMConfiguration.shared.uid = response?.Uid ?? String()
            switch statusCode {
            case 200:
                self?.delegate?.nextScreen()
            case 201:
                self?.delegate?.fetchTransaction(success: true, response: response, errorMessage: nil)
            case 404:
                self?.delegate?.tryAgainConnection()
            case 406:
                self?.delegate?.noSuccessFace()
            default:
                self?.evaluateError(errorCode: statusCode, errorMessage: error?.localizedDescription)
            }
        }
    }
    
    func customerVerification(base64String: String, countLiveness: String) {
        verifationService.customerVerification(base64String: base64String, countLiveness: countLiveness) { [weak self] (response, error, statusCode) in
            SMConfiguration.shared.uid = response?.Uid ?? String()
            switch statusCode {
            case 200:
                self?.delegate?.fetchTransaction(success: true, response: response, errorMessage: nil)
            case 404:
                self?.delegate?.fetchTransaction(success: false, response: SMManager.customization.serviceErrors.responseObjectError("A"), errorMessage: nil)
            case 406:
                self?.delegate?.noSuccessFace()
            default:
                self?.evaluateError(errorCode: statusCode, errorMessage: error?.localizedDescription)
            }
        }
    }

    func evaluateError(errorCode: Int, errorMessage: String?) {
        switch errorCode {
        case 400:
            delegate?.fetchTransaction(success: false, response: SMManager.customization.serviceErrors.responseObjectError("400"), errorMessage: SMManager.customization.serviceErrors.error400)
        case 401:
            delegate?.fetchTransaction(success: false, response: SMManager.customization.serviceErrors.responseObjectError("401"), errorMessage: SMManager.customization.serviceErrors.error401)
        case 404:
            delegate?.fetchTransaction(success: false, response: SMManager.customization.serviceErrors.responseObjectError("404"), errorMessage: SMManager.customization.serviceErrors.error404)
        case 500:
            delegate?.fetchTransaction(success: false, response: SMManager.customization.serviceErrors.responseObjectError("500"), errorMessage: SMManager.customization.serviceErrors.error500)
        default:
            delegate?.fetchTransaction(success: false, response: SMManager.customization.serviceErrors.responseObjectError("501"), errorMessage: errorMessage)
        }
    }
    
    func registerLogWithExceptionType(type: RegisterLogType, device: String) {
        documentService.sendRegisterExpection(type: type, device: device)
    }
}
