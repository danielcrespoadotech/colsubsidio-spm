//
//  MainCoordinator.swift
//  
//
//  Created by Daniel Crespo Duarte on 20/10/22.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start(delegate: SMDelegate, params: SMParams)
}

public class MainCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    let parentViewController: UIViewController
    
    public init(navigationController: UINavigationController,
                parentViewController: UIViewController) {
        self.navigationController = navigationController
        self.parentViewController = parentViewController
    }
    
    func start(delegate: SMDelegate, params: SMParams) {
        let validateViewController = ValidateViewController(delegate: delegate, params: params)
        validateViewController.coordinator = self
        navigationController.pushViewController(validateViewController, animated: true)
    }
    
}

extension MainCoordinator: FaceViewControllerDelegate, DocViewControllerDelegate, ValidateViewControllerProtocol {
    
    func showScreenViewController(viewController: UIViewController) {
        navigationController.present(viewController, animated: true)
    }
    
    func showAlertController(alertController: UIAlertController) {
        navigationController.present(alertController, animated: true)
    }
    
    func showSafariViewController(safariViewController safariController: UIViewController) {
        navigationController.present(safariController, animated: true, completion: nil)
    }
    
    func nextScreenDocViewController(delegate: SMDelegate?) {
        let docViewController = DocViewController(delegate: delegate)
        docViewController.coordinator = self
        navigationController.pushViewController(docViewController, animated: true)
    }
    
    func goBackScreen() {
        navigationController.popViewController(animated: true)
    }

    func popToRootViewController() {
        navigationController.popToViewController(of: type(of: parentViewController), animated: true)
    }
    
    func nextScreenFaceViewController(delegate: SMDelegate, params: SMParams) {
        let faceViewController = FaceViewController(delegate: delegate, params: params)
        faceViewController.coordinator = self
        navigationController.pushViewController(faceViewController, animated: true)
    }
    
}
