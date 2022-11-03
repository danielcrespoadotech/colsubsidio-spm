//
//  LivenessWebViewController.swift
//  
//
//  Created by Daniel Crespo Duarte on 26/10/22.
//

import Foundation
import WebKit

protocol LivenessWebViewControllerDelegate: AnyObject {
    func SFVResponse(message: String)
}

class LivenessWebViewController: UIViewController {
    private struct Constants {
        static let messageHandlersName = "messageHandlersName"
        static let source = """
            window.addEventListener('message', function(e) {
                window.webkit.messageHandlers.\(messageHandlersName).postMessage(e.data);
            });
            """
    }
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var backButton: UIButton = {
        let backButton = UIButton()
        backButton.setImage(ConstantsUi.Images.iconBack, for: .normal)
        backButton.tintColor = .white
        backButton.translatesAutoresizingMaskIntoConstraints = false
        return backButton
    }()
    var webView: WKWebView?
    
    let url: URL
    weak var delegate: LivenessWebViewControllerDelegate?
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupUI()
    }
    
    private func setupView() {
        setupContentView()
        configureWebView()
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
    
    private func configureWebView() {
        let script = WKUserScript(source: Constants.source, injectionTime: .atDocumentEnd, forMainFrameOnly:  false)
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.preferences.javaScriptEnabled = true
        webConfiguration.userContentController.addUserScript(script)
        webConfiguration.allowsInlineMediaPlayback = true
        webConfiguration.userContentController.add(self, name: Constants.messageHandlersName)
        
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        if let webView = webView {
            webView.isOpaque = false
            webView.backgroundColor = .black
            webView.scrollView.backgroundColor = UIColor.black
            view.backgroundColor = .black
            let myRequest = URLRequest(url: url)
            webView.load(myRequest)
            setupWebView(webView: webView)
            setupBackButton(webView: webView)
        }
    }
    
    private func setupWebView(webView: WKWebView) {
        contentView.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: contentView.topAnchor),
            webView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setupBackButton(webView: WKWebView) {
        webView.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: webView.topAnchor, constant: 60),
            backButton.leftAnchor.constraint(equalTo: webView.leftAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func setupUI() {
        view.backgroundColor = ConstantsUi.Colors.black
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
    }
    
    @objc func backAction(sender: UIButton!) {
        self.dismiss(animated: true, completion: nil)
    }
}

// Resive callback from WKWebView
extension LivenessWebViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let message = message.body
        if let messageString: String = message as? String {
            delegate?.SFVResponse(message: messageString)
            webView?.removeFromSuperview();
            webView = nil;
            self.dismiss(animated: true, completion: nil)
        }
    }
}


