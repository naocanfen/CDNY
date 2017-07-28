//
//  CollectionViewCell.swift
//  ChengDuNongYe
//
//  Created by MAC_HANMO on 2017/7/21.
//  Copyright © 2017年 MAC_HANMO. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var image :UIImageView?
    var imageDelete:UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        image = UIImageView(image: UIImage.init(named: "photo"));
        image?.frame = CGRect(x: 10, y: 10, width:80, height: 80);
        //imageDelete.s
        self.addSubview(image!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
       fatalError("初始化 失败")
    }
    
}
