//
//  AttendClassViewController.swift
//  SmartAttendance
//
//  Created by Korhan Çağın Geboloğlu on 23/12/2018.
//  Copyright © 2018 Korhan Çağın Geboloğlu. All rights reserved.
//

import UIKit
import PopupDialog
class AttendClassViewController: BaseController, AttendClassViewInput {

    var output: AttendClassViewOutput!
    lazy var logoImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "SignInLogo")
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var signUpButton: BaseButton = {
        let b = BaseButton()
        b.setTitle("Attend Class", for: .normal)
        b.layer.borderColor = UIColor.white.cgColor
        b.layer.borderWidth = 1
        b.layer.cornerRadius = 20
        b.layer.masksToBounds = true
        b.backgroundColor = UIColor.clear
        b.addTarget(output, action: #selector(output.signUpButtonTriggered), for: .touchUpInside)
        return b
    }()
    

    lazy var emailTextField: LoginTextField = {
        let text = LoginTextField()
        text.customPlaceholder = "Id Field"
        return text
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }


    override func setupView() {
        view.addSubview(logoImageView)
        view.addSubview(signUpButton)
        view.addSubview(emailTextField)
    }

    override func setupAnchor() {
        let leftConstantVal: CGFloat = 36
        let height = self.view.frame.height
        textfieldAnchors(leftConstantVal)
        _ = logoImageView.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: height/12, leftConstant: self.view.frame.width/3, bottomConstant: 0, rightConstant: self.view.frame.width/3, widthConstant: 0, heightConstant:self.view.frame.width/3)
        _ = signUpButton.anchor(nil, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, topConstant: 0, leftConstant: leftConstantVal, bottomConstant: height*0.075, rightConstant: leftConstantVal, widthConstant: 0, heightConstant: height*0.075)
       
    }

    override func setupEvent() {

    }
    fileprivate func textfieldAnchors(_ leftConstantVal: CGFloat) {
        let width = self.view.frame.width-2*leftConstantVal
        let heightRatio = (self.view.frame.height/736.0)
        let height = 40*heightRatio
        _ = emailTextField.anchor(self.view.topAnchor, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, topConstant: 300*heightRatio, leftConstant: leftConstantVal, bottomConstant: 0, rightConstant: leftConstantVal, widthConstant: 0, heightConstant: height)
        emailTextField.updateFrame(width: width, height: height)
    }
    func showEmptyFieldAlert() {
        let title = "Empty Request"
        let message = "Please fill id field"
        
        let buttonOne = CancelButton(title: "Okey", action: nil)
        
        self.showCoolAlert(title: title, message: message, actions: [buttonOne])
    }
    func showResultAlert(message:String) {
        let title = "Attend Request Result"
        
        let buttonOne = CancelButton(title: "Okey", action: nil)
        
        self.showCoolAlert(title: title, message: message, actions: [buttonOne])
    }
    func showConfirm(message:String){
        showCoolAlert(title: "Confirm", message:message, actions: [CancelButton(title: "Okey", action: {
            self.output.send()
        }),CancelButton(title: "Cancel", action:nil)])
    }
}
