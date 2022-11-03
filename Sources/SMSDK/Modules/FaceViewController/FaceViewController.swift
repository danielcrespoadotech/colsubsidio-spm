import UIKit
import CoreLocation
import AVFoundation
import SafariServices

protocol FaceViewControllerProtocol: AnyObject {
    func nextScreen()
    func fetchConfig(success: Bool)
    func fetchToken(success: Bool)
    func fetchTransaction(success: Bool, response: TransactionResponse?, errorMessage: String?)
    func tryAgainConnection()
    func noSuccessFace()
}

protocol FaceViewControllerDelegate: AnyObject {
    func showScreenViewController(viewController: UIViewController)
    func nextScreenDocViewController(delegate: SMDelegate?)
    func popToRootViewController()
    func goBackScreen()
}

class FaceViewController: UIViewController {
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var clearPhotoMessageLabel: UILabel = {
        let clearPhotoMessageLabel = UILabel()
        clearPhotoMessageLabel.numberOfLines = 0
        clearPhotoMessageLabel.font = UIFont(name: ConstantsUi.Font.semiBold, size: 26)
        clearPhotoMessageLabel.textColor = ConstantsUi.Colors.black
        clearPhotoMessageLabel.textAlignment = .left
        clearPhotoMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        return clearPhotoMessageLabel
    }()
    
    private lazy var messageLabel: UILabel = {
        let messageLabel = UILabel()
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .left
        messageLabel.font = UIFont(name: ConstantsUi.Font.regular, size: 16)
        messageLabel.textColor = ConstantsUi.Colors.black
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        return messageLabel
    }()
    
    private lazy var pictureImagePost: UIImageView = {
        let pictureImagePost = UIImageView()
        pictureImagePost.backgroundColor = ConstantsUi.Colors.lightBlue
        pictureImagePost.contentMode = .scaleAspectFit
        pictureImagePost.translatesAutoresizingMaskIntoConstraints = false
        return pictureImagePost
    }()
    
    private lazy var letsDoItButton: UIButton = {
        let letsDoItButton = UIButton()
        letsDoItButton.titleLabel?.font = UIFont(name: ConstantsUi.Font.regular, size: 20)
        letsDoItButton.titleLabel?.textColor = ConstantsUi.Colors.white
        letsDoItButton.layer.cornerRadius = 6.0
        letsDoItButton.backgroundColor = ConstantsUi.Colors.blue
        letsDoItButton.translatesAutoresizingMaskIntoConstraints = false
        return letsDoItButton
    }()
    
    private lazy var takeAnotherPhotoButton: UIButton = {
        let takeAnotherPhotoButton = UIButton()
        takeAnotherPhotoButton.titleLabel?.font = UIFont(name: ConstantsUi.Font.regular, size: 20)
        takeAnotherPhotoButton.setTitleColor(ConstantsUi.Colors.blue, for: .normal)
        takeAnotherPhotoButton.backgroundColor = .clear
        takeAnotherPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        return takeAnotherPhotoButton
    }()
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.color = ConstantsUi.Colors.blue
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicatorView
    }()
    
    lazy var safariVC = SFSafariViewController(url: URL(string: SMConfiguration.shared.UrlNewServiceLiveness)!)
    
    //MARK: Vars
    var viewModel: FaceViewModelProtocol?
    var faceImage: UIImage?
    var tryAgain = false
    var delegate: SMDelegate?
    var locationManager = CLLocationManager()
    var countLiveness = 0
    var classBundle = Bundle.module
    var firstPich = false
    
    weak var coordinator: FaceViewControllerDelegate?
    
    //MARK: Initializers
    init(delegate: SMDelegate, params: SMParams) {
        super.init(nibName: nil, bundle: nil)
        SMConfiguration.shared.updateValues(params: params)
        self.delegate = delegate
        viewModel = FaceViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: ViewController Life's Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ""
        let rightBarButtonItem = UIBarButtonItem.init(
            image: ConstantsUi.Images.iconClose,
            style: .done,
            target: self,
            action: #selector(closeSDK)
        )
        rightBarButtonItem.tintColor = ConstantsUi.Colors.grayDark
        navigationItem.rightBarButtonItem = rightBarButtonItem
        viewModel?.delegate = self
        setupView()
        setupUi()
        getConfig(isEnable: true)
    }
    
    //MARK: Functions
    private func setupView() {
        setupContentView()
        setupTakeAnotherPhotoButton()
        setupLetsDoItButton()
        setupStackView()
        setupActivityIndicator()
        stackView.addArrangedSubview(clearPhotoMessageLabel)
        stackView.addArrangedSubview(messageLabel)
        stackView.addArrangedSubview(pictureImagePost)
    }
    
    private func setupContentView() {
        view.addSubview(contentView)
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: margins.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
    }
    
    private func setupTakeAnotherPhotoButton() {
        contentView.addSubview(takeAnotherPhotoButton)
        NSLayoutConstraint.activate([
            takeAnotherPhotoButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
            takeAnotherPhotoButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30),
            takeAnotherPhotoButton.heightAnchor.constraint(equalToConstant: 45.0),
            takeAnotherPhotoButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30)
        ])
    }
    
    private func setupLetsDoItButton() {
        contentView.addSubview(letsDoItButton)
        NSLayoutConstraint.activate([
            letsDoItButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30),
            letsDoItButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30),
            letsDoItButton.heightAnchor.constraint(equalToConstant: 45.0),
            letsDoItButton.bottomAnchor.constraint(equalTo: takeAnotherPhotoButton.topAnchor, constant: -15)
        ])
    }
    
    private func setupStackView() {
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30),
            stackView.bottomAnchor.constraint(equalTo: letsDoItButton.topAnchor, constant: -60)
        ])
    }
    
    private func setupActivityIndicator() {
        contentView.addSubview(activityIndicatorView)
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            activityIndicatorView.widthAnchor.constraint(equalToConstant: 250),
            activityIndicatorView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupUi() {
        view.backgroundColor = ConstantsUi.Colors.background
        messageLabel.text = SMManager.customization.face.message
        clearPhotoMessageLabel.text = SMManager.customization.face.clearPhotoMessage
        takeAnotherPhotoButton.setTitle(SMManager.customization.face.takeAnotherPhotoButton, for: .normal)
        takeAnotherPhotoButton.addTarget(self, action: #selector(takeAnotherPhotoAction), for: .touchUpInside)
        letsDoItButton.setTitle(SMManager.customization.face.startButton, for: .normal)
        letsDoItButton.addTarget(self, action: #selector(letsDoIt), for: .touchUpInside)
        showTakedControls(false)
        syncConfig()
        getLocation()
    }
    
    private func getConfig(isEnable: Bool){
        letsDoItButton.isHidden = isEnable
        messageLabel.isHidden = isEnable
    }
    
    
    @objc func backbuttonAction(sender: UIButton!) {
        openLiveness()
    }
    
    @objc func closeSDK(sender: AnyObject) {
        self.coordinator?.popToRootViewController()
        self.delegate?.completedWithResult(result: true, response: SMManager.customization.serviceErrors.responseObjectError("G"))
    }
    private func syncConfig() {
        if SMConnectionService.isConnectedToInternet(){
            activityIndicatorView.isShow(true)
            viewModel?.syncConfig()
        }else{
            showNoInternetViewController()
        }
    }
    
    private func getLocation() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            self.locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            let cancel = UIAlertAction(title: SMManager.customization.face.alerts.getLocationCancel, style: .cancel, handler: nil)
            let settings = UIAlertAction(title: SMManager.customization.face.alerts.getLocationGoToSettings, style: .default, handler: { (action) in
                if let settingUrl: URL = URL(string: UIApplication.openSettingsURLString) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(settingUrl, options: [UIApplication.OpenExternalURLOptionsKey.universalLinksOnly: false])
                    } else {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            self.showAlert(title: SMManager.customization.face.alerts.getLocationErrorTitle, message: SMManager.customization.face.alerts.getLocationCantGoToSettings)
                        }
                    }
                }
            })
            showAlert(title: SMManager.customization.face.alerts.getLocationErrorTitle, message: SMManager.customization.face.alerts.getLocationPermissions, buttons: [cancel, settings])
            viewModel?.registerLogWithExceptionType(type: .locationDenied, device: deviceName)
        default:
            viewModel?.registerLogWithExceptionType(type: .locationGranted, device: deviceName)
        }
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
    
    private func showTakedControls(_ state: Bool) {
        clearPhotoMessageLabel.text = SMManager.customization.face.clearPhotoMessage
        letsDoItButton.setTitle(state ? SMManager.customization.face.continueButton : SMManager.customization.face.startButton, for: .normal)
        pictureImagePost.image = faceImage
        messageLabel.isHidden = state
        clearPhotoMessageLabel.isHidden = !state
        takeAnotherPhotoButton.isHidden = !state
        pictureImagePost.isHidden = !state
        letsDoItButton.isHidden = !state
        tryAgain = state
    }
    
    private func startButtonState(isEnable: Bool) {
        UIView.transition(with: view, duration: 0.2, options: .showHideTransitionViews, animations: {
            self.getConfig(isEnable: false)
        })
        letsDoItButton.isEnabled = isEnable
    }
    
    private func hideControlsPostFace(_ state: Bool) {
        clearPhotoMessageLabel.isHidden = state
        takeAnotherPhotoButton.isHidden = state
        letsDoItButton.isHidden = state
        pictureImagePost.alpha = state ? 0.5 : 1.0
        activityIndicatorView.isShow(state)
    }
    
    private func postFace() {
        if SMConnectionService.isConnectedToInternet(){
            hideControlsPostFace(true)
            activityIndicatorView.isShow(true)
            viewModel?.performVerification(base64String: faceImage?.encodeToBase64String, countLiveness: String(countLiveness))
        }else{
            showNoInternetViewController()
        }
    }
    
    //MARK: Actions
    @objc func takeAnotherPhotoAction(sender: UIButton!) {
        openLiveness()
    }
    
    @objc func letsDoIt(sender: UIButton!) {
        myFunc()
    }
    
    private func myFunc(){
        #if targetEnvironment(simulator)
        var transactionResponse = SMManager.customization.serviceErrors.responseObjectError("B")
        if(SMConfiguration.shared.validation == true){
            if(SMManager.customization.serviceErrors.error == false){
                transactionResponse = SMManager.customization.serviceErrors.responseObjectError("C")
            }else{
                transactionResponse = SMManager.customization.serviceErrors.responseObjectError("")
            }
        }
        self.coordinator?.popToRootViewController()
        self.delegate?.completedWithResult(result: true, response: SMConfiguration.shared.ProcessResponse(response: transactionResponse))
        #else
        !tryAgain ? openLiveness() : postFace()
        #endif
    }
    
    private func isEnroll(){
        DispatchQueue.main.async {
            self.myFunc()
        }
    }
    
    private func visibleItems(state: Bool){
        letsDoItButton.isHidden = state
    }
}

//MARK:- Controllers
private extension FaceViewController {
    
    private func permissionCamera(){
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
            if response {
                DispatchQueue.main.async {
                    self.openLiveness()
                }
            } else {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Camara", message: "Necesitamos tener el acceso a la camara de tu telefono, ve a configuraciòn para darnos acceso", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in self.permissionCamera()
                    }))
                    self.coordinator?.showScreenViewController(viewController: alert)
                }
            }
        }
    }
    
    private func startLiveness(){
        #if targetEnvironment(simulator)
        var transactionResponse = SMManager.customization.serviceErrors.responseObjectError("B")
        if(SMConfiguration.shared.validation == true){
            if(SMManager.customization.serviceErrors.error == false){
                transactionResponse = SMManager.customization.serviceErrors.responseObjectError("C")
            }else{
                transactionResponse = SMManager.customization.serviceErrors.responseObjectError("")
            }
        }
        self.coordinator?.popToRootViewController()
        self.delegate?.completedWithResult(result: true, response: transactionResponse)
        #else
        permissionCamera()
        #endif
    }
    
    func openLiveness() {
        viewModel?.registerLogWithExceptionType(type: .startSDK, device: deviceName)
        if(SMConfiguration.shared.validation){
            showTakedControls(false)
        }
        
        if SMConnectionService.isConnectedToInternet(){
            if(countLiveness >= SMConfiguration.shared.TryLiveness){
                self.coordinator?.popToRootViewController()
                self.delegate?.completedWithResult(result: false, response: SMManager.customization.serviceErrors.responseObjectError("D"))
            } else {
                countLiveness = countLiveness + 1
                var connectionParamsDict = [String:Any]()
                var extraDataDict = [String:Any]()
                connectionParamsDict["url"] = SMConfiguration.shared.UrlNewServiceLiveness
                extraDataDict["caseId"] = SMConfiguration.shared.uuidevice + "-" + String(countLiveness)
                extraDataDict["libraryName"] = "LIVENESS"
                extraDataDict["clientTranslationFileName"] = SMConfiguration.shared.ConfigFileLiveness
                if(SMConfiguration.shared.secondCamera){
                    extraDataDict["flowConfigName"] = "mathilda_back.json"
                }else{
                    extraDataDict["flowConfigName"] = "mathilda.json"
                }
                connectionParamsDict["extraData"] = extraDataDict
                let jsonData: NSData
                var jsonString = ""
                do {
                    jsonData = try JSONSerialization.data(withJSONObject: connectionParamsDict, options: JSONSerialization.WritingOptions()) as NSData
                    jsonString = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)! as String
                } catch _ {
                    self.coordinator?.popToRootViewController()
                    self.delegate?.completedWithResult(result: false, response: SMManager.customization.serviceErrors.responseObjectError("400"))
                }
                
                let urlEncodedJson = jsonString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                let strURL = "\(SMConfiguration.shared.UrlNewServiceLiveness)/client/?is_webview=true&params=\(urlEncodedJson!)"
                if #available(iOS 14.3, *) {
                    if let url = URL(string: strURL) {
                        let LivenessWebViewController = LivenessWebViewController(url: url)
                        LivenessWebViewController.delegate = self
                        LivenessWebViewController.modalPresentationStyle = .fullScreen
                        coordinator?.showScreenViewController(viewController: LivenessWebViewController)
                    }
                }
                else {
                    let safariVC = SFSafariViewController(url: URL(string: strURL)!)
                    safariVC.delegate = self
                    coordinator?.showScreenViewController(viewController: safariVC)
                }
            }
        } else {
            showNoInternetViewController()
            if(firstPich){
                showTakedControls(true)
            }else{
                showTakedControls(false)
            }
        }
    }
    
    private func getImagesLoader() -> [UIImage]? {
        var images: [UIImage]? = []
        for index in 0...26 {
            if let image = UIImage(named: "loaderFrame-\(index)",
                                   in: classBundle,
                                   compatibleWith: nil) {
                images?.append(image)
            }
        }
        return images
    }
    
    
    func showAttempsViewController() {
        let errorHandlerViewController = ErrorHandlerViewController(errorHandler: .Attemps)
        errorHandlerViewController.errorHandlerProtocol = self
        errorHandlerViewController.modalPresentationStyle = .fullScreen
        coordinator?.showScreenViewController(viewController: errorHandlerViewController)
    }
    
    func showNoInternetViewController() {
        let errorHandlerViewController = ErrorHandlerViewController(errorHandler: .noNetwork)
        errorHandlerViewController.errorHandlerProtocol = self
        errorHandlerViewController.modalPresentationStyle = .fullScreen
        coordinator?.showScreenViewController(viewController: errorHandlerViewController)
    }
    
    func noCanceledUser() {
        if(countLiveness >= SMConfiguration.shared.TryLiveness){
            coordinator?.popToRootViewController()
            delegate?.completedWithResult(result: false, response: SMManager.customization.serviceErrors.responseObjectError("D"))
        }else{
            startLiveness()
        }
    }
    
    func postFaceNewLiveness(messageJson: ResponseCapture) {
        viewModel?.registerLogWithExceptionType(type: .successLiveness, device: deviceName)
        let imageString = messageJson.stages[0].payload?.images?.face_image
        self.faceImage = convertBase64StringToImage(imageBase64String: imageString!)
        showTakedControls(true)
        SMConfiguration.shared.captureAttempt = SMConfiguration.shared.TryLiveness
        firstPich = true
    }
    
    func postFailureNewLiveness(messageJson: NoSuccessResponse) {
        var message = ""
        switch messageJson.code {
        case 400:
            message = SMManager.customization.liveness.delegateMessage.abortFailed
        case 401, 403:
            message = SMManager.customization.liveness.delegateMessage.abortUserCanceled
            if(!SMConfiguration.shared.validation){
                self.isEnroll()
                return
            }else{
                self.visibleItems(state: false)
                return
            }
        case 404:
            message = SMManager.customization.liveness.delegateMessage.abortConnectionError
            self.showNoInternetViewController()
        case 408, 504, 1006:
            message = SMManager.customization.liveness.delegateMessage.abortTimeout
        case 500:
            message = SMManager.customization.liveness.delegateMessage.abortServerError
        case .none, .some(_):
            break
        }
        SMConfiguration.shared.captureAttempt -= 1
        SMConfiguration.shared.errorLivenessRegisterLog = message
        viewModel?.registerLogWithExceptionType(type: .errorLiveness, device: deviceName)
        if SMConfiguration.shared.captureAttempt == 0 {
            showAttempsViewController()
        }
        if(!SMConfiguration.shared.validation){
            openLiveness()
        }else{
            visibleItems(state: false)
        }
    }
    
    func convertBase64StringToImage (imageBase64String:String) -> UIImage {
        let imageData = Data.init(base64Encoded: imageBase64String, options: .init(rawValue: 0))
        let image = UIImage(data: imageData!)
        return image!
    }
}

// SFSafariViewControllerDelegate
extension FaceViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {}
    func safariViewController(_ controller: SFSafariViewController, initialLoadDidRedirectTo URL: URL) {}
    func safariViewController(_ controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {}
    func safariViewControllerWillOpenInBrowser(_ controller: SFSafariViewController) {}
}


extension FaceViewController: LivenessWebViewControllerDelegate {
    func SFVResponse(message: String) {
        guard let bodyData = message.data(using: .utf8) else { return }
        if ((try? JSONDecoder().decode(ResponseCapture.self, from: bodyData)) != nil){
            let messageJson = (try? JSONDecoder().decode(ResponseCapture.self, from: bodyData))!
            if(messageJson.status == "timeout" || messageJson.status == "failure" || (messageJson.stages.first?.payload?.score)! < SMConfiguration.shared.threshold) {
                noCanceledUser()
            }else{
                postFaceNewLiveness(messageJson: messageJson)
                return
            }
        } else {
            noCanceledUser()
        }
    }
}

//MARK:- FaceViewControllerProtocol
extension FaceViewController: FaceViewControllerProtocol {
    func noSuccessFace() {
        activityIndicatorView.isShow(false)
        pictureImagePost.alpha = 1.0
        takeAnotherPhotoButton.isHidden = false
        clearPhotoMessageLabel.isHidden = false
        messageLabel.isHidden = false
        clearPhotoMessageLabel.text = SMManager.customization.face.noSucessface
    }
    
    func tryAgainConnection() {
        showNoInternetViewController()
    }
    
    func nextScreen() {
        coordinator?.nextScreenDocViewController(delegate: self.delegate)
        hideControlsPostFace(false)
    }
    
    func fetchConfig(success: Bool) {
        if SMConfiguration.shared.getToken == "False"{
            activityIndicatorView.isShow(false)
            if(!SMConfiguration.shared.validation){
                isEnroll()
            }else{
                startButtonState(isEnable: true)
            }
        }
    }
    
    func fetchToken(success: Bool) {
        activityIndicatorView.isShow(false)
        if(!SMConfiguration.shared.validation){
            isEnroll()
        }else{
            startButtonState(isEnable: true)
        }
    }
    
    func fetchTransaction(success: Bool, response: TransactionResponse?, errorMessage: String?) {
        guard success else {
            self.coordinator?.popToRootViewController()
            self.delegate?.completedWithResult(result: true, response: response)
            return
        }
        activityIndicatorView.isShow(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.coordinator?.popToRootViewController()
            self.delegate?.completedWithResult(result: true, response: SMConfiguration.shared.ProcessResponse(response: response!))
        }
    }
}

extension FaceViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        SMConfiguration.shared.location = CLLocation(latitude: location.latitude, longitude: location.longitude)
        locationManager.stopUpdatingLocation()
    }
}

extension FaceViewController: ErrorHandlerProtocol {
    func retry(type: ErrorHandlerEnum) {
         if type == .noNetwork {
             postFace()
        }
    }
}
