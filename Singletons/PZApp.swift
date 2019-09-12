//
//  PZApp.swift
//  ProtocolsSDK
//
//  Created by ganesh faterpekar on 8/29/19.
//  Copyright © 2019 ganesh faterpekar. All rights reserved.
//

import Foundation
import UIKit


open class PZApp {
    static let shareInstance = PZApp()
    var apiKey = "";
    
    public init() {}
    
    open func initWithKey(appKey : String) {
        apiKey = appKey;
        UIViewController.swizzleViewWillAppear()
    }
}
