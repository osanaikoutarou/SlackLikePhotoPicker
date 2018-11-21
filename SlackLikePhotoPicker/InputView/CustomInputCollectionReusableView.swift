//
//  CustomInputCollectionReusableView.swift
//  SlackLikePhotoPicker
//
//  Created by osanai on 2018/11/21.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit

class CustomInputCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var cameraButton: ButtonView!
    @IBOutlet weak var albumButton: ButtonView!
    
    var tappedCameraAction:(() -> Void)?
    var tappedAlbumAction:(() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cameraButton.setup(type: .darkerTheWhole)
        albumButton.setup(type: .darkerTheWhole)
    }
    
    @IBAction func tappedCamera(_ sender: Any) {
        if let tappedCameraAction = tappedCameraAction {
            tappedCameraAction()
        }
    }
    @IBAction func tappedAlbum(_ sender: Any) {
        if let tappedAlbumAction = tappedAlbumAction {
            tappedAlbumAction()
        }
    }
    
}
