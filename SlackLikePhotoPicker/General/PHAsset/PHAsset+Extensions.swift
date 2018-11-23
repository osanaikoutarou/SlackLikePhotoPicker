//
//  PHAsset+Extensions.swift
//  SlackLikePhotoPicker
//
//  Created by 長内幸太郎 on 2018/11/23.
//  Copyright © 2018年 osanai. All rights reserved.
//

import Foundation
import Photos

extension PHAsset {
    func createThumbnail(size:CGSize) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: self, targetSize: size, contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
            thumbnail = result!
        })
        return thumbnail
    }
}
extension UIImageView {
    func setImage(with phasset:PHAsset) {
        self.setImage(with: phasset, imgSize: bounds.size)
    }
    func setImage(with phasset:PHAsset, imgSize:CGSize) {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        option.isSynchronous = true
        manager.requestImage(for: phasset,
                             targetSize: imgSize,
                             contentMode: .aspectFit,
                             options: option,
                             resultHandler: {(result, info)->Void in
                                self.image = result!
        })
    }
    
}
