//
//  BaseUITextField.swift
//  RhExtranet
//
//  Created by Korhan Çağın Geboloğlu on 24.02.2018.
//  Copyright © 2018 AnadoluRH. All rights reserved.
//

import UIKit

/**
 
 **Usage:** Here is the one way to use this class.
 
 lazy var textField: BaseUITextField = {
 
 &nbsp;&nbsp;&nbsp;let textField = BaseUITextField()
 
 &nbsp;&nbsp;&nbsp;textField.placeHolderVal = "I am a placeholder text."
 
 &nbsp;&nbsp;&nbsp;return textField
 
 }()

 */
class BaseUITextField: UITextField {
    public var placeHolderVal = "" { didSet { setupPlaceHolder() } }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Fill this function according to your requirements.
    func setupView() {

    // Here some examples of design

    //        self.font = UIFont(name: Constants().baseFontName, size: 16.0)
    //        self.textColor = UIColor.black
    //        self.text = ""
    //        self.translatesAutoresizingMaskIntoConstraints = false
    //        self.layer.borderWidth = 0.2
    //        self.backgroundColor = UIColor.white
    //
    //        self.layer.cornerRadius = 24
    //        self.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
    //        self.addShadow()
    }

    private func setupPlaceHolder() {
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .left
        let attributedPlaceholder = NSAttributedString(string: "\(placeHolderVal)", attributes: [NSAttributedStringKey.paragraphStyle: centeredParagraphStyle, NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        self.attributedPlaceholder = attributedPlaceholder

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always

        self.textAlignment = .left
    }
}
