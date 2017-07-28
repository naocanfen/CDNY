//
//  ImageBrowseViewController.swift
//  ChengDuNongYe
//
//  Created by MAC_HANMO on 2017/7/10.
//  Copyright © 2017年 MAC_HANMO. All rights reserved.
//

import UIKit


class ImageBrowseViewController: UIView{
    
}

extension ImageBrowseViewController{

    class func imageBrowseView() -> ImageBrowseViewController{
        return Bundle.main.loadNibNamed("ImageBrowseViewController", owner: nil, options: nil)!.first as!ImageBrowseViewController
    
    }

}
