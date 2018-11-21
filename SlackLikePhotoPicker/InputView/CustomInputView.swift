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
    var photoAssets:[PHAsset] = []

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!

    var parentViewController:UIViewController?
    var imagePickerCamera = ImagePickerCamera()
    var imagePickerPhotoLibrary = ImagePickerPhotoLibrary()
    
    func setup(parentViewController:UIViewController) {
        self.parentViewController = parentViewController
    }
    
    // 初期化後
    override func afterInit() {
//        nameLabel.text = "テスト"
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: "ImageCollectionViewCell")
        collectionView.register(UINib(nibName: "CustomInputCollectionReusableView", bundle: nil),
                                forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                                withReuseIdentifier: "CustomInputCollectionReusableView")
        
        photoAssets = AssetsAccessor.loadPHAssets()
        
        bottomConstraint.constant = (UIApplication.shared.keyWindow?.safeAreaInsets.bottom)!
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 80, height: collectionView.bounds.height - 5)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CustomInputCollectionReusableView", for: indexPath) as! CustomInputCollectionReusableView
            
            header.tappedCameraAction = {
                if let parentViewController = self.parentViewController {
                    self.imagePickerCamera.open(in: parentViewController, completion: { (image) in
                        if let image = image {
                            print("\(image)")
                        }
                        else {
                            print("😎")
                        }
                    })
                }
            }
            header.tappedAlbumAction = {
                if let parentViewController = self.parentViewController {
                    self.imagePickerPhotoLibrary.open(in: parentViewController, completion: { (image) in
                        if let image = image {
                            print("\(image)")
                        }
                        else {
                            print("😎")
                        }
                    })
                }
            }
            
            return header
        }
        
        return UICollectionReusableView()
    }
}
