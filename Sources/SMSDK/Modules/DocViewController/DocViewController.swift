import UIKit
import ScanovateManualCapture

protocol DocViewControllerProtocol: AnyObject {
    func takeBackSide()
    func successClose(response: TransactionResponse?)
    func failedWithError(success: Bool, response: TransactionResponse, error: String)
}

protocol DocViewControllerDelegate: AnyObject {
    func showScreenViewController(viewController: UIViewController)
    func nextScreenFaceViewController(delegate: SMDelegate, params: SMParams)
    func popToRootViewController()
}

class DocViewController: UIViewController, SNManualCaptureVCDelegate {
    
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
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont(name: ConstantsUi.Font.semiBold, size: 26)
        titleLabel.textColor = ConstantsUi.Colors.black
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
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
    
    private lazy var captureDocumentImageView: UIImageView = {
        let documentImageView = UIImageView()
        documentImageView.contentMode = .scaleAspectFit
        documentImageView.translatesAutoresizingMaskIntoConstraints = false
        return documentImageView
    }()
    
    private lazy var documentImageView: UIImageView = {
        let documentImageView = UIImageView()
        documentImageView.contentMode = .scaleAspectFit
        documentImageView.translatesAutoresizingMaskIntoConstraints = false
        return documentImageView
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
    
    //MARK: Vars
    var delegate: SMDelegate?
    var smParams: SMParams?
    var viewModel: DocViewModelProtocol?
    var continueType: DocumentContinueButtonType = .takeFront
    var classBundle = Bundle.module
    weak var coordinator: DocViewControllerDelegate?
    
    init(delegate: SMDelegate?) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
        self.smParams = .init(
            documentType: SMConfiguration.shared.documentType,
            productId: SMConfiguration.shared.productId,
            projectName: SMConfiguration.shared.projectName,
            apiKey: SMConfiguration.shared.apiKey,
            urlSdk: SMConfiguration.shared.urlSdk,
            identification: SMConfiguration.shared.identification,
            validation: SMConfiguration.shared.validation,
            userName: SMConfiguration.shared.userName,
            password: SMConfiguration.shared.password
        )
        viewModel = DocViewModel()
        viewModel?.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.title = ""
        let rightBarButtonItem = UIBarButtonItem.init(
            image: ConstantsUi.Images.iconClose,
            style: .done,
            target: self,
            action: #selector(closeSDK)
        )
        rightBarButtonItem.tintColor = ConstantsUi.Colors.grayDark
        navigationItem.rightBarButtonItem = rightBarButtonItem
        let LeftBackBarButtonItem = UIBarButtonItem.init(
            image: ConstantsUi.Images.iconBack,
            style: .done,
            target: self,
            action: #selector(back)
        )
        LeftBackBarButtonItem.tintColor = ConstantsUi.Colors.blue
        navigationItem.leftBarButtonItem = LeftBackBarButtonItem
        setupView()
        setupUi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    
    private func setupView() {
        setupContentView()
        setupTakeAnotherPhotoButton()
        setupLetsDoItButton()
        setupStackView()
        setupActivityIndicator()
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(messageLabel)
        stackView.addArrangedSubview(captureDocumentImageView)
        stackView.addArrangedSubview(documentImageView)
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
        captureDocumentImageView.image = ConstantsUi.Images.frontId
        captureDocumentImageView.isHidden = false
        documentImageView.isHidden = true
        takeAnotherPhotoButton.setTitle(SMManager.customization.document.takeAnotherPhotoButton, for: .normal)
        takeAnotherPhotoButton.addTarget(self, action: #selector(takeAnotherPhotoAction), for: .touchUpInside)
        letsDoItButton.setTitle(SMManager.customization.document.startButton, for: .normal)
        letsDoItButton.addTarget(self, action: #selector(letsDoIt), for: .touchUpInside)
        titleLabel.text = SMManager.customization.document.titleCaptureLabel
        messageLabel.text = SMManager.customization.document.frontMessageLabel
        activityIndicatorView.isShow(false)
        showTakedControls(false)
    }
    
    @objc func closeSDK(sender: AnyObject) {
        self.coordinator?.popToRootViewController()
        self.delegate?.completedWithResult(result: true, response: SMManager.customization.serviceErrors.responseObjectError("G"))
    }
    
    func manualCaptureSucceeded(_ captureVC: SNManualCaptureVC, frontSideImage: UIImage, backSideImage: UIImage?) {
        documentImageView.image = frontSideImage
        captureDocumentImageView.isHidden = true
        documentImageView.isHidden = false
        self.dismiss(animated: true, completion: nil)
        continueType == .uploadFront ? continueType = .takeFront : continueType == .uploadBack ? continueType = .takeBack : nil
        showInvalidRegistrationView(false, isFront: continueType == .takeFront)
        letsDoItButton.isEnabled = true
        letsDoItButton.isUserInteractionEnabled = true
        viewModel?.registerLogWithExceptionType(type: continueType == .takeBack ? .endBack : .endFront, device: deviceName)
        showTakedControls(true)
        titleLabel.text = SMManager.customization.document.clearDocumentTitleMessage
        messageLabel.text = SMManager.customization.document.clearDocumentMessage
        continueType == .takeFront ? continueType = .uploadFront : continueType == .takeBack ? continueType = .uploadBack : nil
    }
    
    func manualCaptureAborted(_ captureVC: SNManualCaptureVC, reason: SNManualCapturerAbortReason) {
        self.dismiss(animated: true, completion: nil);
        
        if (self.continueType == .takeFront){
            self.continueType = .takeFront
            captureDocumentImageView.image = ConstantsUi.Images.frontId
        } else {
            captureDocumentImageView.image = ConstantsUi.Images.sideId
        } 
        
        if (self.continueType == .takeFront){
            captureDocumentImageView.isHidden = false
        } else if (self.continueType == .uploadFront) {
            self.continueType = .uploadFront
        }

        if (self.continueType == .takeBack){
            self.continueType = .takeBack
            captureDocumentImageView.isHidden = false
        } else if (self.continueType == .uploadBack) {
            self.continueType = .uploadBack
        }
        
        letsDoItButton.isEnabled = true
        letsDoItButton.isUserInteractionEnabled = true
    }
    
    override open var shouldAutorotate: Bool {
        get {
            return true
        }
    }
    
    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        get {
            return .portrait
        }
    }
    
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        get {
            return .portrait
        }
    }
    
    private func showTakedControls(_ state: Bool) {
        takeAnotherPhotoButton.isHidden = !state
        takeAnotherPhotoButton.isUserInteractionEnabled = state
    }
    
    @objc func back(sender: AnyObject) {
        if(continueType == .takeBack) {
            continueType = .takeFront
            documentImageView.isHidden = false
            captureDocumentImageView.isHidden = true
            titleLabel.text = SMManager.customization.document.clearDocumentTitleMessage
            messageLabel.text = SMManager.customization.document.clearDocumentMessage
            showTakedControls(true)
            letsDoItButton.setTitle(SMManager.customization.document.continueButton, for: .normal)
        }
        else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func scanDoc(backSide: Bool) {
        viewModel?.registerLogWithExceptionType(type: backSide ? .startBack : .startFront, device: deviceName)
        DispatchQueue.main.async {
            self.startScanForService(backSide: backSide)
        }
    }
    
    private func startScanForService(backSide: Bool) {
        OperationQueue.main.addOperation {
            let mcVC = SNManualCaptureVC()
            mcVC.delegate = self
            if self.continueType == .takeBack || self.continueType == .uploadBack {
                mcVC.uiCustomization.captureFrontInstructionsText = SMConfiguration.shared.uiManualCapture.CaptureBackInstructionsText!
                mcVC.uiCustomization.isFrontSide = false
                mcVC.uiCustomization.instructionsPosition = .top
            } else {
                mcVC.uiCustomization.captureFrontInstructionsText = SMConfiguration.shared.uiManualCapture.CaptureFrontInstructionsText!
                mcVC.uiCustomization.isFrontSide = true
                mcVC.uiCustomization.instructionsPosition = .bottom
            }
            mcVC.uiCustomization.backArrowColor = UIColor(hexString: SMColor.prepareColor(color: SMConfiguration.shared.uiManualCapture.BackArrowColor!))
            mcVC.uiCustomization.instructionsColor = UIColor(hexString: SMColor.prepareColor(color: SMConfiguration.shared.uiManualCapture.InstructionsColor!))
            mcVC.uiCustomization.instructionsBackgroundColor = UIColor(hexString: SMColor.prepareColor(color: SMConfiguration.shared.uiManualCapture.InstructionsBackgroundColor!))
            mcVC.uiCustomization.mainColor = UIColor(hexString: SMColor.prepareColor(color: SMConfiguration.shared.uiManualCapture.MainColor!))
            mcVC.uiCustomization.backArrowShape = SMConfiguration.shared.uiManualCapture.BackArrowShape == 1 ? .x : .arrowHeadAndTail
            mcVC.uiCustomization.backArrowSide = SMConfiguration.shared.uiManualCapture.BackArrowSide == 1 ? .left : .right
            mcVC.uiCustomization.instructionsFont = UIFont.init(name: "Gilroy-SemiBold", size: 14)
            self.coordinator?.showScreenViewController(viewController: mcVC)
        }
    }
    
    private func postImage(backSide: Bool) {
        if SMConnectionService.isConnectedToInternet(){
            activityIndicatorView.isShow(true)
            viewModel?.continueButton(isFrontal: continueType == .uploadFront, base64image: documentImageView.image?.encodeToBase64String)
            letsDoItButton.isHidden = false
            letsDoItButton.isUserInteractionEnabled = false
            letsDoItButton.setTitle(SMManager.customization.document.continueButton, for: .normal)
            takeAnotherPhotoButton.isHidden = false
            takeAnotherPhotoButton.isUserInteractionEnabled = false
        }else{
            showNoInternetViewController()
        }
    }
    
    private func showInvalidRegistrationView(_ state: Bool, isFront: Bool) {
        messageLabel.isHidden = state
        titleLabel.text = SMManager.customization.document.clearDocumentTitleMessage
        messageLabel.text = SMManager.customization.document.clearDocumentMessage
        letsDoItButton.setTitle(state ? SMManager.customization.document.scanAgain : SMManager.customization.document.continueButton, for: .normal)
    }
    
    @objc func takeAnotherPhotoAction(sender: UIButton!) {
        scanDoc(backSide: continueType == .takeBack)
    }
    
    @objc func letsDoIt(sender: UIButton!) {
        switch continueType {
        case .takeFront, .takeBack:
            letsDoItButton.isEnabled = false
            scanDoc(backSide: continueType == .takeBack)
        case .uploadFront, .uploadBack:
            postImage(backSide: continueType == .takeBack)
            if continueType == .uploadBack {
                let loaderViewController = LoaderViewController()
                loaderViewController.modalPresentationStyle = .fullScreen
                coordinator?.showScreenViewController(viewController: loaderViewController)
            }
        }
    }
    
    func showNoInternetViewController() {
        let errorHandlerViewController = ErrorHandlerViewController(errorHandler: .noNetwork)
        errorHandlerViewController.errorHandlerProtocol = self
        errorHandlerViewController.modalPresentationStyle = .fullScreen
        coordinator?.showScreenViewController(viewController: errorHandlerViewController)
    }
}

//MARK:- DocViewControllerDelegate
extension DocViewController: DocViewControllerProtocol {
    func takeBackSide() {
        activityIndicatorView.isShow(false)
        letsDoItButton.setTitle(SMManager.customization.document.startButton, for: .normal)
        letsDoItButton.isHidden = false
        letsDoItButton.isUserInteractionEnabled = true
        titleLabel.text = SMManager.customization.document.titleCaptureLabel
        messageLabel.text = SMManager.customization.document.backMessageLabel
        captureDocumentImageView.image = ConstantsUi.Images.sideId
        captureDocumentImageView.isHidden = false
        documentImageView.isHidden = true
        continueType = .takeBack
        showTakedControls(false)
    }
    
    func successClose(response: TransactionResponse?) {
        activityIndicatorView.isShow(false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.dismiss(animated: true)
            self.coordinator?.popToRootViewController()
            self.delegate?.completedWithResult(result: true, response: SMConfiguration.shared.ProcessResponse(response: response!))
        }
    }
    
    func failedWithError(success: Bool, response: TransactionResponse ,error: String) {
        self.coordinator?.popToRootViewController()
        self.delegate?.completedWithResult(result: true, response: SMConfiguration.shared.ProcessResponse(response: response))
        activityIndicatorView.isShow(true)
        letsDoItButton.isHidden = false
        letsDoItButton.isUserInteractionEnabled = true
        takeAnotherPhotoButton.isHidden = false
        takeAnotherPhotoButton.isUserInteractionEnabled = true
    }
}

extension DocViewController: ErrorHandlerProtocol {
    func retry(type: ErrorHandlerEnum) {
        if type == .noNetwork {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
