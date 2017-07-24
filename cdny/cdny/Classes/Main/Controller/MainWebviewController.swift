//
//  MainViewController.swift
//  one
//
//  Created by moon on 2017/7/13.
//  Copyright © 2017年 moon. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import JavaScriptCore

// 定义协议SwiftJavaScriptDelegate 该协议必须遵守JSExport协议
@objc protocol SwiftJavaScriptDelegate: JSExport {
    
    //资源采集
    func toCompany()
    //监测上报
    func toSoil()
    //企业登记
    func toCustom()
    //信息管理
    func toInfoManage()
    //地图
    func toMap()
    
    // js调用App方法时传递多个参数 并弹出对话框 注意js调用时的函数名
    func showDialog(_ title: String, message: String)
    
    // js调用App的功能后 App再调用js函数执行回调
    func callHandler(_ handleFuncName: String)
    
}

// 定义一个模型 该模型实现SwiftJavaScriptDelegate协议
@objc class SwiftJavaScriptModel: NSObject, SwiftJavaScriptDelegate {
    
    weak var controller: UIViewController?
    weak var jsContext: JSContext?
    
    ////资源采集
    func toCompany(){
        
    }
    //监测上报
    func toSoil(){
        
    }
    //企业登记
    func toCustom(){
        
    }
    //信息管理
    func toInfoManage(){
        
    }
    //地图
    func toMap(){
        print("map")
    }
    
    func showDialog(_ title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
        self.controller?.present(alert, animated: true, completion: nil)
    }
    
    func callHandler(_ handleFuncName: String) {
        
        let jsHandlerFunc = self.jsContext?.objectForKeyedSubscript("\(handleFuncName)")
        let dict = ["name": "sean", "age": 18] as [String : Any]
        let _ = jsHandlerFunc?.call(withArguments: [dict])
    }
}


class MainWebviewController: UIViewController, UIWebViewDelegate {
    
    var webView: UIWebView!
    var jsContext: JSContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        //addWebView()
    }
    
    func addWebView() {
        
        self.webView = UIWebView(frame: self.view.bounds)
        self.view.addSubview(self.webView)
        self.webView.delegate = self
        self.webView.scalesPageToFit = true
        
        // 加载本地Html页面
        //let url = Bundle.main.url(forResource: "demo", withExtension: "html")
        //let request = URLRequest(url: url!)
        
        // 加载网络Html页面 请设置允许Http请求
        let url = URL(string: homeurl);
        let request = URLRequest(url: url!)
        self.webView.loadRequest(request)
    }
    
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        
        self.jsContext = webView.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as! JSContext
        let model = SwiftJavaScriptModel()
        model.controller = self
        model.jsContext = self.jsContext
        
        // 这一步是将SwiftJavaScriptModel模型注入到JS中，在JS就可以通过WebViewJavascriptBridge调用我们暴露的方法了。
        self.jsContext.setObject(model, forKeyedSubscript: "WebViewJavascriptBridge" as NSCopying & NSObjectProtocol)
        
        // 注册到本地的Html页面中
        //let url = Bundle.main.url(forResource: "demo", withExtension: "html")
        //self.jsContext.evaluateScript(try? String(contentsOf: url!, encoding: String.Encoding.utf8))
        
        // 注册到网络Html页面 请设置允许Http请求
        //let url = "http://www.mayanlong.com";
        let curUrl = self.webView.request?.url?.absoluteString    //WebView当前访问页面的链接 可动态注册
        self.jsContext.evaluateScript(try? String(contentsOf: URL(string: curUrl!)!, encoding: String.Encoding.utf8))
        
        self.jsContext.exceptionHandler = { (context, exception) in
            print("exception：", exception as Any)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
