//
//  BaseCopyableLabel.swift
//  AS-BaseProject
//
//  Created by Korhan Çağın Geboloğlu on 8.09.2018.
//  Copyright © 2018 Korhan Çağın Geboloğlu. All rights reserved.
//
import UIKit
/**
    Label with the content copyability feature
    - Remark: Label perform actions rearranged
    - Precondition: if label content needs to be copied
    - Todo: Improve options
    - Version: 1.0.1
**/
class BaseCopyableLabel: UILabel {

    override public var canBecomeFirstResponder: Bool {
        return true
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }

    func sharedInit() {
        isUserInteractionEnabled = true
        addGestureRecognizer(UILongPressGestureRecognizer(
            target: self,
            action: #selector(showMenu(sender:))
        ))
    }

    override func copy(_ sender: Any?) {
        UIPasteboard.general.string = text
        UIMenuController.shared.setMenuVisible(false, animated: true)
    }

    @objc func showMenu(sender: Any?) {
        becomeFirstResponder()
        let menu = UIMenuController.shared
        if !menu.isMenuVisible {
            menu.setTargetRect(bounds, in: self)
            menu.setMenuVisible(true, animated: true)
        }
    }
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return action == #selector(copy(_:))
    }

    //    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    //        return (action == #selector(copy(_:))
    //    }
}
