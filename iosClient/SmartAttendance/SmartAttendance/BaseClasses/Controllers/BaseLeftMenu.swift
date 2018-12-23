//
//  File.swift
//  AS-BaseProject
//
//  Created by Korhan Çağın Geboloğlu on 12.09.2018.
//  Copyright © 2018 Korhan Çağın Geboloğlu. All rights reserved.
//

import UIKit

/**
 
 **Usage:** Here is the one way to use this class.
 
 // Left Menu Configuration
 
 lazy var leftMenu : BaseLeftMenuVC = {
 
  &nbsp;&nbsp;&nbsp;let leftMenu = BaseLeftMenuVC()
 
  &nbsp;&nbsp;&nbsp;leftMenu.relatedVC = self
 
  &nbsp;&nbsp;&nbsp;leftMenu.leftMenuView = MyPreciosUIView
 
  &nbsp;&nbsp;&nbsp;leftMenu.leftMenuWidthRatio = 0.9
 
  &nbsp;&nbsp;&nbsp;return leftMenu
 
 }()
 
 // Button that is responsible for opening the left menu - Example
 
 lazy var openLeftMenuButton : BaseButton = {
 
   &nbsp;&nbsp;&nbsp;let button = BaseButton()
 
   &nbsp;&nbsp;&nbsp;button.setTitle("CLICK ME TO ", for: .normal)
 
   &nbsp;&nbsp;&nbsp;button.frame = CGRect(x: 0, y: 32, width: 216, height: 36)
 
   &nbsp;&nbsp;&nbsp;button.setTitleColor(.black, for: .normal)
 
   &nbsp;&nbsp;&nbsp;button.addTarget(leftMenu, action: #selector(leftMenu.openLeftMenu), for: .touchUpInside)
 
    &nbsp;&nbsp;&nbsp;return button
 
 }()
 
 **Note:** Do not forget to add openLeftMenuButton to your view - view.addSubview(openLeftMenuButton)
 */

class BaseLeftMenuVC: UIViewController {
    public var relatedVC: UIViewController? = nil { didSet { setupLeftMenu() } }
    public var leftMenuView: UIView? = nil { didSet { view = leftMenuView } }
    public var leftMenuWidthRatio: CGFloat = 0.8 { didSet { setupLeftMenu() } }

    private var leftMenuLeftAnchor = NSLayoutConstraint()
    private var isLeftMenuOpen = false

    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height

    private lazy var blackFilter: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.isHidden = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(removeLeftMenu))
        view.addGestureRecognizer(gesture)
        return view
    }()

    override func viewDidLoad() {}

    private func setupLeftMenu() {
        view.removeFromSuperview(); blackFilter.removeFromSuperview()

        relatedVC?.view.addSubview(blackFilter)
        blackFilter.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)

        let leftMenuWidth = screenWidth * leftMenuWidthRatio

        relatedVC?.view.addSubview(view)
        leftMenuLeftAnchor = view.anchor(relatedVC?.view.topAnchor, left: relatedVC?.view.leftAnchor, bottom: relatedVC?.view.bottomAnchor, right: nil, topConstant: 0, leftConstant: -leftMenuWidth, bottomConstant: 0, rightConstant: 0, widthConstant: leftMenuWidth, heightConstant: 0)[1]
    }

    @objc public func openLeftMenu() {
        guard let relatedVC = relatedVC, leftMenuView != nil else {
            print("You need to set relatedVC and leftMenuView")
            return
        }

        if(isLeftMenuOpen) { return }

        relatedVC.view.bringSubview(toFront: blackFilter)
        relatedVC.view.bringSubview(toFront: view)

        isLeftMenuOpen = true
        leftMenuLeftAnchor.constant = 0
        blackFilter.isHidden = false

        UIView.animate(withDuration: 0.3, delay: 0.0, options: .beginFromCurrentState, animations: {
            relatedVC.view.layoutIfNeeded()
        }, completion: nil)
    }

    @objc public func removeLeftMenu() {
        guard let relatedVC = relatedVC, leftMenuView != nil else {
            print("You need to set relatedVC and leftMenuView")
            return
        }

        if(!isLeftMenuOpen) { return }

        isLeftMenuOpen = false
        leftMenuLeftAnchor.constant = -screenWidth*leftMenuWidthRatio
        blackFilter.isHidden = true

        UIView.animate(withDuration: 0.3, delay: 0.0, options: .beginFromCurrentState, animations: {
            relatedVC.view.layoutIfNeeded()
        }, completion: nil)
    }

}
