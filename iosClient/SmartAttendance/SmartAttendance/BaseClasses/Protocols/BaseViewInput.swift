//
//  BaseViewInput.swift
//  AS-BaseProject
//
//  Created by Korhan Çağın Geboloğlu on 14.12.2018.
//  Copyright © 2018 Korhan Çağın Geboloğlu. All rights reserved.
//

import UIKit
import PopupDialog
protocol BaseViewInput:class {
    func setupAnchor()
    func setupView()
    func showActivityLoader(willLoad: Bool)
    func transitionMaker(rootController: UIViewController, duration: TimeInterval)
}
