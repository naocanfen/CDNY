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
    
}

// 定义一个模型 该模型实现SwiftJavaScriptDelegate协议
@objc class SwiftJavaScriptModel: NSObject, SwiftJavaScriptDelegate {
    
    weak var controller: MainWebviewController?
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
        
        NetworkTools.requestData(.get, URLString: "http://httpbin.org/get", parameters: nil) { (result) in
            print(result)
            
            //基本页面跳转
            //从堆栈移除，实现返回上一级
            //let firstViewController = FirstViewController()
            //self.navigationController?.popViewControllerAnimated(true)
            // 获得视图控制器中的某一视图控制器
            //let viewController = self.navigationController?.viewControllers[0]
            //self.navigationController?.popToViewController(viewController as! UIViewController, animated: true)
            //返回根视图
            //self.navigationController?.popToRootViewControllerAnimated(true)         
        }
        
        //将视图入栈，实现左右跳转
        let homeview = HomeViewController()
        if self.controller?.navigationController == nil{
            print("nil")
        }
        else{
            self.controller?.navigationController?.pushViewController(homeview, animated: true)
        }
    }
}



//
class MainWebviewController: UIViewController, UIWebViewDelegate {
    
    var webView: UIWebView!
    var jsContext: JSContext!
    
    //@IBOutlet weak var test: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //添加webview
        addWebView()
        
        //
        
        //test.addTarget(self, action: #selector(toView), for:.touchUpInside)
    }
    
    //添加webview
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
    
    //
    
    func toView(){
        let homeview = HomeViewController()
        if self.navigationController == nil {
            print("is nil")
        }
        self.navigationController!.pushViewController(homeview, animated: true)
    }
    
    //
    override func viewWillAppear(_ animated: Bool){
        //self.navigationController?.navigationBar.backgroundColor = RGBColorFromHex(rgbValue: 0x11CD6E)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool){
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
