//
//  abc.swift
//  EAProductDemo
//
//  Created by Aye on 2025/7/11.
//

import Foundation
import WatchConnectKit;
import UIKit


@objc(EAHisConnectManager)
class EAHisConnectManager: NSObject {
   
    var watchConnect: WatchConnectEngine? = nil
    var selectedDevice: Device? = nil
    
    @objc static let sharedInstance = EAHisConnectManager()
    

    @objc private override init() {
        super.init()
        self.watchConnect = WatchConnectEngine()
        print("单例初始化完成")
    }
    
    
 
}



