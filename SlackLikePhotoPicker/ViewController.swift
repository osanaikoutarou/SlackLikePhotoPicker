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

    @IBOutlet weak var collectionView: UICollectionView!
    var photoAssets:[PHAsset] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getP()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func getP() {
        // 画像をすべて取得
        let assets: PHFetchResult = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
        assets.enumerateObjects { (phasset:PHAsset, index, stop:UnsafeMutablePointer<ObjCBool>) in
            print("🙂")
            print(phasset)
            self.photoAssets.append(phasset)
        }
        print("🤔 \(self.photoAssets.count)")
    }

}

extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoAssets.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let phasset = self.photoAssets[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImgCollectionViewCell", for: indexPath) as! ImgCollectionViewCell
//        cell.imgView.image = getAssetThumbnail(asset: phasset)
        cell.imgView.setImage(with: phasset, imgSize: CGSize(width: 300, height: 300))
        return cell
    }
    
}

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
