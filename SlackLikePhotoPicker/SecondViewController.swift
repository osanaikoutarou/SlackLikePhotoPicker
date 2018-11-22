//
//  SecondViewController.swift
//  SlackLikePhotoPicker
//
//  Created by osanai on 2018/11/19.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var targetImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.addTap(target: self, action: #selector(didTap))
    
        keyboardInformationSetup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let v = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 50))
        v.backgroundColor = .red
        let vv = CustomInputView.init(frame: CGRect(origin: .zero, size: KeyboardInformation.shared.kbSize))
        textView.inputView = vv
        
        vv.setup(parentViewController: self,didSelectImage: { image in
            self.targetImageView.image = image
        })
        
        textView.inputAccessoryView = v

    }
    
    @objc func didTap() {
        self.view.endEditing(true)
    }

}
