//
//  AttendClassAttendClassPresenter.swift
//  SmartAttendance
//
//	Present the responses of the interactor
//  Operate the view logic
//  Route the neccessary flows
// 	Pass the data collected from the view
//
//  Created by Korhan Çağın Geboloğlu on 23/12/2018.
//  Copyright © 2018 Korhan Çağın Geboloğlu. All rights reserved.
//

/// This class is the connection of View, Interactor.
class AttendClassPresenter: AttendClassModuleInput, AttendClassViewOutput, AttendClassInteractorOutput {
    func send() {
        interactor.attendClass(id: view.emailTextField.text!)
    }
    
    func result(message: String) {
        view.showResultAlert(message:message)
    }
    
    func signUpButtonTriggered() {
        if view.emailTextField.text == "" {
            view.showEmptyFieldAlert()
        }else{
            view.showConfirm(message: "Do you confim yourID as \(view.emailTextField.text!)")
        }
    }
    
    weak var view: AttendClassViewInput!
    var interactor: AttendClassInteractorInput!
    var router: AttendClassRouterInput!

    func viewIsReady() {
    	interactor.fetchData()
    }
}
