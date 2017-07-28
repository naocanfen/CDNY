//
//  common.swift
//  one
//
//  Created by moon on 2017/7/17.
//  Copyright © 2017年 moon. All rights reserved.
//

import Foundation
import UIKit


//16进制颜色
func RGBColorFromHex(rgbValue: Int) -> (UIColor) {
    return UIColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0,
                   green: ((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0,
                   blue: ((CGFloat)(rgbValue & 0xFF)) / 255.0,
                   alpha: 1.0)
}


//加载webview
func initWebview(view: UIView, weburl: String){
    let webview = UIWebView(frame: view.bounds)
    let url = URL(string: weburl)
    let request = URLRequest(url: url!)
    webview.loadRequest(request)
    view.addSubview(webview)
}


//扩展uiview。 获取当前view
extension UIViewController {
    class func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return currentViewController(base: presented)
        }
        return base
    }
}
