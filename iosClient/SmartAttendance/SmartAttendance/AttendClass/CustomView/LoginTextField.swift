//
//  LoginLoginExampleCostumView.swift
//  SmartAttendance
//
//  Created by korhan çağın geboloğlu on 22/12/2018.
//  Copyright © 2018 Korhan Çağın Geboloğlu. All rights reserved.
//


/// This is an example view. This view is going to be deleted, probably.
/// However, CustomView is responsible for creating reusable views for the related View Controller.
/// Hence, if you are going to use the same view, again and again, create a custom view in here and use it.
import UIKit
class LoginTextField:UITextField {
    private var height: CGFloat = 50
    private var width: CGFloat = 342
    private let activeBorderLayer = CALayer()
    private let borderThickness: (active: CGFloat, inactive: CGFloat) = (active: 2, inactive: 0.5)
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Left Padding
        self.leftViewMode = .always
        self.textColor = UIColor.white
        self.textAlignment = .left
        self.backgroundColor = UIColor.clear
    }
    var customPlaceholder: String? {
        didSet {
            self.attributedPlaceholder = NSAttributedString(string: customPlaceholder!,
                                                            attributes: [
                                                                NSAttributedStringKey.foregroundColor: UIColor.white.withAlphaComponent(0.7)
                ])
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func rectForBorder(_ thickness: CGFloat, isFilled: Bool) -> CGRect {
        
        if isFilled {
            return CGRect(origin: CGPoint(x: 0, y: height-thickness), size: CGSize(width: width, height: thickness))
        } else {
            return CGRect(origin: CGPoint(x: 0, y: frame.height-thickness), size: CGSize(width: 0, height: thickness))
        }
    }
    func updateFrame(width: CGFloat, height: CGFloat) {
        self.height = height
        self.width = width
        activeBorderLayer.backgroundColor = UIColor.white.cgColor
        activeBorderLayer.borderColor = UIColor.white.cgColor
        activeBorderLayer.frame = rectForBorder(borderThickness.active, isFilled: true)
        self.layer.addSublayer(activeBorderLayer)
    }

}
