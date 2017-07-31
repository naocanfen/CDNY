//
//  AgriBasicInfo.swift
//  ChengDuNongYe
//
//  Created by MAC_HANMO on 2017/7/28.
//  Copyright © 2017年 MAC_HANMO. All rights reserved.
//

import UIKit

class AgriBasicInfo: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

//  提供快读创建的类方法
extension AgriBasicInfo{
    
    class func AgriBasicInfoView() -> AgriBasicInfo{
        return Bundle.main.loadNibNamed("AgriBasicInfo", owner: nil, options: nil)!.first as! AgriBasicInfo
        
    }
    
}
