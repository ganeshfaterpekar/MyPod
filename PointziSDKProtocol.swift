//
//  PointziSDKProtocol.swift
//  ProtocolsSDK
//
//  Created by ganesh faterpekar on 8/27/19.
//  Copyright © 2019 ganesh faterpekar. All rights reserved.
//

import Foundation
import UIKit

protocol PointziSDKProtocol {
    typealias DidFetchTipDataCompletion = (Data?, Error?) -> Void
    func showWidget(feeds : [SampleTipData])
    func hideWidget()
    func refreshWidget()
    func test(resp : String , closure:(Data?,Error?) -> Void)
}

//https://code.tutsplus.com/tutorials/creating-your-first-cocoapod--cms-24332
extension PointziSDKProtocol where Self : UIViewController {
    
    func showWidget(feeds: [SampleTipData]) {
        print("Controller Name \(String(describing: self.classForCoder))")
        print("showWidget")
    
        for feed in feeds {
            if feed.vcName == String(describing: self.classForCoder) {
                self.view.backgroundColor = hexStringToUIColor(hex: feed.tipBGColor!)
                break;
            }
        }
    }
    
    func hideWidget() {
        print("hideWidget")
    }
    
    func refreshWidget() {
        print("refreshWidget")
    }
    
    func test(resp: String, closure: (Data?, Error?) -> Void) {
       print(resp)
    }
}

extension UIViewController : PointziSDKProtocol , StubDataGenerator {
    
    @objc func newViewWillAppear(_ animated: Bool) {
        self.newViewWillAppear(animated) //Incase we need to override this method
        
        let feedData = StubData.sharedInstance.loadData()
        showWidget(feeds: feedData)
    }
    
    static func swizzleViewWillAppear() {
        //Make sure This isn't a subclass of UIViewController, So that It applies to all UIViewController childs
        if self != UIViewController.self {
            return
        }
        let _: () = {
            let originalSelector = #selector(UIViewController.viewWillAppear(_:))
            let swizzledSelector = #selector(UIViewController.newViewWillAppear(_:))
            let originalMethod = class_getInstanceMethod(self, originalSelector)
            let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
            method_exchangeImplementations(originalMethod!, swizzledMethod!);
        }()
    }
}



func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
