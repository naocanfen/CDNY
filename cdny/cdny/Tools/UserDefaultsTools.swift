//
//  UserDefaultsTools.swift
//  ChengDuNongYe
//
//  Created by MAC_HANMO on 2017/7/19.
//  Copyright © 2017年 MAC_HANMO. All rights reserved.
//

import UIKit

// 本地文件
class UserDefaultsTools{

    // 保存，或修改
    class func saveInfo(_ name:String,_ key:String)
    {
        if (0 <= name.characters.count)
        {
            let userDefault = UserDefaults.standard
            userDefault.set(name, forKey: key)
            userDefault.synchronize()
            
//            let alert = UIAlertView(title: "温馨提示", message: "保存成功", delegate: nil, cancelButtonTitle: "知道了")
//            alert.show()
        }
    }
    
    // 读取
    class func readInfo(_ key:String) -> String
    {
        let userDefault = UserDefaults.standard
        let name = userDefault.object(forKey: key) as? String
        if (name != nil)
        {
            return name!
        }
        
        return "-1"
    }
}
