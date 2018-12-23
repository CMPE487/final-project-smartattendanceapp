//
//  File.swift
//  AS-BaseProject
//
//  Created by Korhan Çağın Geboloğlu on 14.09.2018.
//  Copyright © 2018 Korhan Çağın Geboloğlu. All rights reserved.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
        setupAnchor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    internal func setupView() {

    }

    internal func setupAnchor() {

    }
}
