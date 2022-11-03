//
//  SMDelegate.swift
//  SMSDK
//
//  Created by Fernando León on 3/26/20.
//  Copyright © 2020 Fernando León. All rights reserved.
//

import Foundation

public protocol SMDelegate: AnyObject {
    func completedWithResult(result: Bool, response: TransactionResponse?)
}
