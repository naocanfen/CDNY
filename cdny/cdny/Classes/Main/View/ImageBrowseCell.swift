//
//  ImageBrowseCell.swift
//  ChengDuNongYe
//
//  Created by MAC_HANMO on 2017/7/26.
//  Copyright © 2017年 MAC_HANMO. All rights reserved.
//

import UIKit
import Kingfisher

class ImageBrowseCell: UICollectionViewCell {
    
   
    // 初始化控件属性
    @IBOutlet weak var imageView: UIImageView!
    
    // 定义模型数据
    var image : UIImage?{
        didSet{
//            let url = URL(string : image!)
//            imageView.kf.setImage(with: ImageResource.init(downloadURL: url!))
            imageView.image = image

        }
    }
}
