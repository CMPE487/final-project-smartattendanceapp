//
//  AttendClassAttendClassViewInput.swift
//  SmartAttendance
//
//  Created by Korhan Çağın Geboloğlu on 23/12/2018.
//  Copyright © 2018 Korhan Çağın Geboloğlu. All rights reserved.
//
import UIKit

protocol AttendClassViewInput: BaseViewInput {
    // Variables
    var logoImageView: UIImageView {get set}
    var signUpButton: BaseButton {get set}
    var emailTextField: LoginTextField {get set}
    // Functions
    func showEmptyFieldAlert()
    func showResultAlert(message:String)
    func showConfirm(message:String)
}
