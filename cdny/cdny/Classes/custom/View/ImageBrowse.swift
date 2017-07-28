//
//  ImageBrowse.swift
//  ChengDuNongYe
//
//  Created by MAC_HANMO on 2017/7/26.
//  Copyright © 2017年 MAC_HANMO. All rights reserved.
//

import UIKit

private let imageID  = "imageID"

class ImageBrowse: UIView {

    // 控件属性
    @IBOutlet weak var collectonView: UICollectionView!
    
    // 图片数据集
    var imagesArray:[UIImage]?{
        
        didSet{
            
            // 数据刷新
            collectonView.reloadData();
        }
    }
  
 
    // 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 注册cell
        
        collectonView.register(UINib(nibName: "ImageBrowseCell", bundle: nil), forCellWithReuseIdentifier: imageID)
        
        //collectonView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: imageID)
        
    }
    
}

//  提供快读创建的类方法
extension ImageBrowse{
    
    class func imageBrowseView() -> ImageBrowse{
        return Bundle.main.loadNibNamed("ImageBrowse", owner: nil, options: nil)!.first as! ImageBrowse
        
    }
    
}

// 遵守数据源协议
extension ImageBrowse : UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return imagesArray?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectonView.dequeueReusableCell(withReuseIdentifier: imageID, for: indexPath) as! ImageBrowseCell
        
        cell.image = imagesArray![indexPath.item]
        
       // cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.yellow:UIColor.blue
        return cell
    }
}


