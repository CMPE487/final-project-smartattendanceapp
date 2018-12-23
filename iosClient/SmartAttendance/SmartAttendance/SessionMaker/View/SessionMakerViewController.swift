//
//  SessionMakerViewController.swift
//  SmartAttendance
//
//  Created by Korhan Çağın Geboloğlu on 23/12/2018.
//  Copyright © 2018 Korhan Çağın Geboloğlu. All rights reserved.
//

import UIKit
import PopupDialog
class SessionMakerViewController: BaseController, SessionMakerViewInput {
    var timer = Timer()
    var startTime: Double = 0
    var time: Double = 0
    var output: SessionMakerViewOutput!

    lazy var logoImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "SignInLogo")
        view.contentMode = .scaleAspectFit
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var startButton: BaseButton = {
        let b = BaseButton()
        b.setTitle("Start Session", for: .normal)
        b.layer.borderColor = UIColor.white.cgColor
        b.layer.borderWidth = 1
        b.layer.cornerRadius = 20
        b.layer.masksToBounds = true
        b.backgroundColor = UIColor.clear
        b.addTarget(output, action: #selector(output.signUpButtonTriggered), for: .touchUpInside)
        return b
    }()
    lazy var finishButton: BaseButton = {
        let b = BaseButton()
        b.setTitle("Finish Session", for: .normal)
        b.layer.borderColor = UIColor.white.cgColor
        b.layer.borderWidth = 1
        b.layer.cornerRadius = 20
        b.layer.masksToBounds = true
        b.backgroundColor = UIColor.clear
        b.addTarget(output, action: #selector(output.backButtonTriggered), for: .touchUpInside)
        return b
    }()
    lazy var headerField : UILabel = {
        let infoView = UILabel()
        infoView.text = "Total Time:"
        infoView.backgroundColor = .clear
        infoView.textColor = UIColor.white
        infoView.textAlignment = .center
        infoView.layer.borderColor = UIColor.white.cgColor
        infoView.layer.borderWidth = 0.3
        infoView.layer.cornerRadius = 24
        infoView.addShadow()
        return infoView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    
    override func setupView() {
        view.addSubview(logoImageView)
        view.addSubview(startButton)
        view.addSubview(finishButton)
    }
    
    override func setupAnchor() {
        let leftConstantVal: CGFloat = 36
        let height = self.view.frame.height
        _ = logoImageView.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: height/12, leftConstant: self.view.frame.width/3, bottomConstant: 0, rightConstant: self.view.frame.width/3, widthConstant: 0, heightConstant:self.view.frame.width/3)
        
        _ = finishButton.anchor(nil, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, topConstant: 0, leftConstant: leftConstantVal, bottomConstant: height*0.075, rightConstant: leftConstantVal, widthConstant: 0, heightConstant: height*0.075)

        _ = startButton.anchor(nil, left: self.view.leftAnchor, bottom: finishButton.topAnchor, right: self.view.rightAnchor, topConstant: 0, leftConstant: leftConstantVal, bottomConstant: 16, rightConstant: leftConstantVal, widthConstant: 0, heightConstant: height*0.075)
    }
    
    
    override func setupEvent() {
        finishButton.isEnabled = false
    }
    func sessionStartedViewAdded(){
        self.view.addSubview(headerField)
        _ = headerField.anchor(self.view.topAnchor, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, topConstant: self.view.frame.height/2-24, leftConstant: leftConstant, bottomConstant: 0, rightConstant: rightConstant, widthConstant: 0, heightConstant: 48)
        startTime = Date().timeIntervalSinceReferenceDate
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(advanceTimer),
                                     userInfo: nil,
                                     repeats: true)
        
    }
    @objc func advanceTimer(timer: Timer) {
        
        //Total time since timer started, in seconds
        time = Date().timeIntervalSinceReferenceDate - startTime
    
        //The rest of your code goes here
        
        //Convert the time to a string with 2 decimal places
        let timeString = String(time.asString(style: .short))
        
        //Display the time string to a label in our view controller
        headerField.text = "Total Time: \(timeString)"
    }
    func timerInvadater(){
        timer = Timer()
        headerField.removeFromSuperview()
    }
    func showResultAlert() {
        let title = "Wifi Problem"
        let message = "You donot have wifi to connect,please connect wifi"
        let buttonOne = CancelButton(title: "Okey", action: nil)
        
        self.showCoolAlert(title: title, message: message, actions: [buttonOne])
    }
    
}
extension Double {
    func asString(style: DateComponentsFormatter.UnitsStyle) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second, .nanosecond]
        formatter.unitsStyle = style
        guard let formattedString = formatter.string(from: self) else { return "" }
        return formattedString
    }
}
