//
//  ViewController.swift
//  SlackLikePhotoPicker
//
//  Created by osanai on 2018/11/15.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {

    var photoAssets:[PHAsset] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getP()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getP() {
        // 画像をすべて取得
        let assets: PHFetchResult = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
        assets.enumerateObjects { (phasset:PHAsset, index, stop:UnsafeMutablePointer<ObjCBool>) in
            print("🙂")
            print(phasset)
            self.photoAssets.append(phasset)
        }
        
    }

}

