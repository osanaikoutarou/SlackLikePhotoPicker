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
        
        let v = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 50))
        v.backgroundColor = .red
//        textView.inputView = view
        let vv = CustomInputView.init(frame: CGRect(x: 0, y: 0, width: 375, height: 200))
//        textView.inputView = CustomInputView(frame: CGRect(x: 0, y: 0, width: 375, height: 200))
        textView.inputView = vv
        
        textView.inputAccessoryView = v
        
        self.view.addTap(target: self, action: #selector(didTap))
    }
    
    @objc func didTap() {
        self.view.endEditing(true)
    }


}
