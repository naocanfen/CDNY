//
//  AddViewController.swift
//  ChengDuNongYe
//
//  Created by MAC_HANMO on 17/7/4.
//  Copyright © 2017年 MAC_HANMO. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class AddViewController: UIViewController , UINavigationControllerDelegate, UIImagePickerControllerDelegate
{

    @IBOutlet weak var photo:UIButton!
    @IBOutlet weak var scrollView : UIScrollView!
    @IBOutlet weak var uploadData: UIButton!
    
    var imagesArray:[UIImage] = []   // 图片image数据集
    var imagesData:[Data] = []       // 图片data数据集
    var imagesName:[String] = []     //
    var params:[String:String] = [:] //
    
    var picker: UIImagePickerController!
    
    let screenw = UIScreen.main.applicationFrame.size.width
    
    
    // 懒加载 自定义view
    private lazy var borwseView:ImageBrowse = {
        
        let borwseView = ImageBrowse.imageBrowseView()
        borwseView.frame = CGRect(x: 0, y: 10, width: kScreenW , height: 90)
        return borwseView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // nowk()
        self.title = "采集信息"
        // btn 点击事件  第一个参数 self相对Android的this，第二个参数 方法， 第三个参数 ？
        photo.addTarget(self,action: #selector(photoClick), for: UIControlEvents.touchDown)
        
        uploadData.addTarget(self,action: #selector(nowk), for: UIControlEvents.touchDown)
        scrollView.addSubview(borwseView)
       
       
    }
    
    
    func nowk(){
        //创建URL对象
        let url = "http://125.70.9.238:8080/sys/mobile/mobilexeccmd.ashx?sqlcmd=mps_company&c_id=&opt=ins&photo_column=c_photo&id_column=c_id&c_lng=111&c_lat=222&c_name=ios&c_cmpid=0001&c_region=1&c_town=1&c_apply=1&c_legal=1&c_linktel=1&c_address=1&c_depid=1&c_depname=1&c_createuid=1&c_createmen=1&c_claid=0019"

//        NetworkTools.requestData(.post, URLString: url){ (result) in
//            let json = JSON(result)
//
//            print("数据",json)
//        }
        
//        
//        print("ios0")
//
        params = ["flag":"666",
                  "userId":"id"]

        NetworkTools.requestUpload(url: url, params: params, data: imagesData, success: {(json) -> Void in
            
                        print("iosa")
            
                        }, fail: {(error) -> Void in
            
                        print("iosa")
                            
                    })
     
        
    }
    
    
    func photoClick(){
    
        // 创建一个图片选择器
        let picker :UIImagePickerController = UIImagePickerController()
        // 设置他为当前界面代理
        picker.delegate = self
        // 创建提示框控制器
        let actionS:UIAlertController = UIAlertController(title:"提示",message:"相册图片选择时，只能选择一张图片",preferredStyle:UIAlertControllerStyle.actionSheet)
        // 创建相册按钮
        let actioin1:UIAlertAction = UIAlertAction(title:"相册选择",style:UIAlertActionStyle.default){(action) -> Void in
            // 进入系统相册界面
            self.navigationController?.present(picker, animated: true, completion: nil)
        }
        // 创建相机按钮
        let actioin2:UIAlertAction = UIAlertAction(title:"手机拍摄",style:UIAlertActionStyle.default){(action) -> Void in
            // 判断是否可以调用摄像头
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
                // 设置图片选择类型为相机
                picker.sourceType = UIImagePickerControllerSourceType.camera
                // 进入相机拍摄界面
                self.navigationController?.present(picker,animated:true,completion:nil)
            }else{
                
                
            }
        }
        
        // 关闭
        let action:UIAlertAction = UIAlertAction(title:"取消",style:UIAlertActionStyle.cancel){(action) -> Void in}
        // 控件器添加
        actionS.addAction(actioin1)
        actionS.addAction(actioin2)
        actionS.addAction(action)
        // 显示控制器
        self.navigationController?.present(actionS,animated:true,completion:nil)


    }
    
    
    //相机（相册）图片成功后处理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
      
        //获取的图片
        let image:UIImage! = info[UIImagePickerControllerOriginalImage] as! UIImage
        let data:Data = UIImagePNGRepresentation(image)!
        
        imagesData.append(data)
        imagesName.append("image.png")
        // 显示图片
        imagesArray.append(image)
        borwseView.imagesArray = self.imagesArray
        //图片控制器退出
        picker.dismiss(animated: true,completion:nil)
    
    }
    
  

}






