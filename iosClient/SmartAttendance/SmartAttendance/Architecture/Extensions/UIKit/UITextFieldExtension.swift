//
//  UITextFieldExtension.swift
//  AS-BaseProject
//
//  Created by Korhan Çağın Geboloğlu on 11.09.2018.
//  Copyright © 2018 Korhan Çağın Geboloğlu. All rights reserved.
//

import UIKit

extension UITextField {
    private struct AssociatedKeys {
        static var isPasteEnabled = true
        static var maxCharecter = Int.max
    }
    var isPasteEnabled: Bool? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.isPasteEnabled) as? Bool ?? true
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.isPasteEnabled, newValue as Bool?, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    var maxCharecter: Int? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.maxCharecter) as? Int ?? Int.max
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.maxCharecter, newValue as Int?, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            if isPasteEnabled != nil {
                return isPasteEnabled!
            } else {
                return true
            }
        }
        return super.canPerformAction(action, withSender: sender)
    }
    func addDoneButtonOnKeyboard() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        toolbar.barTintColor = UIColor.blue

        toolbar.tintColor = UIColor.white

        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Tamam", style: UIBarButtonItemStyle.done, target: self, action: #selector(doneButtonAction))

        doneButton.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.white], for: .normal)

        toolbar.setItems([spaceButton, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        self.inputAccessoryView = toolbar
    }
    @objc private func doneButtonAction() {
        self.resignFirstResponder()
    }
    /**
        <#Title#>

        - Parameter placeHolder: <#description#>
        - Parameter color: <#description#>
        - Parameter textAlignment: <#description#>

        - Remark: <#Remark#>

        - SeeAlso: <#SeeAlso#>

        - Precondition: <#Precondition#>

        - Requires: <#Requires#>

        - Todo: <#Todo#>

        - Warning: <#Warning#>

        - Version: <#Version#>

        - Note: <#Note#>
    **/
    func setupPlaceHolderFilter(placeHolder: String, color: UIColor = UIColor.lightGray, textAlignment: NSTextAlignment = .center) {
        self.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedStringKey.foregroundColor: color])
        self.textAlignment = textAlignment
    }
    func setLeftIcon(_ icon: UIImage, outerViewSize: Int=24, padding: Int=16) {
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: outerViewSize, height: outerViewSize) )
        let iconView  = UIImageView(frame: CGRect(x: padding, y: 0, width: outerViewSize, height: outerViewSize))
        iconView.image = icon
        outerView.addSubview(iconView)
        leftView = outerView
        leftViewMode = .always
    }

    func setRightIcon(_ icon: UIImage, outerViewSize: Int=24, padding: Int = -16) {
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: outerViewSize, height: outerViewSize) )
        let iconView  = UIImageView(frame: CGRect(x: padding, y: 0, width: outerViewSize, height: outerViewSize))
        iconView.image = icon
        outerView.addSubview(iconView)
        rightView = outerView
        rightViewMode = .always
    }
    func keyboardType(inputType: String) {
        let keyboardType: UIKeyboardType
        switch inputType {
        case "text":
            keyboardType = .default
        case "number":
            if #available(iOS 10.0, *) {
                keyboardType = .asciiCapableNumberPad
            } else {
                // Fallback on earlier versions
                keyboardType = .numberPad
            }
        case "date":
            keyboardType =  .numberPad
        case "percentage":
            keyboardType = .numberPad
        default:
            keyboardType = .default
        }
        self.keyboardType = keyboardType
    }
}
