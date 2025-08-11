//
//  EAMakeHisWatchFace.swift
//  EAProductDemo
//
//  Created by Aye on 2025/7/31.
//

import UIKit

@objc class EAMakeHisWatchFace: NSObject {

    @objc public func eaMake(image:UIImage ,isBg:Bool)  {
        
        let hisCompress = EAHisCompress()
        hisCompress.compress(image: image,isBg: isBg)
    }
    
}
