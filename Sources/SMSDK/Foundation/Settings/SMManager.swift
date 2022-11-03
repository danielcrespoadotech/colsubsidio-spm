//
//  Manager.swift
//  SMSDK
//
//  Created by Fernando León on 3/26/20.
//  Copyright © 2020 Fernando León. All rights reserved.
//

import UIKit

public class SMManager {
    public static let customization = SMManager()
    
    public var face = Face()
    public var document = Document()
    public var liveness = Liveness()
    var serviceErrors = ServiceError()
    
    public static func initWith(
        delegate: SMDelegate,
        params: SMParams,
        navigationController: UINavigationController,
        parentViewController: UIViewController
    ) -> MainCoordinator {
        UIFont.loadMyFonts
        navigationController.configurateNavigationBarAppereance()
        let mainCoordinator = MainCoordinator(navigationController: navigationController, parentViewController: parentViewController)
        mainCoordinator.start(delegate: delegate, params: params)
        return mainCoordinator
    }
}
