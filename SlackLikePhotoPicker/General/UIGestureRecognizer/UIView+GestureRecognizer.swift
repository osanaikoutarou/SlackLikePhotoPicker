//
//  UIView+GestureRecognizer.swift
//  SlackLikePhotoPicker
//
//  Created by osanai on 2018/11/20.
//  Copyright © 2018年 osanai. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addTap(target: Any?, action: Selector?) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
}
