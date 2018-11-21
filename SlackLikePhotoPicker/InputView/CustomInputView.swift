//
//  CustomInputView.swift
//  SlackLikePhotoPicker
//
//  Created by osanai on 2018/11/19.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit
import Photos

class CustomInputView: UINibView {
    @IBOutlet weak var collectionView: UICollectionView!
    var photoAssets:[PHAsset] = []
    
    // 初期化後
    override func afterInit() {
//        nameLabel.text = "テスト"
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        
        photoAssets = AssetsAccessor.loadPHAssets()
    }
}

extension CustomInputView:UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoAssets.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let phasset = self.photoAssets[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        //        cell.imgView.image = getAssetThumbnail(asset: phasset)
        cell.imageView.setImage(with: phasset, imgSize: CGSize(width: 250, height: 250))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.height/2.0 - 2
        return CGSize(width: width, height: width)
    }
}
