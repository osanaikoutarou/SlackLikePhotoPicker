//
//  AssetsAccessor.swift
//  SlackLikePhotoPicker
//
//  Created by osanai on 2018/11/20.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit
import Photos

class AssetsAccessor: NSObject {
    
//    static let shared = AssetsAccessor()
    
    static func loadPHAssets() -> [PHAsset] {
        var photoAssets:[PHAsset] = []        
        // 画像をすべて取得
        let assets: PHFetchResult = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: optionSortOrderCreateAt)
        assets.enumerateObjects { (phasset:PHAsset, index, stop:UnsafeMutablePointer<ObjCBool>) in
            photoAssets.append(phasset)
        }
        return photoAssets
    }
    
    static var optionSortOrderCreateAt:PHFetchOptions {
        let fetchOptions = PHFetchOptions()
        let sortOrder = [NSSortDescriptor(key: "creationDate", ascending: false)]
        fetchOptions.sortDescriptors = sortOrder
        return fetchOptions
    }

}

