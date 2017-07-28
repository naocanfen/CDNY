//
//  NetworkTools.swift
//  ChengDuNongYe
//
//  Created by MAC_HANMO on 2017/7/19.
//  Copyright © 2017年 MAC_HANMO. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

enum MethodType {
    case get
    case post
}


// 网络
class NetworkTools {
    
    // 获取网络数据 请求类型，访问地址，传递参数，回调结果
    class func requestData(_ type : MethodType, URLString : String, parameters : [String : Any]? = nil, finishedCallback :  @escaping (_ result : Any) -> ())
    {
        
        // 1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        // 2.发送网络请求
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            
            // 3.获取结果
            guard let result = response.result.value else {
                print(response.result.error!)
                return
            }
            
            // 4.将结果回调出去
            finishedCallback(result)
        }
    }
    
    //MARK: - POST 请求
    class func postRequest(urlString : String, params : [String : Any], success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : Error)->()) {
        
        Alamofire.request(urlString, method: HTTPMethod.post, parameters: params).responseJSON { (response) in
            switch response.result{
            case .success:
                if let value = response.result.value as? [String: AnyObject] {
                    success(value)
                    let json = JSON(value)
                    print(json)
                }
            case .failure(let error):
                failture(error)
                print("error:\(error)")
            }
            
        }
    }
    
    
    
    //MARK: - 照片上传
    ///
    /// - Parameters:
    ///   - urlString: 服务器地址
    ///   - params: ["flag":"","userId":""] - flag,userId 为必传参数
    ///        flag - 666 信息上传多张  －999 服务单上传  －000 头像上传
    ///   - data: image转换成Data 图片数据集
    ///   - success: 回调（成功）
    ///   - failture:回调（失败）
    class func requestUpload(url: String, params: [String: String], data: [Data], success: @escaping(_ response: [String: AnyObject])->(), fail:@escaping(_ error: Error) -> ()){
        
        let headers = ["content-type":"multipart/form-data"]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            //多张图片上传
            let flag = params["flag"]
            let userId = params["userId"]
            
            multipartFormData.append((flag?.data(using: String.Encoding.utf8)!)!, withName: "flag")
            multipartFormData.append( (userId?.data(using: String.Encoding.utf8)!)!, withName: "userId")
            
            for i in 0..<data.count{
                //设置图片的名字
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyyMMddHHmmss"
                let string = formatter.string(from: Date())
                let filename = "\(string).jpg"
                multipartFormData.append(data[i], withName: "img", fileName: filename, mimeType: "image/jpeg")
            }
        }, to: url, headers: headers, encodingCompletion:{ encodingResult in
            
            print(encodingResult)
            switch encodingResult{
            case .success(request: let upload,_,_):
                upload.responseJSON(completionHandler: { (response) in
                    if let value = response.result.value as? [String : AnyObject]{
                        success(value)
                    }
                })
            case .failure(let error):
                fail(error)
            }
        })
    }
    
    
}
