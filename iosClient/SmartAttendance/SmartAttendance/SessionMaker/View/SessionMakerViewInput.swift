//
//  SessionMakerSessionMakerViewInput.swift
//  SmartAttendance
//
//  Created by Korhan Çağın Geboloğlu on 23/12/2018.
//  Copyright © 2018 Korhan Çağın Geboloğlu. All rights reserved.
//
import UIKit

protocol SessionMakerViewInput: BaseViewInput {
    // Variables
    var logoImageView: UIImageView {get set}
    var startButton: BaseButton {get set}
    var finishButton: BaseButton {get set}
    // Functions
    func sessionStartedViewAdded()
    func showResultAlert()
}
