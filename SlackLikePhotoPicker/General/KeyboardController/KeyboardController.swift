//
//  KeyboardController.swift
//  EventWorks
//
//  Created by 長内幸太郎 on 2018/05/12.
//  Copyright © 2018年 osanai.sample.eventworks. All rights reserved.
//

import Foundation
import UIKit

enum TargetViewType {
    case noView
    case scrollView
    case textView
    case tableView
}

class KeyboardController {
    
    var isKeyboardShowing:Bool = false
    
    var type:TargetViewType?
    var defaultInsets:UIEdgeInsets?
    var kbSize:CGSize?
    
    var targetScrollView:UIScrollView?
    var targetTextView:UITextView?
    var targetTableView:UITableView?
    
    var targetViewForShowingWithScroll:UIView?
    
    var keyboardWillShowClosure:((_ notification: NSNotification) -> ())?
    var keyboardWasShownClosure:((_ notification: NSNotification) -> ())?
    var keyboardWillHideClosure:((_ notification: NSNotification) -> ())?
    var keyboardDidHideClosure:((_ notification: NSNotification) -> ())?
    
    
    func setup(targetView:UIView) {
        
        if (targetView is UIScrollView) {
            type = .scrollView
            targetScrollView = (targetView as! UIScrollView)
            defaultInsets = targetScrollView?.contentInset
        }
        
        if (targetView is UITextView) {
            type = .textView
            targetTextView = (targetView as! UITextView)
            defaultInsets = targetTextView?.contentInset
        }
        
        if (targetView is UITableView) {
            type = .tableView
            targetTableView = (targetView as! UITableView)
            defaultInsets = targetTableView?.contentInset
        }
        
        // typeを追加する場合ここに追記
        
    }
    
    func setTargetViewForShowingWithScroll(targetView:UIView) {
        targetViewForShowingWithScroll = targetView
    }
    
    func targetView() -> UIView? {
        
        if (type == .scrollView) {
            return targetScrollView
        }
        
        if (type == .textView) {
            return targetTextView
        }
        
        if (type == .tableView) {
            return targetTableView
        }
        
        // typeを追加する場合ここに追記
 
        return nil
    }
    
    func setupKeyboardNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: .UIKeyboardWillShow,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWasShown),
                                               name: .UIKeyboardDidShow,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: .UIKeyboardWillHide,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardDidHide),
                                               name: .UIKeyboardDidHide,
                                               object: nil)
        
    }
    
    func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardDidHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let rect = notification.userInfo![UIKeyboardFrameEndUserInfoKey]! as! CGRect
        kbSize = rect.size
        
        print("[\(#function)] line: \(#line) | \(rect.size)")
        
        isKeyboardShowing = true
        
        if let keyboardWillShowClosure = keyboardWillShowClosure {
            keyboardWillShowClosure(notification)
        }
    }
    @objc func keyboardWasShown(notification: NSNotification) {
        let rect = notification.userInfo![UIKeyboardFrameEndUserInfoKey]! as! CGRect
        kbSize = rect.size
        
        print("[\(#function)] line: \(#line) | \(rect.size)")

        guard let targetView = targetView() else {
            return
        }

        let contentInset = UIEdgeInsetsMake(0, 0, overlapKeyboardHeight()+12, 0)
        var aRect = targetView.frame
        aRect.size.height -= (kbSize?.height)!
        
        refreshContentInset(contentInset: contentInset)
        scrollToShowTargetView(notification: notification)
        
        if let keyboardWasShownClosure = keyboardWasShownClosure {
            keyboardWasShownClosure(notification)
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        
        if (type == .noView) {
            return
        }
        
        if (type == .scrollView) {
            targetScrollView?.contentInset = defaultInsets!
            targetScrollView?.scrollIndicatorInsets = defaultInsets!
        }
        if (type == .textView) {
            targetTextView?.contentInset = defaultInsets!
            targetTextView?.scrollIndicatorInsets = defaultInsets!
        }
        if (type == .tableView) {
            targetTableView?.contentInset = defaultInsets!
            targetTableView?.scrollIndicatorInsets = defaultInsets!
        }

        // typeを追加する場合ここに追記
        
        if let keyboardWillHideClosure = keyboardWillHideClosure {
            keyboardWillHideClosure(notification)
        }
    }
    @objc func keyboardDidHide(notification: NSNotification) {
        let rect = notification.userInfo![UIKeyboardFrameEndUserInfoKey]! as! CGRect
        kbSize = rect.size
        
        isKeyboardShowing = false
        
        if let keyboardDidHideClosure = keyboardDidHideClosure {
            keyboardDidHideClosure(notification)
        }
    }
    
    func refreshContentInset(contentInset:UIEdgeInsets) {
        if (type == .scrollView) {
            targetScrollView?.contentInset = contentInset
            targetScrollView?.scrollIndicatorInsets = contentInset
        }
        if (type == .textView) {
            targetTextView?.contentInset = contentInset
            targetTextView?.scrollIndicatorInsets = contentInset
        }
        if (type == .tableView) {
            targetTableView?.contentInset = contentInset
            targetTableView?.scrollIndicatorInsets = contentInset
        }
        
        // typeを追加する場合ここに追記
    }

    func scrollToShowTargetView(notification:NSNotification) {
        guard let _ = targetViewForShowingWithScroll else {
            return
        }
        
        if (type == .scrollView) {
            UIView.beginAnimations(nil, context: nil);

            let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey]! as! Double
            let curve = notification.userInfo![UIKeyboardAnimationCurveUserInfoKey]! as! Int
            let rect = notification.userInfo![UIKeyboardFrameEndUserInfoKey]! as! CGRect
            
            UIView.setAnimationDuration(duration)
            UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: curve)!)
            UIView.setAnimationBeginsFromCurrentState(true)
            
            kbSize = rect.size
            let scHeight = UIScreen.main.bounds.size.height
            
//            [targetViewForShowingWithScroll convertRect:targetViewForShowingWithScroll.bounds
//                toView:targetViewForShowingWithScroll.window]);
            
            
            let keyboardOriginYOnScreen = scHeight - (kbSize?.height)!
            let targetMaxYOnScreen = targetViewForShowingWithScroll?.convert((targetViewForShowingWithScroll?.bounds)!,
                                                                             to: targetViewForShowingWithScroll?.window).origin.y
            let idealShiftPoint = targetMaxYOnScreen! - keyboardOriginYOnScreen
            var nextOffSetY = (targetScrollView?.contentOffset.y)! + idealShiftPoint
            
            if (nextOffSetY < (targetScrollView?.contentInset.top)! * -1 ) {
                nextOffSetY = (targetScrollView?.contentInset.top)! * -1
            }
            
            /*下へスクロール出来る限界量を超えた場合は、(現状はcontentInsetを最初に修正しているため現実装ではありえないが、一応コメントアウト
             if (nextOffSetY + targetScrollView.frame.size.height > targetScrollView.contentSize.height + targetScrollView.contentInset.bottom ) {
             }
             */
            
            targetScrollView?.setContentOffset(CGPoint(x: 0, y: nextOffSetY), animated: false)
            UIView.commitAnimations()
        }
        
    }
    
    func targetRectInWindow() -> CGRect {
        
        guard let targetView = targetView() else {
            return CGRect.zero
        }
        
        if let fixedCoodinateSpace = targetView.superview?.window?.screen.fixedCoordinateSpace {
            let rect = targetView.superview?.convert(targetView.frame,
                                                     to: fixedCoodinateSpace)
            
            return rect!
        }
        
        return CGRect.zero
    }
    
    // 対象のviewと、keyboardの被る高さを返す
    func overlapKeyboardHeight() -> CGFloat {
        let targetRect = self.targetRectInWindow()
        let targetBottom = targetRect.origin.y + targetRect.size.height
        let overlap = max(targetBottom + keyboardHeight() - UIScreen.main.bounds.size.height, 0)
        return overlap
    }
    
    func keyboardHeight() -> CGFloat {
        return (kbSize?.height)!
    }

    
}
