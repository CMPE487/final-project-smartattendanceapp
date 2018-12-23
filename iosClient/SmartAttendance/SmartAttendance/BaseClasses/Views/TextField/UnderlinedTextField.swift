//
//  UnderlinedTextField.swift
//  ITUSirlari
//
//  Created by Korhan Çağın Geboloğlu on 22.07.2018.
//  Copyright © 2018 Korhan Çağın Geboloğlu. All rights reserved.
//

import UIKit

/**

 **Usage:** Here is the one way to use this class.
 
 lazy var underlinedTextField: UnderlinedTextField = {
 
 &nbsp;&nbsp;&nbsp;let uTF = UnderlinedTextField()
 
 &nbsp;&nbsp;&nbsp;uTF.underLineColor = .yellow
 
 &nbsp;&nbsp;&nbsp;uTF.underLineHeight = 2
 
 &nbsp;&nbsp;&nbsp;uTF.placeHolder = "Fill Me Please"
 
 &nbsp;&nbsp;&nbsp;uTF.placeHolderColor = .red
 
 &nbsp;&nbsp;&nbsp;return uTF
 
 }()
 
 **Note:** You can take the height of 36.
 */
class UnderlinedTextField: UITextField {
    public var underLineColor = UIColor.black { didSet { setupTextField() } }
    public var underLineHeight = CGFloat(0.5) { didSet { setupTextField() } }
    public var placeHolder = "" { didSet { setupTextField() } }
    public var placeHolderColor = UIColor.lightGray { didSet { setupTextField() } }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTextField() {
        self.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [
            NSAttributedStringKey.foregroundColor: placeHolderColor
            ])

        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = underLineColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: underLineHeight)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }

}
