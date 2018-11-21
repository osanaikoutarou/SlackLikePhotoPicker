//
//  ImagePickerCamera.swift
//  SlackLikePhotoPicker
//
//  Created by osanai on 2018/11/21.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit

class ImagePickerCamera: NSObject {

    let picker = UIImagePickerController()
    var image:UIImage?
    var completion:((_ image:UIImage?) -> Void)?
    
    func open(in parentVC:UIViewController, completion:@escaping ((_ image:UIImage?) -> Void)) {
        
        picker.sourceType = .camera
        picker.delegate = self
        self.completion = completion
        parentVC.present(picker, animated: true, completion: nil)
    }
}

extension ImagePickerCamera: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        if let completion = completion {
            completion(self.image)
        }
        
        picker.dismiss(animated: true) {
            print("🤓")
        }
    }
}
