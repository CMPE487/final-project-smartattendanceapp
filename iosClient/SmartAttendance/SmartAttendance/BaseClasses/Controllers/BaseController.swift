//
//  BaseController.swift
//  AS-BaseProject
//
//  Created by Korhan Çağın Geboloğlu on 10.09.2018.
//  Copyright © 2018 Korhan Çağın Geboloğlu. All rights reserved.
//

import UIKit
class BaseController: UIViewController, UINavigationControllerDelegate,BaseViewInput {
    func showActivityLoader(willLoad: Bool) {
        print("***************************************************")
        print("Import the neccessary Activity Indicator")
        print("BaseClasses/Controllers/BaseController")
        print("***************************************************")
//        if(animate) {
//            ActivityLoaderControl.sharedInstance.showLoaders(holdingView: self.view)
//        } else {
//            ActivityLoaderControl.sharedInstance.removeLoader()
//        }
    }
    /// static top constant for all views
    let topConstant = CGFloat(125)
    /// static left constant for all views
    let leftConstant = CGFloat(18)
    /// static right constant for all views
    let rightConstant = CGFloat(18)
    /// static button height for all views
    let buttonHeightConstant = CGFloat(48)
    /// static font for all views
    let baseFont = UIFont.systemFont(ofSize: 18)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.delegate = self
        setupHeadView()
        setupView()
        setupAnchor()
        setupEvent()
        self.view.applyGradient(withColours:  [UIColor.rgb(56, green: 164, blue: 220).cgColor,UIColor.rgb(0, green: 150, blue: 136).cgColor], gradientOrientation: .vertical, width: self.view.frame.width, height: self.view.frame.height, corner: 0)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    /**
     Declare static differences in the view to create the generic theme of application
     - Remark: add neccessary items in order to create the generic theme of application
     - Warning: Do not override if the view has certain differences between the generic theme of application
     - Version: 1.0.1
     */
    func setupHeadView() {
        //        let gradient = CAGradientLayer()
        //        gradient.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100)
        //        gradient.locations = [0.0,1.0]
        //        gradient.colors = [UIColor.rgb( 0, green: 51, blue: 160).cgColor, UIColor.rgb(2,green: 166,blue: 245).cgColor]
        //        gradient.startPoint = GradientOrientation.vertical.startPoint//CGPoint(x: 0, y: 0)
        //        gradient.endPoint = GradientOrientation.vertical.endPoint//CGPoint(x: 1, y: 1)
        //        //(red:0.01, green:0.66, blue:0.96, alpha:1.0)
        //        //UIColor(red:0.00, green:0.90, blue:1.00, alpha:1.0)
        //        self.view.backgroundColor = UIColor.white
        //        self.view.layer.addSublayer(gradient)
    }

    /**
     Declare which view will be added to which view
     define customizable features
     - Remark: override for any controller, do not add frame or constraint declaration in here
     - Version: 1.0.1
     */
    func setupView() {

    }

    /**
     Declare the exact position of views on the screen
     - Remark: override for any controller,just add frame or constraint declaration in here
     - Precondition: Declaration of Call `setupViews()`
     - Warning: Be aware of the need for redefinition at orientation changed
     - Version: 1.0.1
     */
    func setupAnchor() {

    }

    /// Declare actions that is not related with view.
    func setupEvent() {

    }
}
