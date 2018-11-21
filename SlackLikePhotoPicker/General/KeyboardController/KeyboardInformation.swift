//
//  KeyboardInformation.swift
//  SlackLikePhotoPicker
//
//  Created by osanai on 2018/11/21.
//  Copyright © 2018年 osanai. All rights reserved.
//

import UIKit

class KeyboardInformation: NSObject {
    static let shared = KeyboardInformation()
    var kbSize:CGSize = .zero
}

extension UIViewController {
    // call in viewDidLoad
    func keyboardInformationSetup() {
        let textView = UITextView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        view.addSubview(textView)
        let kc = KeyboardController()
        kc.setup(targetView: textView)
        kc.setupKeyboardNotification()
        textView.becomeFirstResponder()
        kc.setup(targetView: textView)
        kc.kbSizeDidSet = {
            if (KeyboardInformation.shared.kbSize.height < kc.kbSize!.height) {
                KeyboardInformation.shared.kbSize = kc.kbSize!
            }
            textView.resignFirstResponder()
            textView.removeFromSuperview()
        }
    }
}
