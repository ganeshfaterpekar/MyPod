//
//  StubData.swift
//  ProtocolsSDK
//
//  Created by ganesh faterpekar on 8/29/19.
//  Copyright © 2019 ganesh faterpekar. All rights reserved.
//

import Foundation

class StubData {
    static let sharedInstance = StubData()
    
    private init() {}
    
    func loadData() -> [SampleTipData] {
        var data1 = SampleTip();
        data1.vcName = "ViewController"
        data1.tipBGColor = "#DD5B37"
        
        var data2 = SampleTip();
        data2.vcName = "SecondViewController"
        data2.tipBGColor = "#F5E0B7"
        
        return [data1,data2]
    }
}

protocol StubDataGenerator {
    func generateData(type : String) -> [SampleTipData]
}

extension StubDataGenerator {
    func generateData(type : String) -> [SampleTipData] {
        return StubData.sharedInstance.loadData()
    }
}

protocol SampleTipData {
    var vcName : String? { get set }
    var tipBGColor : String? { get set }
}

struct SampleTip : SampleTipData {
    var vcName: String?
    var tipBGColor: String?
}
