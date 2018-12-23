//
//  File.swift
//  AS-BaseProject
//
//  Created by Korhan Çağın Geboloğlu on 11.09.2018.
//  Copyright © 2018 Korhan Çağın Geboloğlu. All rights reserved.
//

import UIKit

class BaseButton: BadgeButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Fill this function according to your requirements.
    private func setupViews() {
// Some examples of design
//        self.setTitleColor(.white, for: .normal)
//        self.titleLabel?.font = UIFont(name: Constants().baseFontName, size: 16.0)
//        self.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
//        self.layer.borderWidth = 0.2
//        self.layer.cornerRadius = 5
//        self.imageView?.contentMode = .scaleAspectFit
//        self.imageView?.tintColor = UIColor.white
//        self.setTitleColor(UIColor(red:0.05, green:0.28, blue:0.63, alpha:1.0) , for: .normal)
//        self.badgeBackgroundColor = UIColor.rgb(244, green:100, blue:35)
//        self.badgeEdgeInsets = UIEdgeInsetsMake(0 , 0 , 0 , 0)
    }
}
