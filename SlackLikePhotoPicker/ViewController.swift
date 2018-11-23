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
        self.photoAssets = AssetsAccessor.loadPHAssets()
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

